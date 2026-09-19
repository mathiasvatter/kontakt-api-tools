---@meta

-------------------------------------------------------------------------------
-- Kontakt Lua API — Filesystem Module
-------------------------------------------------------------------------------

---Utilities for iterating over directories, querying the filesystem, and
---decomposing path strings. The API is based on Boost.Filesystem; paths are
---plain Lua strings and their interpretation is platform-dependent.
---
---Path-decomposition functions are purely lexical and do not require the path
---to exist. Functions that query the underlying filesystem can fail for
---missing, inaccessible, or otherwise invalid paths.
---@class Filesystem
Filesystem = {}

-------------------------------------------------------------------------------
-- Iterators
-------------------------------------------------------------------------------

---Iterates over the direct children of a directory. The iteration order is
---not defined.
---
---Example:
---```lua
---for _, path in Filesystem.directory(directory_path) do
---    print(path)
---end
---```
---@param path string Path of the directory to iterate.
---@return fun(): integer, string iterator Iterator yielding an index and a child path.
function Filesystem.directory(path) end

---Recursively iterates over the descendants of a directory. The iteration
---order is not defined.
---
---Example:
---```lua
---for _, path in Filesystem.recursive_directory(directory_path) do
---    print(path)
---end
---```
---@param path string Path of the root directory to iterate.
---@return fun(): integer, string iterator Iterator yielding an index and a descendant path.
function Filesystem.recursive_directory(path) end

-------------------------------------------------------------------------------
-- Filesystem Queries
-------------------------------------------------------------------------------

---Tests whether the path string itself has no characters. This is a lexical
---operation; use `Filesystem.is_empty` to inspect a file or directory.
---@param path string Path string to test.
---@return boolean is_empty `true` when `path` is an empty string.
function Filesystem.empty(path) end

---Tests whether a directory has no entries or a regular file has a size of
---zero bytes.
---@param path string Path of a directory or regular file.
---@return boolean is_empty `true` when the directory or file is empty.
function Filesystem.is_empty(path) end

---Tests whether a filesystem object exists at a path.
---@param path string Path to inspect.
---@return boolean exists `false` when no filesystem object exists at `path`.
function Filesystem.exists(path) end

---Tests whether two paths resolve to the same filesystem object. This can be
---true for differently spelled paths, symbolic links, or hard links.
---@param path1 string First path to compare.
---@param path2 string Second path to compare.
---@return boolean equivalent `true` when both paths refer to the same object.
function Filesystem.equivalent(path1, path2) end

---Returns the size of a regular file in bytes.
---@param path string Path of the regular file.
---@return integer size File size in bytes.
function Filesystem.file_size(path) end

---Returns the process's current working directory as an absolute path.
---@return string path Current working directory.
function Filesystem.current_path() end

---Tests whether a path resolves to a regular file. Symbolic links are followed,
---so a link whose target is a regular file also satisfies this test.
---@param path string Path to inspect.
---@return boolean is_regular_file
function Filesystem.is_regular_file(path) end

---Tests whether a path resolves to a directory. Symbolic links are followed.
---@param path string Path to inspect.
---@return boolean is_directory
function Filesystem.is_directory(path) end

---Tests whether the filesystem object at a path is itself a symbolic link.
---Unlike the regular-file and directory checks, this examines the link rather
---than following it.
---@param path string Path to inspect.
---@return boolean is_symlink
function Filesystem.is_symlink(path) end

---Tests whether an existing path resolves to a filesystem object that is not a
---regular file, directory, or symbolic link, such as a device or socket.
---@param path string Path to inspect.
---@return boolean is_other
function Filesystem.is_other(path) end

---Returns the last data-modification time of a filesystem object as a POSIX
---timestamp (`time_t`).
---@param path string Path to inspect.
---@return integer timestamp Last-write time in seconds since the Unix epoch.
function Filesystem.last_write_time(path) end

---Reads the target stored in a symbolic link. A relative target is returned as
---stored; it is not resolved to an absolute or canonical path.
---@param path string Path of the symbolic link.
---@return string target Stored link target.
function Filesystem.read_symlink(path) end

---Returns the number of hard links to a filesystem object.
---@param path string Path to inspect.
---@return integer count Hard-link count.
function Filesystem.hard_link_count(path) end

