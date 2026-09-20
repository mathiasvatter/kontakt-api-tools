import * as path from 'node:path';

export function containsPath(paths: readonly string[], expectedPath: string): boolean {
	const normalizedExpected = normalizePath(expectedPath);
	return paths.some(candidate => normalizePath(candidate) === normalizedExpected);
}


export function normalizePath(value: string): string {
	const normalized = path.normalize(value);
	return process.platform === 'win32' ? normalized.toLowerCase() : normalized;
}
