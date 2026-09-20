import * as vscode from 'vscode';
import { logger } from './main/utils/Logger';
import { containsPath } from './main/utils/pathUtils';
import { ChangelogPanel } from './main/webviews/ChangelogPanel';

const LUA_EXTENSION_ID = 'sumneko.lua';
const INSTALLED_LIBRARY_VERSION_KEY = 'kontaktLua.library.installedVersion';
const CHANGELOG_VERSION_KEY = 'kontaktLua.changelog.lastShownVersion';


export async function activate(context: vscode.ExtensionContext): Promise<void> {
	logger.info('Activating Kontakt API Plugin...');

	context.subscriptions.push(
		logger,
		{ dispose: () => ChangelogPanel.disposeCurrent() },
		vscode.commands.registerCommand('kontaktLua.showChangelog', () => {
			ChangelogPanel.createOrShow(context);
		}),
		vscode.commands.registerCommand('kontaktLua.initialize', async () => {
			await runInitialization(context, true);
		})
	);

	if (!vscode.extensions.getExtension(LUA_EXTENSION_ID)) {
		logger.error(`Required extension ${LUA_EXTENSION_ID} is unavailable.`);
		await vscode.window.showErrorMessage(
			'Kontakt API Tools requires the Lua Language Server extension. Please enable or reinstall it.'
		);
	} else {
		logger.info('Lua Language Server extension is available.');
		const refreshDevelopmentLibrary = context.extensionMode === vscode.ExtensionMode.Development;
		if (refreshDevelopmentLibrary) {
			logger.info('Development mode detected; refreshing bundled API definitions.');
		}
		await runInitialization(context, refreshDevelopmentLibrary);
	}

	try {
		await showChangelogIfUpdated(context);
	} catch (error) {
		logger.error('Failed to show the changelog', error);
	}

	logger.info('Kontakt API Plugin activated.');
}


async function runInitialization(
	context: vscode.ExtensionContext,
	forceLibraryCopy: boolean
): Promise<void> {
	try {
		await initializeKontaktLua(context, forceLibraryCopy);
	} catch (error) {
		logger.error('Kontakt Lua initialization failed', error);
		const choice = await vscode.window.showErrorMessage(
			'Kontakt Lua API initialization failed. See the Kontakt Lua API output for details.',
			'Show Output'
		);
		if (choice === 'Show Output') {
			logger.show();
		}
	}
}


async function showChangelogIfUpdated(context: vscode.ExtensionContext): Promise<void> {
	const extensionVersion = String(context.extension.packageJSON.version ?? '');
	const lastShownVersion = context.globalState.get<string>(CHANGELOG_VERSION_KEY);

	if (extensionVersion && lastShownVersion !== extensionVersion) {
		await vscode.commands.executeCommand('kontaktLua.showChangelog');
		await context.globalState.update(CHANGELOG_VERSION_KEY, extensionVersion);
	}
}


/**
 * Synchronizes the bundled definitions into global storage and registers the
 * stable copy with LuaLS.
 */
async function initializeKontaktLua(
	ctx: vscode.ExtensionContext,
	forceLibraryCopy: boolean
): Promise<void> {
	const targetLib = await synchronizeBundledLibrary(ctx, forceLibraryCopy);
	await ensureLuaWorkspaceLibrary(targetLib);
	logger.info('Kontakt Lua API initialized.');
}


async function synchronizeBundledLibrary(
	ctx: vscode.ExtensionContext,
	force: boolean
): Promise<vscode.Uri> {
	const extensionVersion = String(ctx.extension.packageJSON.version ?? 'unknown');
	const installedVersion = ctx.globalState.get<string>(INSTALLED_LIBRARY_VERSION_KEY);
	const targetRoot = vscode.Uri.joinPath(ctx.globalStorageUri, 'kontakt-lua-api');
	const targetLib = vscode.Uri.joinPath(targetRoot, 'library');

	if (!force && installedVersion === extensionVersion && await uriExists(targetLib)) {
		logger.debug(`Bundled library ${extensionVersion} is already installed.`);
		return targetLib;
	}

	const stagingRoot = vscode.Uri.joinPath(
		ctx.globalStorageUri,
		`kontakt-lua-api-staging-${process.pid}`
	);
	const stagingLib = vscode.Uri.joinPath(stagingRoot, 'library');
	const sourceLib = vscode.Uri.joinPath(ctx.extensionUri, 'add-on', 'library');

	await deleteIfPresent(stagingRoot);
	await copyDirRecursive(sourceLib, stagingLib);

	try {
		await deleteIfPresent(targetRoot);
		await vscode.workspace.fs.rename(stagingRoot, targetRoot, { overwrite: true });
	} catch (error) {
		await deleteIfPresent(stagingRoot);
		throw error;
	}

	await ctx.globalState.update(INSTALLED_LIBRARY_VERSION_KEY, extensionVersion);
	logger.info(`Installed Kontakt Lua API library ${extensionVersion}.`);
	return targetLib;
}


