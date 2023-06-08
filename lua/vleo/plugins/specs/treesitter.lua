return {
	{
		"nvim-treesitter/playground",
		cmd = "TSPlaygroundToggle",
	},

	{
		"mfussenegger/nvim-treehopper",
		keys = { { "m", mode = { "o", "x" } } },
		config = function()
			vim.cmd([[
				omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
				xnoremap <silent> m :lua require('tsht').nodes()<CR>
				]])
			Vreq("utils.keys").wk_defer({
				m = "Hop tree",
			}, {
				mode = { "o", "x" },
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPre",
		config = function()
			require("treesitter-context").setup({
				line_numbers = true,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
			"mrjones2014/nvim-ts-rainbow",
		},
		build = ":TSUpdate",
		event = "BufReadPost",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"cmake",
					-- "comment", -- comments are slowing down TS bigtime, so disable for now
					"cpp",
					"css",
					"diff",
					"fish",
					"gitignore",
					"go",
					"graphql",
					"help",
					"html",
					"http",
					"java",
					"javascript",
					"jsdoc",
					"jsonc",
					"latex",
					"lua",
					"markdown",
					"markdown_inline",
					"meson",
					"ninja",
					"nix",
					"norg",
					"org",
					"php",
					"python",
					"query",
					"regex",
					"rust",
					"scss",
					"sql",
					"svelte",
					"teal",
					"toml",
					"tsx",
					"typescript",
					"vhs",
					"vim",
					"vue",
					"wgsl",
					"yaml",
					-- "wgsl",
					"json",
					"markdown",
					"dap_repl",
				},
				sync_install = false,
				auto_install = false,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "org" },
				},
				indent = { enable = false },
				context_commentstring = { enable = true, enable_autocmd = false },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gss",
						node_incremental = "gss",
						scope_incremental = "gsa",
						node_decremental = "gsd",
					},
				},
				query_linter = {
					enable = true,
					use_virtual_text = true,
					lint_events = { "BufWrite", "CursorHold" },
				},
				playground = {
					enable = true,
					disable = {},
					updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
					persist_queries = true, -- Whether the query persists across vim sessions
					keybindings = {
						toggle_query_editor = "o",
						toggle_hl_groups = "i",
						toggle_injected_languages = "t",
						toggle_anonymous_nodes = "a",
						toggle_language_display = "I",
						focus_language = "f",
						unfocus_language = "F",
						update = "R",
						goto_node = "<cr>",
						show_help = "?",
					},
				},
				textobjects = {
					select = {
						enable = false,
					},
					move = {
						enable = false,
					},
					lsp_interop = {
						enable = false,
					},
				},
				rainbow = {
					enable = true,
					extended_mode = true,
				},
			})
		end,
	},

	-- tree surfer ie swap
	{
		"ziontee113/syntax-tree-surfer",
		enabled = false,
		keys = {
			-- Swap The Master Node relative to the cursor with it's siblings, Dot Repeatable
			{
				"]S",
				function()
					vim.opt.opfunc = "v:lua.STSSwapUpNormal_Dot"
					return "g@l"
				end,
				expr = true,
				desc = "Swap next master node",
			},
			{
				"[S",
				function()
					vim.opt.opfunc = "v:lua.STSSwapDownNormal_Dot"
					return "g@l"
				end,
				expr = true,
				desc = "Swap previous master node",
			},

			-- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
			{
				"]s",
				function()
					vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
					return "g@l"
				end,
				expr = true,
				desc = "Swap next node",
			},
			{
				"[s",
				function()
					vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
					return "g@l"
				end,
				expr = true,
				desc = "Swap previous node",
			},
		},
	},
}
