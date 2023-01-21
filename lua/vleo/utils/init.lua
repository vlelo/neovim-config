local M = {}

M.root_patterns = { ".git", "lua" }

--- Create a keymap valid for all modes
---@param mapping string Left-hand side {lhs} of the mapping
---@param command string|function Right-hand side {rhs} of the mapping
---@param opts table? `vim.keymap.set` options table
function M.allmap(mapping, command, opts)
	vim.keymap.set({ "", "n", "v", "x", "s", "o", "!", "i", "l", "t" }, mapping, command, opts)
end

--- Require but automatically prefixes `vleo.`
---@param modname string Module name
---@return any
function M.vreq(modname)
	return require(Vconf .. "." .. modname)
end

--- Load with `vreq` modules form `list`, prefixed with `prefix`
---@param prefix string|nil Prefix for `require` (no trailing .)
---@param list string[] Modules to load
function M.load_mod(prefix, list)
	local sep = "."
	if prefix == "" or type(prefix) == "nil" then
		sep = ""
		prefix = ""
	end
	for _, module in ipairs(list) do
		--[[ local ok, err = pcall(require, Vconf .. "." .. prefix .. sep .. module) ]]
		--[[ if not ok then ]]
		--[[ 	error("Error loading " .. prefix .. sep .. module .. " \n\n" .. err) ]]
		--[[ end ]]
		local co = coroutine.create(function() return M.vreq(prefix .. sep .. module) end)
		local ok, err = coroutine.resume(co)
		if not ok then
			error("Error loading " .. prefix .. sep .. module .. " \n\n" .. err)
		end
	end
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
function M.get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  ---@cast root string
  return root
end


-- this will return a function that calls telescope.
-- cwd will defautlt to lazyvim.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
function M.telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts
    opts = vim.tbl_deep_extend("force", { cwd = M.get_root() }, opts or {})
    if builtin == "files" then
      if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
        opts.show_untracked = true
        builtin = "git_files"
      else
        builtin = "find_files"
      end
    end
    require("telescope.builtin")[builtin](opts)
  end
end

return M
