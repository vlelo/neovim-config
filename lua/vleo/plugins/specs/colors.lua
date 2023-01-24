return {
	{
		"sainnhe/gruvbox-material",
		-- lazy = false, -- main colorscheme: no lazyload
		-- priority = 1000,
		-- config = function(_, _)
		-- 	vim.g.gruvbox_material_diagnostic_line_highlight = 1
		-- 	vim.g.gruvbox_material_enable_bold = 1
		-- 	vim.g.gruvbox_material_enable_italic = 1
		-- 	vim.g.gruvbox_material_diagnostic_virtual_text = 1
		-- 	vim.g.gruvbox_material_current_word = "grey background"

		-- 	vim.cmd [[
		-- 		 let g:configuration = gruvbox_material#get_configuration()
		-- 		 let g:palette = gruvbox_material#get_palette(g:configuration.background, g:configuration.foreground, g:configuration.colors_override)
		-- 		 call gruvbox_material#highlight('NormalFloat', g:palette.fg1, g:palette.bg0)
		-- 		 call gruvbox_material#highlight('FloatBorder', g:palette.grey1, g:palette.bg0)
		-- 		 hi ErrorFloat guibg=g:palette.bg0
		-- 		 hi WarningFloat guibg=g:palette.bg0
		-- 		 hi InfoFloat guibg=g:palette.bg0
		-- 		 hi HintFloat guibg=g:palette.bg0
		-- 		 call gruvbox_material#highlight('Headline', g:palette.none, g:palette.bg_diff_green)
		-- 		]]
		-- end
	},

	{ "shaunsingh/oxocarbon.nvim" },

	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		opts = function()
			local groups = require("gruvbox.groups").setup()
			local colors = require("gruvbox.palette")
			local config = require("gruvbox").config

			local NoicePopup = { fg = colors.neutral_blue, bg = colors.dark0, reverse = config.invert_signs }
			local GruvboxAquaSign = { fg = colors.aqua, bg = colors.bg1, reverse = config.invert_signs }

			return {
				overrides = {
					NormalFloat = groups.Float,
					NoiceCmdlinePopupBorder = NoicePopup,
					NoiceCmdlineIcon = NoicePopup,
					NoiceMini = groups.DiagnosticSignInfo,
					NoiceConfirm = NoicePopup,
					NoiceConfirmBorder = NoicePopup,
					-- BufferLineFill = { bg = colors.dark0 },
					TSURI = { link = "@text.uri" },
					TSNamespace = { link = "@namespace" },
					TSType = { link = "@type" },
					TSMethod = { link = "@Method" },
					TSField = { link = "@field" },
					TSConstructor = { link = "@constructor" },
					TSFunction = { link = "@function" },
					TSConstant = { link = "@constant" },
					TSString = { link = "@string" },
					TSNumber = { link = "@number" },
					TSBoolean = { link = "@boolean" },
					TSOperator = { link = "@operator" },
					TSParameter = { link = "@parameter" },
					TreesitterContext = groups.DiagnosticSignInfo,
					GitSignsChange = GruvboxAquaSign,
					-- DapBreakpoint = groups.DiagnosticError,
					-- DapLogPoint = groups.DiagnosticInfo,
					-- DapStopped = groups.DiagnosticInfo,
					-- DapBreakpointRejected = groups.DiagnosticHint,
				}
			}
		end
	},

	{
		"folke/tokyonight.nvim",
		opts = function()
			return {
				style = "moon",
				sidebars = {
					"qf",
					"vista_kind",
					"terminal",
					"spectre_panel",
					"startuptime",
					"Outline",
				},
				on_highlights = function(hl, c)
					hl.CursorLineNr = { fg = c.orange, bold = true }
					hl.LineNr = { fg = c.orange, bold = true }
					hl.LineNrAbove = { fg = c.fg_gutter }
					hl.LineNrBelow = { fg = c.fg_gutter }
					local prompt = "#2d3149"
					hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg_dark }
					hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
					hl.TelescopePromptNormal = { bg = prompt }
					hl.TelescopePromptBorder = { bg = prompt, fg = prompt }
					hl.TelescopePromptTitle = { bg = c.fg_gutter, fg = c.orange }
					hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.bg_dark }
					hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }
				end,
			}
		end,
	},
}
