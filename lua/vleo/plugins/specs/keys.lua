return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = { spelling = true },
			key_labels = {
				["<leader>"] = "SPC",
				["<Tab>"] = "TAB",
				["<cr>"] = "<CR>",
			},
			icons = {
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
				separator = "➜", -- symbol used between a key and it's label
				group = "·", -- symbol prepended to a group
			},
			window = {
				border = "double",
			},
			disable = {
				buftypes = Vreq("utils.config.disabled").bt,
				filetypes = Vreq("utils.config.disabled").ft,
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			Vreq("utils.keys").wk_apply(wk)
			wk.register({
				["]"] = "Next",
				["["] = "Previous",
				Y = "Yank to end of line",
				['"'] = "Registers",
				["'"] = "Marks",
				["="] = "Autoindent",
				["@"] = "Macros",
				["`"] = "Marks",
				["<c-w>"] = "Window",
				g = { name = "Prefix" },
				gs = { name = "Structural editing" },
				z = "View",
				p = "Put",
				P = "Put before",
				s = "Leap",
				u = "Undo",
				U = "Undo line",
				gp = "Put",
				gP = "Put before",
				["g'"] = "Marks",
				["g`"] = "Marks",
				["<space>"] = {
					name = "Leader",
					f = { name = "Telescope", },
					s = { name = "Telescope Neovim", },
					x = { name = "Lists", },
					b = { name = "Buffers", },
					w = { name = "Windows", },
					u = { name = "UI" },
					c = { name = "Comment" },
					q = { name = "Session" },
					g = { name = "Git" },
					t = { name = "Terminal" },
					["<Tab>"] = { name = "Tabs", },
				},
			})
			wk.register({
				s = "Leap",
				S = "Leap noninclusive",
				x = "Leap backwards",
				X = "Leap backwards noninclusive",
				["<M-i>"] = "which_key_ignore",
				["]"] = {
					name = "Next",
					["%"] = "Delimiter",
					n = "Context",
				},
				["["] = {
					name = "Previous",
					["%"] = "Delimiter",
					n = "Context",
				},
				a = "Around",
				i = "Inside",
				["z%"] = "Inside delimiter",
				g = {
					name = "Prefix",
					["%"] = "Delimiter",
					s = "Leap",
				}
			}, {
				mode = { "o" },
			})
		end
	},
}
