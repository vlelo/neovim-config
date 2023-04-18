local conditions = Vreq("plugins.configs.lualine.conditions")
local icons = Vreq("utils.config.icons")

local function fg(name)
	return function()
		---@type {foreground?:number}?
		local hl = vim.api.nvim_get_hl_by_name(name, true)
		return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
	end
end

-- local function diff_source()
-- 	local gitsigns = vim.b.gitsigns_status_dict
-- 	if gitsigns then
-- 		return {
-- 			added = gitsigns.added,
-- 			modified = gitsigns.changed,
-- 			removed = gitsigns.removed,
-- 		}
-- 	end
-- end

return {
	mode = {
		"mode",
		cond = nil,
	},
	branch = {
		"branch",
		icon = " ",
		color = { gui = "bold" },
		cond = conditions.hide_in_width,
	},
	filename = {
		"filename",
		path = 1,
		file_status = true,
		symbols = { modified = "[+]", readonly = "", unnamed = "" },
		cond = conditions.hide_in_width,
	},
	diff = {
		"diff",
		-- source = diff_source,
		symbols = {
			added = icons.git.added,
			modified = icons.git.modified,
			removed = icons.git.removed,
		},
	},
	diagnostics = {
		"diagnostics",
		symbols = {
			error = icons.diagnostics.Error,
			warn = icons.diagnostics.Warn,
			info = icons.diagnostics.Info,
			hint = icons.diagnostics.Hint,
		},
	},
	location = { "location", padding = { left = 0, right = 0 } },
	progress = { "progress", separator = "", padding = { left = 1, right = 1 } },
	encoding = {
		"encoding",
		upper = true,
		cond = conditions.hide_in_width,
	},
	filetype = {
		"filetype",
		icon_only = true,
		separator = "",
		padding = { left = 1, right = 0 },
		cond = conditions.hide_in_width,
	},
	toggleterm_number = {
		function()
			---@diagnostic disable-next-line: undefined-field
			return ("Terminal " .. vim.b.toggle_number)
		end,
		cond = function()
			return conditions.hide_in_width() and conditions.is_toggleterm()
		end,
	},
	caps_lock = {
		function()
			if vim.fn["CapsLockStatusline"](true) == true then
				return "CAPS"
			else
				return ""
			end
		end,
	},
	scrollbar = {
		function()
			local current_line = vim.fn.line "."
			local total_lines = vim.fn.line "$"
			local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
			local line_ratio = current_line / total_lines
			local index = math.ceil(line_ratio * #chars)
			return chars[index]
		end,
		left_padding = 0,
		right_padding = 0,
		cond = nil,
	},
	spaces = {
		function()
			local label = "Spaces: "
			if not vim.api.nvim_buf_get_option(0, "expandtab") then
				label = "Tab size: "
			end
			return label .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
		end,
		cond = conditions.hide_in_width,
		color = {},
	},
	treesitter = {
		function()
			if next(vim.treesitter.highlighter.active) then
				return "  "
			end
			return ""
		end,
		cond = conditions.hide_in_width,
	},
	command = {
		function() return require("noice").api.status.command.get() end,
		cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
		color = fg("Statement")
	},
	-- stylua: ignore
	macro = {
		function() return require("noice").api.status.mode.get() end,
		cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
		color = fg("Constant"),
	},
	lazy = {
		require("lazy.status").updates,
		cond = require("lazy.status").has_updates,
		color = fg("Special")
	},
	navic = {
		function() return require("nvim-navic").get_location() end,
		cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
		padding = {
			right = 0,
			left = 1,
		}
	},
	time = {
		function() return " " .. os.date("%R") end,
		cond = function() return false end,
	},
}
