local disabled = Vreq("utils.config.disabled")

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"s1n7ax/nvim-window-picker",
		},
		keys = {
			{
				"<leader>N",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = Vreq("utils").get_root() })
				end,
				desc = "NeoTree (root dir)",
			},
			{ "<leader>n", "<cmd>Neotree toggle<CR>", desc = "NeoTree (cwd)" },
		},
		init = function()
			vim.g.neo_tree_remove_legacy_commands = 1
			if vim.fn.argc() == 1 then
				local stat = vim.loop.fs_stat(vim.fn.argv(0))
				if stat and stat.type == "directory" then
					require("neo-tree")
				end
			end
		end,
		opts = {
			filesystem = {
				follow_current_file = true,
			},
			window = {
				width = 30,
				mappings = {
					o = "open",
					["S"] = "split_with_window_picker",
					["s"] = "vsplit_with_window_picker",
					["t"] = "open_tabnew",
					["Z"] = "expand_all_nodes",
				}
			},
		},
	},

	{
		-- only needed if you want to use the commands with "_with_window_picker" suffix
		"s1n7ax/nvim-window-picker",
		config = function(_, _)
			require "window-picker".setup({
				autoselect_one = true,
				include_current = false,
				filter_rules = {
					bo = {
						filetype = disabled.ft,
						buftype = disabled.bt,
					},
				},
				other_win_hl_color = '#e35e4f',
			})
		end,
	},

	-- easily jump to any location and enhanced f/t motions for Leap
	{
		"ggandor/leap.nvim",
		event = "VeryLazy",
		-- dependencies = { { "ggandor/flit.nvim", opts = { labeled_modes = "nv" } } },
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
			leap.add_default_mappings(true)
		end,
	},

	-- git signs
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

				-- stylua: ignore start
				map("n", "]h", gs.next_hunk, "Next Hunk")
				map("n", "[h", gs.prev_hunk, "Prev Hunk")
				map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
				map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
				map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
				map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
				map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
				map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
				map("n", "<leader>ghd", gs.diffthis, "Diff This")
				map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
		init = function()
			Vreq("utils.keys").wk_defer({ ["<leader>gh"] = { name = "Gitsigns" } })
		end
	},

	{
		"simrat39/symbols-outline.nvim",
		keys = { { "<leader>ls", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
		config = {
			preview_bg_highlight = "NormalFloat",
			symbols = {
				File = { icon = "", hl = "@text.uri" },
				Module = { icon = "", hl = "@namespace" },
				Namespace = { icon = "", hl = "@namespace" },
				Package = { icon = "", hl = "@namespace" },
				Class = { icon = "𝓒", hl = "@type" },
				Method = { icon = "ƒ", hl = "@method" },
				Property = { icon = "", hl = "@method" },
				Field = { icon = "", hl = "@field" },
				Constructor = { icon = "", hl = "@constructor" },
				Enum = { icon = "ℰ", hl = "@type" },
				Interface = { icon = "ﰮ", hl = "@type" },
				Function = { icon = "", hl = "@function" },
				Variable = { icon = "", hl = "@constant" },
				Constant = { icon = "", hl = "@constant" },
				String = { icon = "𝓐", hl = "@string" },
				Number = { icon = "#", hl = "@number" },
				Boolean = { icon = "⊨", hl = "@boolean" },
				Array = { icon = "", hl = "@constant" },
				Object = { icon = "⦿", hl = "@type" },
				Key = { icon = "🔐", hl = "@type" },
				Null = { icon = "NULL", hl = "@type" },
				EnumMember = { icon = "", hl = "@field" },
				Struct = { icon = "𝓢", hl = "@type" },
				Event = { icon = "🗲", hl = "@type" },
				Operator = { icon = "+", hl = "@operator" },
				TypeParameter = { icon = "𝙏", hl = "@parameter" }
			}
		},
	},

	{
		"folke/trouble.nvim",
		-- opts will be merged with the parent spec
		opts = {
			use_diagnostic_signs = true,
		},
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle<CR>", desc = "Trouble" },
		}
	},

	{
		"amrbashir/nvim-docs-view",
		cmd = { "DocsViewToggle" },
		opts = {
			position = "right",
			width = 40,
		},
		config = function(_, opts)
			require("docs-view").setup(opts)
		end
	},
}
