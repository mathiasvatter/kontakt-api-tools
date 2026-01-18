---@meta

-------------------------------------------------------------------------------
-- Kontakt Lua API — Filesystem Module
-------------------------------------------------------------------------------

---@class Filesystem
Filesystem = {}

-------------------------------------------------------------------------------
-- Iterators
-------------------------------------------------------------------------------

-- Example: 
-- ```lua
-- for _, p in Filesystem.directory(path) do
--     print(p)
-- end
-- ```
---@param path string -- The path of a directory you want to iterate.
---@return fun(): string -- Returns an iterator over file/directory paths in `path`.
function Filesystem.directory(path) end

-- Example:
-- ```lua
-- for _, p in Filesystem.recursive_directory(path) do
--     print(p)
-- end
-- ```
---@param path string -- The root directory to recursively iterate.
---@return fun(): string -- Returns an iterator over file paths in directory and sub-directories.
function Filesystem.recursive_directory(path) end

-------------------------------------------------------------------------------
-- Path Functions
-------------------------------------------------------------------------------

-- operational queries on the underlying filesystem (ported from creator tools documentation)

---@param path string -- A path string to query.
---@return boolean -- Returns true if `path` is empty.
function Filesystem.empty(path) end

---@param path string -- A path string to query.
---@return boolean -- Returns true if `path` is a directory and is empty.
function Filesystem.is_empty(path) end

---@param path string -- A path string to query.
---@return boolean -- Returns true if `path` exists in the filesystem.
function Filesystem.exists(path) end

---@param path1 string -- A path string to compare.
---@param path2 string -- A path string to compare.
---@return boolean -- Returns true if `path1` and `path2` refer to the same file or directory.
function Filesystem.equivalent(path1, path2) end

---@param path string -- A path string to query.
---@return number -- Returns the size of the file at `path` in bytes.
function Filesystem.file_size(path) end

---@return string -- Returns the current working directory as an absolute path.
function Filesystem.current_path() end

--- Checks if the given path points to a regular file.
--- A regular file is a file that is not a directory, symbolic link, or special file.
---@param path string -- A path string to query.
---@return boolean -- Returns true if the path is a regular file, false otherwise.
function Filesystem.is_regular_file(path) end

---@param path string -- A path string to query.
---@return boolean -- Returns true if `path` is a directory.
function Filesystem.is_directory(path) end

---@param path string -- A path string to query.
---@return boolean -- Returns true if `path` is a symbolic link.
function Filesystem.is_symlink(path) end

---@param path string -- A path string to query.
---@return boolean -- Returns true if `path` is a special file (e.g., device file, socket, etc.).
function Filesystem.is_other(path) end

---@param path string -- A path string to query.
---@return number -- Returns the last write time of the file or directory at `path` as a timestamp.
function Filesystem.last_write_time(path) end

---@param path string -- A path string to query.
---@return string -- Returns the target path of the symbolic link at `path`.
function Filesystem.read_symlink(path) end

---@param path string -- A path string to query.
---@return number -- Returns the number of hard links to the file at `path`.
function Filesystem.hard_link_count(path) end

---@param path string -- A path string to query.
---@return string -- Returns the extension of `path`.
function Filesystem.extension(path) end

---@param path string -- A path string to query.
---@return string -- Returns the filename part of `path`.
function Filesystem.filename(path) end

---@param path string -- A path string to query.
---@return boolean -- Returns true if `path` has a parent component.
function Filesystem.has_parent_path(path) end

---@param path string -- A path string to query.
---@return boolean -- Returns true if `path` contains a relative component.
function Filesystem.has_relative_path(path) end

---@param path string -- A path string to query.
---@return boolean -- Returns true if `path` contains a root directory.
function Filesystem.has_root_directory(path) end

---@param path string -- A path string to query.
---@return boolean -- Returns true if `path` has a file extension.
function Filesystem.has_extension(path) end

---@param path string -- A path string to query.
---@return boolean -- Returns true if `path` contains a filename.
function Filesystem.has_filename(path) end

---@param path string -- A path string to query.
---@return boolean -- Returns true if `path` contains a root name component.
function Filesystem.has_root_name(path) end

---@param path string -- A path string to query.
---@return boolean -- Returns true if `path` consists of “..”.
function Filesystem.is_dot_dot(path) end

---@param path string -- A path string to query.
---@return boolean -- Returns true if `path` consists of “.”.
function Filesystem.is_dot(path) end

---@param ... string -- One or more path components to join.
---@return string -- Joins components into a single path string using platform separators.
function Filesystem.join(...) end

---@param path string -- A path string to query.
---@return boolean -- Returns true if `path` has a stem (base name without extension).
function Filesystem.has_stem(path) end

---@param path string -- A path string to query.
---@return boolean -- Returns true if `path` is absolute.
function Filesystem.is_absolute(path) end

---@param path string -- A path string to query.
---@return string -- Returns the relative portion of `path`.
function Filesystem.relative_path(path) end

---@param path string -- A path string to query.
---@return boolean -- Returns true if `path` has a root path component.
function Filesystem.has_root_path(path) end

---@param path string -- A path string to query.
---@return string -- Returns the root name of `path`.
function Filesystem.root_name(path) end

---@param path string -- A path string to query.
---@return string -- Returns the root directory of `path`.
function Filesystem.root_directory(path) end

---@param path string -- A path string to query.
---@return boolean -- Returns true if `path` is a relative path.
function Filesystem.is_relative(path) end

---@param path string -- A path string to query.
---@return string -- Returns the parent directory part of `path`.
function Filesystem.parent_path(path) end

---@param path string -- A path string to query.
---@return string -- Returns the root path of `path`.
function Filesystem.root_path(path) end

---@param path string -- A path string to query.
---@param extension string -- New extension to apply (without dot).
---@return string -- Returns the path with its extension replaced.
function Filesystem.replace_extension(path, extension) end

---@param path string -- A path string to query.
---@return string -- Returns the preferred representation of `path`.
function Filesystem.preferred(path) end

---@param path string -- A path string to query.
---@return string -- Returns the stem (filename without extension) of `path`.
function Filesystem.stem(path) end