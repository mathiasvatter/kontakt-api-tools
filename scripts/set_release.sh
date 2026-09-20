#!/usr/bin/env bash

set -euo pipefail

# Script to set a new release tag and create a GitHub Release for the VSCode Extension
# Uploads the .vsix package with the current version from the _Releases folder
# Requires 'gh' CLI tool and 'jq' to be installed
# Contents of CHANGELOG.md will be used as release notes
# Usage: ./set_release.sh

PACKAGE_JSON="package.json"
CHANGELOG_PATH="CHANGELOG.md"
VERSION=$(jq -r '.version' "$PACKAGE_JSON")
TAG="v${VERSION}"
RELEASE_NAME=$TAG
NAME=$(jq -r '.name' "$PACKAGE_JSON")

REPOSITORY_ARGS=()
if [[ -n "${GITHUB_REPOSITORY:-}" ]]; then
	REPOSITORY_ARGS=(--repo "$GITHUB_REPOSITORY")
fi

# Create a name for the release folder
RELEASES_DIR="_Releases"
if [ ! -d "$RELEASES_DIR" ]; then
	mkdir -p "$RELEASES_DIR"
fi

VSIX_FILE="${NAME}-${VERSION}.vsix"
ASSETS_PATH="${RELEASES_DIR}/${VSIX_FILE}"


# Ensure the assets path is correct
if [ ! -f "$ASSETS_PATH" ]; then
	echo "Error: .vsix file for version $VERSION not found in $RELEASES_DIR." >&2
	exit 1
fi

if [ ! -f "$CHANGELOG_PATH" ]; then
	echo "Error: CHANGELOG.md file not found." >&2
	exit 1
fi

# Never replace an existing release or move an existing version tag.
if git rev-parse -q --verify "${TAG}^{commit}" >/dev/null 2>&1; then
	echo "Error: tag $TAG already exists. Increase the version before publishing again." >&2
	exit 1
fi

if gh release view "$TAG" "${REPOSITORY_ARGS[@]}" >/dev/null 2>&1; then
	echo "Error: GitHub release $TAG already exists. Increase the version before publishing again." >&2
	exit 1
fi

# Set new tag and push it to the remote repository
echo "Creating new tag $TAG..."
git tag "$TAG"
git push origin "$TAG"

# Create the release
gh release create "$TAG" \
  "${REPOSITORY_ARGS[@]}" \
  --verify-tag \
  --title "$RELEASE_NAME" \
  --notes-file "$CHANGELOG_PATH" \
  "$ASSETS_PATH"
#   --draft \

echo "Release $TAG created successfully."