/**
 * Recursively copies a directory from src to dst and overwrites existing files.
 */
async function copyDirRecursive(src: vscode.Uri, dst: vscode.Uri): Promise<void> {
	await vscode.workspace.fs.createDirectory(dst);

	const entries = await vscode.workspace.fs.readDirectory(src);
	for (const [name, type] of entries) {
		const source = vscode.Uri.joinPath(src, name);
		const destination = vscode.Uri.joinPath(dst, name);

		if ((type & vscode.FileType.Directory) !== 0) {
			await copyDirRecursive(source, destination);
		} else if ((type & vscode.FileType.File) !== 0) {
			logger.debug(`Copying ${source.fsPath} to ${destination.fsPath}`);
			await vscode.workspace.fs.copy(source, destination, { overwrite: true });
		} else {
			logger.warn(`Skipping unsupported library entry: ${source.toString()}`);
		}
	}
}


async function uriExists(uri: vscode.Uri): Promise<boolean> {
	try {
		await vscode.workspace.fs.stat(uri);
		return true;
	} catch {
		return false;
	}
}


async function deleteIfPresent(uri: vscode.Uri): Promise<void> {
	if (await uriExists(uri)) {
		await vscode.workspace.fs.delete(uri, { recursive: true, useTrash: false });
	}
}


/**
 * Ensures that the stable library path is present in the global LuaLS setting.
 * Existing workspace and folder overrides are never changed without consent.
 */
async function ensureLuaWorkspaceLibrary(libraryUri: vscode.Uri): Promise<void> {
	const libPath = libraryUri.fsPath;
	const cfg = vscode.workspace.getConfiguration('Lua');
	const inspected = cfg.inspect<string[]>('workspace.library');
	if (!inspected) {
		throw new Error('Lua.workspace.library is not registered by the Lua Language Server.');
	}

	const globalLibraries = inspected.globalValue ?? [];
	if (!containsPath(globalLibraries, libPath)) {
		await cfg.update(
			'workspace.library',
			[...globalLibraries, libPath],
			vscode.ConfigurationTarget.Global
		);
	}

	await offerToFixWorkspaceOverrides(libPath);
}


interface LibraryOverride {
	configuration: vscode.WorkspaceConfiguration;
	target: vscode.ConfigurationTarget.Workspace | vscode.ConfigurationTarget.WorkspaceFolder;
	values: string[];
	label: string;
}


async function offerToFixWorkspaceOverrides(libPath: string): Promise<void> {
	const overrides = collectBlockingLibraryOverrides(libPath);
	if (overrides.length === 0) {
		return;
	}

	const choice = await vscode.window.showWarningMessage(
		'An existing workspace setting overrides Lua.workspace.library, so the Kontakt API definitions are not active here.',
		'Add Kontakt Library',
		'Open Settings'
	);

	if (choice === 'Add Kontakt Library') {
		for (const override of overrides) {
			await override.configuration.update(
				'workspace.library',
				[...override.values, libPath],
				override.target
			);
			logger.info(`Added Kontakt API definitions to ${override.label}.`);
		}
	} else if (choice === 'Open Settings') {
		await vscode.commands.executeCommand(
			'workbench.action.openSettings',
			'@id:Lua.workspace.library'
		);
	}
}


function collectBlockingLibraryOverrides(libPath: string): LibraryOverride[] {
	const overrides: LibraryOverride[] = [];
	const workspaceConfiguration = vscode.workspace.getConfiguration('Lua');
	const workspaceInspection = workspaceConfiguration.inspect<string[]>('workspace.library');

	if (
		workspaceInspection?.workspaceValue
		&& !containsPath(workspaceInspection.workspaceValue, libPath)
	) {
		overrides.push({
			configuration: workspaceConfiguration,
			target: vscode.ConfigurationTarget.Workspace,
			values: workspaceInspection.workspaceValue,
			label: 'workspace settings',
		});
	}

	for (const folder of vscode.workspace.workspaceFolders ?? []) {
		const folderConfiguration = vscode.workspace.getConfiguration('Lua', folder.uri);
		const folderInspection = folderConfiguration.inspect<string[]>('workspace.library');
		if (
			folderInspection?.workspaceFolderValue
			&& !containsPath(folderInspection.workspaceFolderValue, libPath)
		) {
			overrides.push({
				configuration: folderConfiguration,
				target: vscode.ConfigurationTarget.WorkspaceFolder,
				values: folderInspection.workspaceFolderValue,
				label: `workspace folder "${folder.name}"`,
			});
		}
	}

	return overrides;
}


// This method is called when your extension is deactivated.
export function deactivate() {}
