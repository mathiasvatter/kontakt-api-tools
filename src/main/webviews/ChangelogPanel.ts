import * as vscode from 'vscode';
import { getWebviewHtmlFromString } from '../utils/webviewUtils';
import changelogHtml from '../../../media/html/changelog.html';

export class ChangelogPanel {
	public static readonly extensionTitle = 'Kontakt API Tools';
	public static currentPanel: ChangelogPanel | undefined;
	public static readonly viewType = 'kontaktApiChangelog';

	private readonly _panel: vscode.WebviewPanel;
	private readonly _context: vscode.ExtensionContext;
	private _disposables: vscode.Disposable[] = [];

	public static createOrShow(context: vscode.ExtensionContext) {
		const column = vscode.window.activeTextEditor?.viewColumn ?? vscode.ViewColumn.One;

		if (ChangelogPanel.currentPanel) {
			ChangelogPanel.currentPanel._panel.reveal(column);
			void ChangelogPanel.currentPanel.refresh();
			return;
		}

		const panel = vscode.window.createWebviewPanel(
			ChangelogPanel.viewType,
			ChangelogPanel.extensionTitle + ' - Changelog',
			column,
			{
				enableScripts: true,
				retainContextWhenHidden: true,
				localResourceRoots: [context.extensionUri],
			}
		);

		ChangelogPanel.currentPanel = new ChangelogPanel(panel, context);
	}

	public static disposeCurrent() {
		ChangelogPanel.currentPanel?.dispose();
	}

	private constructor(panel: vscode.WebviewPanel, context: vscode.ExtensionContext) {
		this._panel = panel;
		this._context = context;

		void this._setHtml();

		this._panel.onDidDispose(() => this.dispose(), null, this._disposables);

		this._panel.webview.onDidReceiveMessage(
			async message => {
				switch (message.command) {
					case 'ready':
						await this._sendChangelogContent();
						break;
				}
			},
			null,
			this._disposables
		);
	}

	public dispose() {
		ChangelogPanel.currentPanel = undefined;
		while (this._disposables.length) {
			const disposable = this._disposables.pop();
			disposable?.dispose();
		}
		this._panel.dispose();
	}

	public async refresh(): Promise<void> {
		await this._sendChangelogContent();
	}

	private async _setHtml(): Promise<void> {
		try {
			const webview = this._panel.webview;
			const html = getWebviewHtmlFromString(webview, this._context, changelogHtml);
			webview.html = html;
		} catch (error) {
			console.error('Failed to load changelog webview HTML:', error);
			this._panel.webview.html = `<html><body>Unable to load changelog view.</body></html>`;
		}
	}

	private async _sendChangelogContent(): Promise<void> {
		const webview = this._panel.webview;
		if (!webview) {
			return;
		}

		try {
			const changelogUri = vscode.Uri.joinPath(this._context.extensionUri, 'CHANGELOG.md');
			const buffer = await vscode.workspace.fs.readFile(changelogUri);
			const markdown = Buffer.from(buffer).toString('utf8');
			const version = String(this._context.extension.packageJSON.version ?? '');

			webview.postMessage({
				command: 'setContent',
				markdown,
				version,
				title: ChangelogPanel.extensionTitle + ' - Whats New',
			});
		} catch (error) {
			const version = String(this._context.extension.packageJSON.version ?? '');
			console.error('Failed to read changelog:', error);
			webview.postMessage({
				command: 'setContent',
				markdown: '## Unable to load changelog\nAn error occurred while reading `CHANGELOG.md`.',
				version,
				title: ChangelogPanel.extensionTitle + ' - Changelog',
			});
			vscode.window.showErrorMessage('Unable to load CHANGELOG.md. See developer console for details.');
		}
	}

	
}
