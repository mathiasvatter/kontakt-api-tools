// src/utils/webviewUtils.ts

import * as vscode from 'vscode';

/**
 * Erzeugt eine zufällige Zeichenfolge für die Content Security Policy (CSP).
 */
export function getNonce(): string {
	let text = '';
	const possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
	for (let i = 0; i < 32; i++) {
		text += possible.charAt(Math.floor(Math.random() * possible.length));
	}
	return text;
}

/**
 * Lädt den HTML-Inhalt für ein Webview, ersetzt alle Platzhalter und gibt den fertigen HTML-String zurück.
 * Dies ist die neue, zentrale Funktion für alle deine Webviews.
 *
 * @param webview Die Webview-Instanz.
 * @param context Der Extension-Context.
 * @param htmlFileName Der Dateiname der HTML-Datei im Ordner 'media/html/'.
 * @returns Ein Promise, das den fertigen HTML-String auflöst.
 */
export async function getWebviewHtml(
	webview: vscode.Webview,
	context: vscode.ExtensionContext,
	htmlFileName: string
): Promise<string> {
	const nonce = getNonce();
	const extensionUri = context.extensionUri;
	
	// Pfade zu den Ressourcen im Webview
	const toolkitUri = webview.asWebviewUri(vscode.Uri.joinPath(extensionUri, 'node_modules', '@vscode/webview-ui-toolkit', 'dist', 'toolkit.js'));
	const codiconCssUri = webview.asWebviewUri(vscode.Uri.joinPath(extensionUri, 'media', 'codicons', 'codicon.css'));
	const markdownCssUri = webview.asWebviewUri(vscode.Uri.joinPath(extensionUri, 'media', 'css', 'markdown.css')); // Pfad zur Markdown CSS Datei

	// markdown and sanitizer
	const markdownItUri = webview.asWebviewUri(vscode.Uri.joinPath(extensionUri, 'media', 'lib', 'markdown-it.min.js'));
	const domPurifyUri = webview.asWebviewUri(vscode.Uri.joinPath(extensionUri, 'media', 'lib', 'purify.min.js'));

	// Pfad zur HTML-Datei auf der Festplatte
	const htmlPath = vscode.Uri.joinPath(extensionUri, 'media', 'html', htmlFileName);

	// Lese die HTML-Datei
	try {
		const buffer = await vscode.workspace.fs.readFile(htmlPath);
		const html = Buffer.from(buffer).toString('utf8');
		
		// Ersetze alle Platzhalter
		return html
			.replace(/{{CSP_SOURCE}}/g, webview.cspSource)
			.replace(/{{NONCE}}/g, nonce)
			.replace('{{TOOLKIT_URI}}', toolkitUri.toString())
			.replace('{{CODICON_CSS_URI}}', codiconCssUri.toString())
			.replace('{{MARKDOWN_CSS_URI}}', markdownCssUri.toString())
			.replace('{{MARKDOWNIT_URI}}', markdownItUri.toString())
			.replace('{{DOMPURIFY_URI}}', domPurifyUri.toString());

	} catch (error) {
		console.error(`Error reading HTML file ${htmlFileName}:`, error);
		return `<html><body>Error loading page. See console for details.</body></html>`;
	}
}

/**
 * Returns the final HTML for a Webview by replacing all placeholders in a raw HTML string.
 * Keep comments in English.
 */
export function getWebviewHtmlFromString(
	webview: vscode.Webview,
	context: vscode.ExtensionContext,
	rawHtml: string
): string {
	const nonce = getNonce();
	const extensionUri = context.extensionUri;

	// Resolve webview-safe URIs
	const toolkitUri   = webview.asWebviewUri(vscode.Uri.joinPath(extensionUri, 'node_modules', '@vscode/webview-ui-toolkit', 'dist', 'toolkit.js'));
	const codiconCssUri= webview.asWebviewUri(vscode.Uri.joinPath(extensionUri, 'media', 'codicons', 'codicon.css'));
	const markdownCssUri = webview.asWebviewUri(vscode.Uri.joinPath(extensionUri, 'media', 'css', 'markdown.css'));
	const markdownItUri  = webview.asWebviewUri(vscode.Uri.joinPath(extensionUri, 'media', 'lib', 'markdown-it.min.js'));
	const domPurifyUri   = webview.asWebviewUri(vscode.Uri.joinPath(extensionUri, 'media', 'lib', 'purify.min.js'));

	// Replace placeholders (use global replace for tokens that may appear multiple times)
	return rawHtml
		.replace(/{{CSP_SOURCE}}/g, webview.cspSource)
		.replace(/{{NONCE}}/g, nonce)
		.replace(/{{TOOLKIT_URI}}/g, toolkitUri.toString())
		.replace(/{{CODICON_CSS_URI}}/g, codiconCssUri.toString())
		.replace(/{{MARKDOWN_CSS_URI}}/g, markdownCssUri.toString())
		.replace(/{{MARKDOWNIT_URI}}/g, markdownItUri.toString())
		.replace(/{{DOMPURIFY_URI}}/g, domPurifyUri.toString());
}