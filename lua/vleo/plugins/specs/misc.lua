-- you can use the VeryLazy event for things that can
-- load later and are not important for the initial UI
-- { "stevearc/dressing.nvim", event = "VeryLazy" },

return {
	{
		"kkharji/sqlite.lua",
		enabled = function()
			return not jit.os:find("Windows")
		end,
	},

	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
	},

	-- session management
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
		-- stylua: ignore
		keys = {
			{ "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
			{ "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
			{ "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
		},
	},

	-- library used by other plugins
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},

	{
		"folke/twilight.nvim",
		cmd = "Twilight",
		opts = {
			exclude = Vreq("utils.config.disabled").ft,
		}
	},

	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
				kitty = { enabled = false, font = "+2" },
			},
			window = {
				options = {
					signcolumn = "no",
					cursorline = false,
					foldcolumn = "0",
					list = false,
					spell = false,
				},
			},
			on_open = function()
				Vreq("utils.cmp").disable()
				vim.cmd("LspStop")
				vim.opt.laststatus = 0
			end,
			on_close = function()
				Vreq("utils.cmp").enable()
				vim.cmd("LspStart")
				vim.opt.laststatus = 3
			end,
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},

	{
		"andymass/vim-matchup",
		event = "BufReadPost",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
		end,
	},

	{
		"gbprod/yanky.nvim",
		enabled = true,
		event = "BufReadPost",
		dependencies = { "kkharji/sqlite.lua" },
		config = function()
			-- vim.g.clipboard = {
			--   name = "xsel_override",
			--   copy = {
			--     ["+"] = "xsel --input --clipboard",
			--     ["*"] = "xsel --input --primary",
			--   },
			--   paste = {
			--     ["+"] = "xsel --output --clipboard",
			--     ["*"] = "xsel --output --primary",
			--   },
			--   cache_enabled = 1,
			-- }

			require("yanky").setup({
				highlight = {
					timer = 150,
				},
				ring = {
					storage = jit.os:find("Windows") and "shada" or "sqlite",
				},
				system_clipboard = {
					sync_with_ring = false,
				},
			})

			vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")

			vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
			vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
			vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
			vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

			vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
			vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")

			vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
			vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
			vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
			vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

			vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
			vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
			vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
			vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

			vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
			vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")

			vim.keymap.set("n", '<leader>"', function()
				require("telescope").extensions.yank_history.yank_history({})
			end, { desc = "Paste from Yanky" })
		end,
	},

	-- better increase/descrease
	{
		"monaqa/dial.nvim",
		-- stylua: ignore
		keys = {
			{ "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
			{ "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
		},
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.bool,
					augend.semver.alias.semver,
				},
			})
		end,
	},

	{
		"natecraddock/workspaces.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		cmd = "WorkspacesAdd",
		keys = {
			{ "<leader>fp", "<cmd>Telescope workspaces<cr>", desc = "List projects" },
		},
		opts = {
			hooks = {
				open = {
					"Telescope find_files",
				},
			}
		},
		config = function(_, opts)
			require("workspaces").setup(opts)
			require("telescope").load_extension("workspaces")
		end
	},
}
