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
-- for _, p in Filesystem.directory(path) do
--     print(p)
-- end
---@param path string -- The path of a directory you want to iterate.
---@return fun(): string -- Returns an iterator over file/directory paths in `path`.
function Filesystem.directory(path) end

-- Example:
-- for _, p in Filesystem.recursive_directory(path) do
--     print(p)
-- end
---@param path string -- The root directory to recursively iterate.
---@return fun(): string -- Returns an iterator over file paths in directory and sub-directories.
function Filesystem.recursive_directory(path) end

-------------------------------------------------------------------------------
-- Path Functions
-------------------------------------------------------------------------------

---@param path string -- A path string to query.
---@return boolean -- Returns true if `path` is empty.
function Filesystem.empty(path) end

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