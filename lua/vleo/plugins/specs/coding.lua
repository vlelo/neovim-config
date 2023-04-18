return {
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		build = "make install_jsregexp",
		dependencies = {
			{
				enable = false,
				"rafamadriz/friendly-snippets",
				build = {
					"[ -e snippets/latex.json ] && rm snippets/latex.json",
					"[ -e snippets/latex ] && rm -r snippets/latex"
				},
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
		config = function(_, opts)
			local types = require("luasnip.util.types")
			opts.ext_opts = {
				[types.choiceNode] = {
					active = {
						virt_text = { { "<-", "Error" } },
					},
				},
			}

			require("luasnip").config.setup(opts)
		end,
		-- stylua: ignore
		keys = {
			-- {
			-- 	"<tab>",
			-- 	function()
			-- 		return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
			-- 	end,
			-- 	expr = true, silent = true, mode = "i",
			-- },
			-- { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
			-- { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
			{ "<c-x>", function() require("luasnip").jump(1) end,  mode = { "i", "s" } },
			{ "<c-z>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
		},
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		opts = {
			fast_wrap = {},
			check_ts = true,
			map_c_h = true,
			map_c_w = true,
			enable_check_bracket_line = true, --- check bracket in same line
			ignored_next_char = [=[[%w%%%'%[%"%.]]=],
		},
		config = function(_, opts)
			local npairs = require("nvim-autopairs")
			local Rule = require('nvim-autopairs.rule')
			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			local cmp = require("cmp")
			local cond = require 'nvim-autopairs.conds'

			npairs.setup(opts)

			-- If you want insert `(` after select function or method item
			cmp.event:on(
				'confirm_done',
				cmp_autopairs.on_confirm_done({
					filetypes = {
						tex = false,
					},
				})
			)

			npairs.add_rule(Rule("$", "$", "tex"))
			npairs.add_rule(Rule("/*", "*/", "c"))

			local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' }, { "/*", "*/" }, { "$", "$" } }
			npairs.add_rules({
				Rule(' ', ' ')
						:with_pair(function(opt)
							local pair = opt.line:sub(opt.col - 1, opt.col)
							return vim.tbl_contains({
								brackets[1][1] .. brackets[1][2],
								brackets[2][1] .. brackets[2][2],
								brackets[3][1] .. brackets[3][2]
							}, pair)
						end)
						:with_move(cond.none())
						:with_cr(cond.none())
						:with_del(function(opt)
							local col = vim.api.nvim_win_get_cursor(0)[2]
							local context = opt.line:sub(col - 1, col + 2)
							return vim.tbl_contains({
								brackets[1][1] .. '  ' .. brackets[1][2],
								brackets[2][1] .. '  ' .. brackets[2][2],
								brackets[3][1] .. '  ' .. brackets[3][2]
							}, context)
						end)
			})
			for _, bracket in pairs(brackets) do
				Rule('', ' ' .. bracket[2])
						:with_pair(cond.none())
						:with_move(function(opt) return opt.char == bracket[2] end)
						:with_cr(cond.none())
						:with_del(cond.none())
						:use_key(bracket[2])
			end
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = true,
	},

	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter",
		},
		config = true,
	},

	{
		"folke/todo-comments.nvim",
		event = "VeryLazy"
	},

	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function(_, _)
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
				ignore = "^$",
			})
		end,
	},

	{
		"cshuaimin/ssr.nvim",
		event = "VeryLazy",
		opts = {
			min_width = 50,
			min_height = 5,
			max_width = 120,
			max_height = 25,
			keymaps = {
				close = "q",
				next_match = "n",
				prev_match = "N",
				replace_confirm = "<cr>",
				replace_all = "<leader><cr>",
			},
		},
		config = function(_, opts)
			require("ssr").setup(opts)
			vim.keymap.set({ "n", "x" }, "gsr", function() require("ssr").open() end,
				{ desc = "Structural search and replace" })
		end
	},

	-- split join
	{
		"Wansmer/treesj",
		keys = {
			{ "gJ", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
		},
		opts = { use_default_keymaps = false, max_join_length = 150 },
	},

	-- better text-objects
	{
		"echasnovski/mini.ai",
		keys = {
			{ "a", mode = { "x", "o" } },
			{ "i", mode = { "x", "o" } },
		},
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					-- no need to load the plugin, since we only need its queries
					require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
				end,
			},
		},
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" } --[[  ]],
					}, {}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
					a = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }, {}),
					k = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.outer" }, {}),
				},
			}
		end,
		config = function(_, opts)
			local ai = require("mini.ai")
			ai.setup(opts)
			Vreq("utils.keys").wk_defer({
				["g]"] = "Goto next",
				["g["] = "Goto previous",
			})
		end,
	},

	-- annotagions
	{
		"danymat/neogen",
		keys = {
			{
				"<leader>cc",
				function()
					require("neogen").generate({})
				end,
				desc = "Neogen Comment",
			},
		},
		opts = { snippet_engine = "luasnip" },
	},
}