-------------------------------------------------------------------------------
-- Lexical Path Operations
-------------------------------------------------------------------------------

---Returns the filename extension, including its leading dot, or an empty
---string if the filename has no extension.
---@param path string Path to decompose.
---@return string extension For example, `".wav"` for `"samples/note.wav"`.
function Filesystem.extension(path) end

---Returns the final component of a path, or an empty string if no filename is
---present.
---@param path string Path to decompose.
---@return string filename
function Filesystem.filename(path) end

---Tests whether `parent_path(path)` is non-empty.
---@param path string Path to inspect.
---@return boolean has_parent_path
function Filesystem.has_parent_path(path) end

---Tests whether the portion following the root path is non-empty.
---@param path string Path to inspect.
---@return boolean has_relative_path
function Filesystem.has_relative_path(path) end

---Tests whether a root-directory separator is present, such as `/` on POSIX
---or the separator after a drive name on Windows.
---@param path string Path to inspect.
---@return boolean has_root_directory
function Filesystem.has_root_directory(path) end

---Tests whether the filename has an extension.
---@param path string Path to inspect.
---@return boolean has_extension
function Filesystem.has_extension(path) end

---Tests whether the path has a non-empty final filename component.
---@param path string Path to inspect.
---@return boolean has_filename
function Filesystem.has_filename(path) end

---Tests whether the path has a root name, such as a Windows drive or UNC host.
---Root names are normally absent from POSIX paths.
---@param path string Path to inspect.
---@return boolean has_root_name
function Filesystem.has_root_name(path) end

---Tests whether the final path component is `..`.
---@param path string Path to inspect.
---@return boolean is_dot_dot
function Filesystem.is_dot_dot(path) end

---Tests whether the final path component is `.`.
---@param path string Path to inspect.
---@return boolean is_dot
function Filesystem.is_dot(path) end

---Joins one or more path components using the platform's preferred directory
---separator. This is a lexical operation: it neither normalizes the result nor
---checks that it exists.
---@param ... string Path components to join.
---@return string path Joined path.
function Filesystem.join(...) end

---Tests whether the filename has a non-empty stem (the filename without its
---final extension).
---@param path string Path to inspect.
---@return boolean has_stem
function Filesystem.has_stem(path) end

---Tests whether a path is absolute according to the current platform's path
---rules.
---@param path string Path to inspect.
---@return boolean is_absolute
function Filesystem.is_absolute(path) end

---Returns the path portion following the root path. For a relative input this
---is generally the complete input path.
---@param path string Path to decompose.
---@return string relative_path
function Filesystem.relative_path(path) end

---Tests whether the path has a root name, a root directory, or both.
---@param path string Path to inspect.
---@return boolean has_root_path
function Filesystem.has_root_path(path) end

---Returns the root name, such as a Windows drive (`C:`) or UNC host. Returns an
---empty string when the path has no root name.
---@param path string Path to decompose.
---@return string root_name
function Filesystem.root_name(path) end

---Returns the root-directory component, such as `/`, or an empty string when
---none is present.
---@param path string Path to decompose.
---@return string root_directory
function Filesystem.root_directory(path) end

---Tests whether a path is relative according to the current platform's path
---rules.
---@param path string Path to inspect.
---@return boolean is_relative
function Filesystem.is_relative(path) end

---Returns the path with its final component removed. This is a lexical
---operation and does not resolve `.` or `..` components.
---@param path string Path to decompose.
---@return string parent_path
function Filesystem.parent_path(path) end

---Returns the root name and root-directory components together, or an empty
---string when neither is present.
---@param path string Path to decompose.
---@return string root_path
function Filesystem.root_path(path) end

---Replaces the filename's current extension. A leading dot is optional and is
---inserted when necessary; pass an empty string to remove the extension.
---@param path string Path to modify lexically.
---@param extension string Replacement extension, with or without a leading dot.
---@return string path Path with the replacement extension.
function Filesystem.replace_extension(path, extension) end

---Returns the path using the platform's preferred directory separators. On
---Windows this converts generic `/` separators to `\\`; on POSIX it normally
---leaves the path unchanged.
---@param path string Path to convert lexically.
---@return string preferred_path
function Filesystem.preferred(path) end

---Returns the filename without its final extension.
---@param path string Path to decompose.
---@return string stem
function Filesystem.stem(path) end
