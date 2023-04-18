local Util = Vreq("utils")
local comp = Util.vreq("plugins.configs.lualine.components")

return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		"folke/noice.nvim",
	},

	opts = {
		options = {
			theme = "auto",
			globalstatus = true,
			component_separators = { '', '' },
			section_separators = { '', '' },
			disabled_filetypes = { statusline = { "Starter", "dashboard", "lazy", "alpha" } },
		},
		sections = {
			lualine_a = {
				comp.mode,
				comp.caps_lock,
			},
			lualine_b = {
				comp.branch,
			},
			lualine_c = {
				comp.diagnostics,
				comp.filetype,
				comp.filename,
				comp.navic,
			},
			lualine_x = {
				comp.command,
				comp.macro,
				comp.lazy,
				comp.diff,
			},
			lualine_y = {
				comp.progress,
			},
			lualine_z = {
				comp.location,
				comp.time,
			},
		},
		extensions = {
			"neo-tree",
			"quickfix",
			"fugitive",
			"man",
			"toggleterm",
			"nvim-dap-ui",
		},
	}
}
