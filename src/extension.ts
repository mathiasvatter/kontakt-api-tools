import * as vscode from 'vscode';
import { logger } from './main/utils/Logger';
import { ChangelogPanel } from './main/webviews/ChangelogPanel';


export async function activate(context: vscode.ExtensionContext) {
	logger.info('Activating Kontakt API Plugin...');
	// Check if Lua Language Server extension is installed/enabled
	const luaExtId = "sumneko.lua";
	const luaExt = vscode.extensions.getExtension(luaExtId);

	if (!luaExt) {
		const choice = await vscode.window.showWarningMessage(
			"Lua Language Server (sumneko.lua) is not installed. Install it to enable Kontakt Lua autocomplete.",
			"Install",
			"Later"
		);

		if (choice === "Install") {
			await vscode.commands.executeCommand("workbench.extensions.installExtension", luaExtId);
		}
		return;
	} else {
		logger.info("Lua Language Server extension is installed.");
	}

	if (!luaExt.isActive) {
		await luaExt.activate();
	}

	context.subscriptions.push(
		vscode.commands.registerCommand('kontaktLua.showChangelog', () => {
			ChangelogPanel.createOrShow(context);
		})
	);
	context.subscriptions.push(
		vscode.commands.registerCommand("kontaktLua.initialize", async () => {
			try {
				await initializeKontaktLua(context);
			} catch (err) {
				logger.error("Kontakt Lua init failed", err);
				vscode.window.showErrorMessage(
					"Kontakt Lua API initialization failed. See console."
				);
			}
		})
	);

	await initializeKontaktLua(context);
	showChangelogIfUpdated(context);
	logger.info('Kontakt API Plugin activated.');

}

function showChangelogIfUpdated(context: vscode.ExtensionContext) {
	const extensionVersion = context.extension.packageJSON.version;
	const lastShownKey = 'kontaktLua.changelog.lastShownVersion';
	const lastShownVersion = context.globalState.get<string | undefined>(lastShownKey);

	if (lastShownVersion !== extensionVersion) {
		setTimeout(() => {
			vscode.commands.executeCommand('kontaktLua.showChangelog');
			void context.globalState.update(lastShownKey, extensionVersion);
		}, 500);
	}
}


/**
 * Copies the whole add-on folder (including subfolders like /library) into
 * globalStorage, then returns the absolute path that should be added to
 * Lua.workspace.library (usually the copied /library folder).
 */
async function initializeKontaktLua(ctx: vscode.ExtensionContext): Promise<void> {
	// Stable target: global storage
	const targetRoot = vscode.Uri.joinPath(ctx.globalStorageUri, "kontakt-lua-api");
	const targetLib  = vscode.Uri.joinPath(targetRoot, "library");

	// Ensure directories exist (VS Code FS API)
	await vscode.workspace.fs.createDirectory(targetRoot);
	await vscode.workspace.fs.createDirectory(targetLib);

	// Copy bundled stubs: add-on/** -> targetRoot/**
	const sourceRoot = vscode.Uri.joinPath(ctx.extensionUri, "add-on");
	await copyDirRecursive(sourceRoot, targetRoot);

	// Add the *library* folder to Lua.workspace.library
	await ensureLuaWorkspaceLibrary(targetLib);
	logger.info("Kontakt Lua API initialized");
}


/**
 * Recursively copies a directory from src to dst.
 * Overwrites files if they already exist.
 */
async function copyDirRecursive(src: vscode.Uri, dst: vscode.Uri): Promise<void> {
	await vscode.workspace.fs.createDirectory(dst);

	const entries = await vscode.workspace.fs.readDirectory(src);
	for (const [name, type] of entries) {
		const s = vscode.Uri.joinPath(src, name);
		const d = vscode.Uri.joinPath(dst, name);

		if (type === vscode.FileType.Directory) {
			await copyDirRecursive(s, d);
		} else if (type === vscode.FileType.File) {
			await vscode.workspace.fs.copy(s, d, { overwrite: true });
		}
	}
}


/**
 * Ensures that the given path is present in Lua.workspace.library.
 */
async function ensureLuaWorkspaceLibrary(libraryUri: vscode.Uri): Promise<void> {
	const cfg = vscode.workspace.getConfiguration("Lua");
	const current = cfg.get<string[]>("workspace.library") ?? [];

	const libPath = libraryUri.fsPath;
	if (!current.includes(libPath)) {
		await cfg.update(
			"workspace.library",
			[...current, libPath],
			vscode.ConfigurationTarget.Global
		);
	}

	await cfg.update(
		"workspace.checkThirdParty",
		false,
		vscode.ConfigurationTarget.Global
	);
}



// This method is called when your extension is deactivated
export function deactivate() {}
