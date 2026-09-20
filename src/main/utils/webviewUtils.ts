// src/utils/webviewUtils.ts

import { randomBytes } from 'node:crypto';
import * as vscode from 'vscode';

/**
 * Erzeugt eine zufällige Zeichenfolge für die Content Security Policy (CSP).
 */
export function getNonce(): string {
	return randomBytes(24).toString('base64');
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
	const codiconCssUri= webview.asWebviewUri(vscode.Uri.joinPath(extensionUri, 'media', 'codicons', 'codicon.css'));
	const markdownCssUri = webview.asWebviewUri(vscode.Uri.joinPath(extensionUri, 'media', 'css', 'markdown.css'));
	const markdownItUri  = webview.asWebviewUri(vscode.Uri.joinPath(extensionUri, 'media', 'lib', 'markdown-it.min.js'));
	const domPurifyUri   = webview.asWebviewUri(vscode.Uri.joinPath(extensionUri, 'media', 'lib', 'purify.min.js'));

	// Replace placeholders (use global replace for tokens that may appear multiple times)
	return rawHtml
		.replace(/{{CSP_SOURCE}}/g, webview.cspSource)
		.replace(/{{NONCE}}/g, nonce)
		.replace(/{{CODICON_CSS_URI}}/g, codiconCssUri.toString())
		.replace(/{{MARKDOWN_CSS_URI}}/g, markdownCssUri.toString())
		.replace(/{{MARKDOWNIT_URI}}/g, markdownItUri.toString())
		.replace(/{{DOMPURIFY_URI}}/g, domPurifyUri.toString());
}
