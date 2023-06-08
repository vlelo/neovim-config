return {
	{
		"TimUntersberger/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
		},
		cmd = "Neogit",
		opts = {
			disable_commit_confirmation = true,
			signs = {
				-- { CLOSED, OPENED }
				section = { "", "" },
				item = { "", "" },
				hunk = { "", "" },
			},
			integrations = {
				diffview = true,
			},
		},
		keys = {
			{ "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit" },
		},
	},

	-- better diffinp
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
		config = function(_, _)
			require("diffview").setup()
			vim.api.nvim_create_autocmd("FileType", {
				desc = "Close some Diffview with q",
				pattern = {
					"DiffviewFiles",
				},
				callback = function()
					vim.keymap.set("n", "q", "<cmd>DiffviewClose<CR>", { buffer = true })
				end,
			})
		end,
		keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" } },
	},

	{
		"nvim-neorg/neorg",
		dependencies = { { "nvim-lua/plenary.nvim" } },
		build = ":Neorg sync-parsers",
		cmd = { "Neorg" },
		ft = "norg",
		opts = {
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {},
				["core.completion"] = {
					config = { engine = "nvim-cmp" },
				},
				["core.integrations.nvim-cmp"] = {},
				["core.dirman"] = { -- Manage your directories with Neorg
					config = {
						workspaces = {
							main = "~/neorg/main",
							--[[ gtd = "~/neorg/gtd", ]]
						},
						autochdir = true, -- Automatically change the directory to the current workspace's root every time
						index = "index.norg", -- The name of the main (root) .norg file
						default_workspace = "main",
						last_workspace = vim.fn.stdpath("cache") .. "/neorg_last_workspace.txt", -- The location to write and read the workspace cache file
					},
				},
			},
		},
	},

	-- orgmode
	{
		"nvim-orgmode/orgmode",
		dependencies = {
			"nvim-cmp",
		},
		event = "VeryLazy",
		config = function()
			local org = require("orgmode")
			local cmp = require("cmp")
			org.setup_ts_grammar()
			cmp.setup.filetype("org", {
				sources = cmp.config.sources({ { name = "orgmode" } }),
			})
			org.setup({
				org_agenda_files = { "~/org/*" },
				org_default_notes_file = "~/org/inbox.org",
				org_todo_keywords = {
					"TODO(t)",
					"WAITING(n)",
					"NEXT(n)",
					"|",
					"DONE(d)",
					"DELEGATED(e)",
					"CANCELLED(c)",
				},
				-- org_todo_keyword_faces = {
				--     WAITING = ':foreground blue :weight bold',
				--     DELEGATED = ':background #FFFFFF :slant italic :underline on',
				--     TODO = ':background #000000 :foreground red', -- overrides builtin color for `TODO` keyword
				-- },
				win_border = "rounded",
			})
		end,
	},

	-- colorizer
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			filetypes = { "*", "!lazy" },
			buftype = { "*", "!prompt", "!nofile" },
			user_default_options = {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				names = false, -- "Name" codes like Blue
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				AARRGGBB = false, -- 0xAARRGGBB hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				-- Available modes: foreground, background
				-- Available modes for `mode`: foreground, background,  virtualtext
				mode = "background", -- Set the display mode.
				virtualtext = "■",
			},
		},
	},

	-- terminal
	{
		"akinsho/toggleterm.nvim",
		cmd = "ToggleTerm",
		keys = {
			{
				"<c-\\>",
				'<cmd>execute v:count1 . "ToggleTerm direction=float"<cr>',
				desc = "Floating terminal",
				mode = { "n", "i" },
			},
			{ "<leader>tf", '<cmd>execute v:count1 . "ToggleTerm direction=float"<cr>', desc = "Floating" },
			{ "<leader>tv", '<cmd>execute v:count1 . "ToggleTerm direction=vertical"<cr>', desc = "Vertical" },
			{ "<leader>th", '<cmd>execute v:count1 . "ToggleTerm direction=horizontal"<cr>', desc = "Horizontal" },
			{ "<leader>tt", '<cmd>execute v:count1 . "ToggleTerm direction=tab"<cr>', desc = "Tab" },
			{
				"<C-]>",
				'<cmd>execute v:count1 . "ToggleTerm direction=horizontal"<cr>',
				desc = "Horizontal terminal",
				mode = { "n", "i" },
			},
		},
		opts = {
			size = function(term)
				if term.direction == "horizontal" then
					return math.floor(vim.o.lines * 0.3)
				elseif term.direction == "vertical" then
					return math.floor(vim.o.columns * 0.4)
				end
			end,
			open_mapping = "<F12>",
			direction = "float",
			close_on_exit = false,
			float_opts = {
				border = "curved",
				width = function()
					return math.floor(vim.o.columns * 0.7)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.7)
				end,
			},
			winbar = {
				enabled = true,
				name_formatter = function(term) --  term: Terminal
					return term.name
				end,
			},
			highlights = {
				Normal = {
					link = "Normal",
				},
			},
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)
			vim.api.nvim_create_autocmd("TermEnter", {
				pattern = "term://*toggleterm#*",
				callback = function(event)
					vim.keymap.set(
						"t",
						"<c-\\>",
						'<Cmd>exe v:count1 . "ToggleTerm direction=float"<CR>',
						{ buffer = event.buf }
					)
					vim.keymap.set(
						"t",
						"<c-]>",
						'<Cmd>exe v:count1 . "ToggleTerm direction=horizontal"<CR>',
						{ buffer = event.buf }
					)
				end,
				desc = "Attach toggleterm bindings to toggleterm buffers",
				group = vim.api.nvim_create_augroup("ToggleTermKeys", { clear = true }),
			})
		end,
	},

	{
		"echasnovski/mini.align",
		keys = {
			{ "ga", desc = "Align" },
			{ "gA", desc = "Align with preview" },
		},
	},

	-- repl
	{
		"hkupty/iron.nvim",
		keys = {
			{ "<leader>rs", "<cmd>IronRepl<cr>", desc = "Start Repl" },
			{ "<space>rw", "<cmd>IronRestart<cr>", desc = "Restart Repl" },
			{ "<space>rr", "<cmd>IronFocus<cr>", desc = "Focus Repl" },
			{ "<space>rh", "<cmd>IronHide<cr>", desc = "Hide Repl" },
		},
		config = function(_, _)
			require("iron.core").setup({
				config = {
					repl_open_cmd = require("iron.view").split.vertical.botright(0.4),
					repl_definition = {
						sh = {
							command = { "zsh" },
						},
						zsh = require("iron.fts.zsh").zsh,
						python = require("iron.fts.python").ipython,
						lua = require("iron.fts.lua").lua,
						matlab = {
							command = {
								"/Applications/MATLAB_R2022a.app/bin/matlab",
								"-nosplash",
								"-nodesktop",
							},
						},
					},
				},
				keymaps = {
					send_motion = "<leader>rt",
					visual_send = "<leader>rv",
					send_file = "<leader>rf",
					send_line = "<leader>rl",
					send_mark = "<leader>rm",
					mark_motion = "<leader>rc",
					mark_visual = "<leader>rc",
					remove_mark = "<leader>rd",
					cr = "<leader>rn",
					interrupt = "<leader>rz",
					exit = "<leader>rq",
					clear = "<leader>ro",
				},
			})

			Vreq("utils.keys").wk_defer({
				["<leader>r"] = {
					name = "REPL",
					t = { "Send motion" },
					l = { "Send line" },
					z = { "Send Interrupt" },
					q = { "Exit" },
					c = { "Mark" },
					d = { "Remove mark" },
					v = { "Send visual" },
					f = { "Send file" },
					m = { "Send mark" },
					o = { "Clear" },
					n = { "CR" },
				},
			})
			Vreq("utils.keys").wk_defer({
				["<leader>rv"] = { "Send to Iron" },
				["<leader>rc"] = { "Mark" },
			}, {
				mode = "v",
			})
		end,
	},

	{
		"s1n7ax/nvim-comment-frame",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{ "<leader>cl", ":lua require('nvim-comment-frame').add_comment()<CR>", desc = "Comment frame" },
			{
				"<leader>cL",
				":lua require('nvim-comment-frame').add_multiline_comment()<CR>",
				desc = "Multiline comment frame",
			},
		},
	},

	{
		"RaafatTurki/hex.nvim",
		cmd = {
			"HexDump",
			"HexAssemble",
			"HexToggle",
		},
		config = function(_, _)
			require("hex").setup()
		end,
	},

	-- {
	-- 	"Wansmer/langmapper.nvim",
	-- 	lazy = false,
	-- 	priority = 1,
	-- 	config = function()
	-- 		require("langmapper").setup({--[[ your config ]]})
	-- 	end,
	-- },
}
