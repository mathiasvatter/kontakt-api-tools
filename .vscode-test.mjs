import { defineConfig } from '@vscode/test-cli';

export default defineConfig({
	files: 'out/test/**/*.test.js',
	// Keep the test host aligned with the minimum supported VS Code generation.
	// Newer macOS builds currently require a newer test-electron launcher.
	version: '1.108.2',
	download: {
		timeout: 120_000,
	},
});
