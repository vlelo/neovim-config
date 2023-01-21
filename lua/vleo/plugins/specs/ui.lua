return {
	{
		"stevearc/dressing.nvim",
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},

	{
		"MunifTanjim/nui.nvim",
		event = "VeryLazy",
	},

	{
		"nvim-tree/nvim-web-devicons",
		opts = { default = true },
		config = function(_, opts)
			local nwi = require("nvim-web-devicons")
			nwi.setup(opts)

			nwi.set_default_icon('', '#6d8086')

			nwi.set_icon({
				md = {
					icon = "",
					color = "#519aba",
					cterm_color = "67",
					name = "Md",
				},
				ino = {
					icon = "",
					color = "#519aba",
					cterm_color = "67",
					name = "Arduino",
				},
				m = {
					icon = "",
					color = "#c04c0b",
					cterm_color = "202",
					name = "Matlab",
				},
				norg = {
					icon = "",
					color = "#5dbd7e",
					cterm_color = "83",
					name = "Neorg",
				},
				log = {
					icon = "",
					color = "#febc56",
					cterm_color = "220",
					name = "log",
				},
				sty = {
					icon = "",
					color = "#ab47bf",
					cterm_color = "129",
					name = "Style",
				},
			})
		end,
	},

	{
		"b0o/incline.nvim",
		event = "BufReadPre",
		config = function()
			require("incline").setup({
				window = { margin = { vertical = 0, horizontal = 1 } },
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					local icon, color = require("nvim-web-devicons").get_icon_color(filename)
					return { { icon, guifg = color }, { " " }, { filename } }
				end,
			})
		end,
	},

	-- bufferline
	{
		"akinsho/nvim-bufferline.lua",
		event = "VimEnter",
		dependencies = {
			"famiu/bufdelete.nvim",
		},
		init = function()
			-- vim.keymap.set("n", "<s-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
			-- vim.keymap.set("n", "<s-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
			vim.keymap.set("n", "<leader>b[", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous" })
			vim.keymap.set("n", "<leader>b]", "<cmd>BufferLineCycleNext<cr>", { desc = "Next" })
			vim.keymap.set("n", "<leader>bd", "<cmd>Bdelete<CR>", { desc = "Close Current" })
			Vreq("utils.keys").wk_defer({
				["<leader>bc"] = {
					name = "Close",
					[']'] = { "<cmd>BufferLineCloseRight<CR>", "Close Right" },
					['['] = { "<cmd>BufferLineCloseLeft<CR>", "Close Left" },
					c = { "<cmd>Bdelete<CR>", "Close Current" },
				},
				["<leader>"] = {
					['1'] = { "<cmd>BufferLineGoToBuffer 1<CR>", "which_key_ignore" },
					['2'] = { "<cmd>BufferLineGoToBuffer 2<CR>", "which_key_ignore" },
					['3'] = { "<cmd>BufferLineGoToBuffer 3<CR>", "which_key_ignore" },
					['4'] = { "<cmd>BufferLineGoToBuffer 4<CR>", "which_key_ignore" },
					['5'] = { "<cmd>BufferLineGoToBuffer 5<CR>", "which_key_ignore" },
					['6'] = { "<cmd>BufferLineGoToBuffer 6<CR>", "which_key_ignore" },
					['7'] = { "<cmd>BufferLineGoToBuffer 7<CR>", "which_key_ignore" },
					['8'] = { "<cmd>BufferLineGoToBuffer 8<CR>", "which_key_ignore" },
					['9'] = { "<cmd>BufferLineGoToBuffer 9<CR>", "which_key_ignore" },
				},
			})
		end,
		opts = {
			options = {
				color_icons = true, -- whether or not to add the filetype icon highlights
				show_buffer_icons = true, -- disable filetype icons for buffers
				show_buffer_close_icons = true,
				show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
				show_close_icon = false,
				show_tab_indicators = true,
				persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
				-- can also be a table containing 2 custom separators
				-- [focused and unfocused]. eg: { '|', '|' }
				separator_style = "thin", -- "slant" | "thick" | "thin" | { 'any', 'any' }
				enforce_regular_tabs = false,
				always_show_bufferline = true,
				sort_by = "insert_after_current",
				close_command = "Bdelete %d", -- can be a string | function, see "Mouse actions"
				right_mouse_command = "Bdelete %d", -- can be a string | function, see "Mouse actions"
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(_, _, diag)
					local icons = Vreq("utils.config.icons").diagnostics
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
							.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "center",
					},
					{
						filetype = "undotree",
						text = "UndoTree",
						text_align = "center",
					},
				},
				---@diagnostic disable-next-line: unused-local
				custom_filter = function(buf_number, buf_numbers)
					return not Vreq("utils.lua").has_value(Vreq("utils.config.disabled").ft, vim.bo[buf_number].filetype)
				end,
				custom_areas = {
					right = function()
						local result = {}
						local seve = vim.diagnostic.severity
						local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
						local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
						local info = #vim.diagnostic.get(0, { severity = seve.INFO })
						local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

						if error ~= 0 then
							table.insert(result, { text = "  " .. error, guifg = "#EC5241" })
						end

						if warning ~= 0 then
							table.insert(result, { text = "  " .. warning, guifg = "#EFB839" })
						end

						if hint ~= 0 then
							table.insert(result, { text = "  " .. hint, guifg = "#A3BA5E" })
						end

						if info ~= 0 then
							table.insert(result, { text = "  " .. info, guifg = "#7EA9A7" })
						end
						return result
					end,
				}
			},
		},
	},

	-- indent guides for Neovim
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		opts = {
			char = "▏",
			-- char = "│",
			filetype_exclude = Vreq("utils.config.disabled").ft,
			buftype_exclude = Vreq("utils.config.disabled").bt,
			show_trailing_blankline_indent = false,
			show_current_context = false,
			user_treesitter = true,
			show_first_indent_level = true,
		},
	},

	-- lsp symbol navigation for lualine
	{
		"SmiteshP/nvim-navic",
		init = function()
			vim.g.navic_silence = true
			Vreq("utils.lsp").on_attach(function(client, buffer)
				if client.server_capabilities.documentSymbolProvider then
					require("nvim-navic").attach(client, buffer)
				end
			end)
		end,
		opts = { separator = " ", highlight = true, depth_limit = 5 },
	},

	{
		"luukvbaal/statuscol.nvim",
		enabled = false,
		event = "VeryLazy",
		config = true,
	},

	-- better vim.notify
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Delete all Notifications",
			},
			{
				"<leader>sn",
				"<cmd>Telescope notify theme=dropdown<cr>",
				desc = "Notifications",
			}
		},
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
	},

	-- dashboard
	{
		"goolord/alpha-nvim",
		dependencies = {
			"akinsho/nvim-bufferline.lua",
		},
		event = "VimEnter",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo = table.concat({
				"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
				"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
				"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
				"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
				"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
				"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			}, "\n")

			local function make_group(buttons)
				return {
					type = "group",
					val = buttons,
					opts = {
						spacing = 1,
					},
				}
			end

			local function make_padding(val)
				return { type = "padding", val = val }
			end

			dashboard.section.header.val = vim.split(logo, "\n")
			dashboard.section.buttons.val = {
				make_padding(1),
				make_group({
					dashboard.button("n", " " .. " New file", ":ene<CR>"),
					dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
					dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
					dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
					dashboard.button("p", " " .. " Find project",
						":Lazy load workspaces.nvim | Telescope workspaces <CR>"),
					dashboard.button("b", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
				}),
				make_group({
					dashboard.button("s", " " .. " Config", ":e $MYVIMRC | cd %:p:h<CR>"),
					dashboard.button("l", "痢" .. " Lazy", ":Lazy<CR>"),
					dashboard.button("q", " " .. " Quit", ":qa<CR>"),
				}),
				make_padding(1),
			}
			-- for _, button in ipairs(dashboard.section.buttons.val) do
			-- 	button.opts = {
			-- 		hl = "AlphaButtons",
			-- 		hl_shortcut = "AlphaShortcut",
			-- 	}
			-- end
			-- dashboard.section.footer.opts.hl = "Type"
			-- dashboard.section.header.opts.hl = "AlphaHeader"
			-- dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.opts.layout[1].val = 4
			return dashboard
		end,
		config = function(_, dashboard)
			vim.b.miniindentscope_disable = true

			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.config)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = "Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaReady",
				desc = "disable tabline for alpha",
				callback = function()
					vim.opt.showtabline = 0
					vim.api.nvim_create_autocmd("BufUnload", {
						buffer = 0,
						desc = "enable tabline after alpha",
						callback = function()
							vim.opt.showtabline = 2
						end,
					})
				end,
			})
		end,
	},

	-- scrollbar
	{
		"petertriho/nvim-scrollbar",
		event = "BufReadPost",
		dependencies = {
			"ellisonleao/gruvbox.nvim",
		},
		config = function()
			local scrollbar = require("scrollbar")
			-- local colors = require("tokyonight.colors").setup()
			local colors = require("gruvbox.palette")
			local groups = require("gruvbox.groups").setup()
			scrollbar.setup({
				handle = { color = colors.bg4 },
				-- excluded_filetypes = { "prompt", "TelescopePrompt", "noice", "notify" },
				show_in_active_only = true,
				hide_if_all_visible = true,
				excluded_filetypes = Vreq("utils.config.disabled").ft,
				marks = {
					Search = { color = groups.orange },
					Error = { color = groups.error },
					Warn = { color = groups.warning },
					Info = { color = groups.info },
					Hint = { color = groups.hint },
					Misc = { color = groups.purple },
				},
			})
		end,
	},

	{
		"norcalli/nvim-terminal.lua",
		event = "VeryLazy",
	},

	-- references
	{
		"RRethy/vim-illuminate",
		event = "BufReadPost",
		opts = {
			delay = 200,
			filetypes_denylist = Vreq("utils.config.disabled").ft,
		},
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
		-- stylua: ignore
		keys = {
			{ "]]", function() require("illuminate").goto_next_reference(false) end, desc = "Next Reference", },
			{ "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev Reference" },
		},
	},

	-- pretty fold
	{
		"anuvyklack/pretty-fold.nvim",
		event = "VeryLazy",
	},

	-- range command highlight
	{
		"winston0410/range-highlight.nvim",
		event = "CmdlineEnter",
		dependencies = "winston0410/cmd-parser.nvim",
		config = function(_, _)
			require("range-highlight").setup()
		end
	},

	{
		"lukas-reineke/virt-column.nvim",
		event = "VeryLazy",
		config = function()
			require("virt-column").setup()
		end,
	},
}
