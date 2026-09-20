import * as assert from 'node:assert';
import * as vscode from 'vscode';
import { containsPath, normalizePath } from '../main/utils/pathUtils';

const EXTENSION_ID = 'mvatter.kontakt-api-tools';

suite('Kontakt API Tools', () => {
	test('declares LuaLS as a dependency and activates for Lua files', () => {
		const extension = vscode.extensions.getExtension(EXTENSION_ID);
		assert.ok(extension, `Extension ${EXTENSION_ID} was not found`);

		const manifest = extension.packageJSON as {
			activationEvents?: string[];
			extensionDependencies?: string[];
		};
		assert.ok(manifest.activationEvents?.includes('onLanguage:lua'));
		assert.ok(manifest.extensionDependencies?.includes('sumneko.lua'));
	});

	test('ships all Kontakt API definition files', async () => {
		const extension = vscode.extensions.getExtension(EXTENSION_ID);
		assert.ok(extension, `Extension ${EXTENSION_ID} was not found`);

		for (const file of ['kontakt.lua', 'filesystem.lua', 'mir.lua']) {
			const uri = vscode.Uri.joinPath(extension.extensionUri, 'add-on', 'library', file);
			const stat = await vscode.workspace.fs.stat(uri);
			assert.strictEqual(stat.type, vscode.FileType.File);
		}
	});

	test('compares normalized filesystem paths', () => {
		const expected = normalizePath('/tmp/kontakt/library');
		assert.ok(containsPath(['/tmp/kontakt/other/../library'], expected));
		assert.ok(!containsPath(['/tmp/kontakt/other'], expected));
	});
});
