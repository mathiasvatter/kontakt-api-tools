#!/bin/bash

# Script to set a new release tag and create a GitHub Release for the VSCode Extension
# Uploads the .vsix package with the current version from the _Releases folder
# Requires 'gh' CLI tool and 'jq' to be installed
# Contents of CHANGELOG.md will be used as release notes
# Usage: ./set_release.sh

PACKAGE_JSON="package.json"
# Reading the changelog content
CHANGELOG_PATH="CHANGELOG.md"
# Extract version from package.json
VERSION=$(jq -r '.version' "$PACKAGE_JSON")
TAG="v${VERSION}"
RELEASE_NAME=$TAG
NAME=$(jq -r '.name' "$PACKAGE_JSON")

# Create a name for the release folder
RELEASES_DIR="_Releases"
if [ ! -d "$RELEASES_DIR" ]; then
	mkdir -p "$RELEASES_DIR"
fi

VSIX_FILE="${NAME}-${VERSION}.vsix"
ASSETS_PATH="${RELEASES_DIR}/${VSIX_FILE}"


# Ensure the assets path is correct
if [ ! -f "$ASSETS_PATH" ]; then
	echo "Error: .vsix file for version $VERSION not found in $RELEASE_DIR." >&2
	exit 1
fi

if [ -f "$CHANGELOG_PATH" ]; then
	BODY=$(<"$CHANGELOG_PATH")
else
	echo "Error: CHANGELOG.md file not found." >&2
	exit 1
fi

# remove existing tag and release if they exist
if git rev-parse "$TAG" >/dev/null 2>&1; then
	echo "Deleting local tag $TAG..."
	git tag -d "$TAG"
	git push --delete origin "$TAG"
fi

if gh release view "$TAG" --repo "$REPO" >/dev/null 2>&1; then
	echo "Deleting GitHub release $TAG..."
	gh release delete "$TAG" --repo "$REPO" --yes
fi

# Set new tag and push it to the remote repository
echo "Creating new tag $TAG..."
git tag "$TAG"
git push origin "$TAG"

# Create the release
gh release create "$TAG" \
  --title "$RELEASE_NAME" \
  --notes "$BODY" \
  "$ASSETS_PATH"
#   --draft \

echo "Release $TAG created successfully."
