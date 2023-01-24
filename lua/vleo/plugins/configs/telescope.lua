local Util = Vreq("utils")

local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-lua/plenary.nvim",
		{
			"debugloop/telescope-undo.nvim",
			keys = {
				{ "<leader>u", "<cmd>Telescope undo<cr>", desc = "Undotree" },
			}
		},
	},
	cmd = "Telescope",
	version = false, -- telescope did only one release, so use HEAD for now
}

M.keys = {
	{ "<leader>f,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
	{ "<leader>fg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
	{ "<leader>fG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
	{ "<leader>f:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
	--[[ { "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)" }, ]]
	{ "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
	{ "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
	{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
	{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
	{ "<leader>fc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
	{ "<leader>fs", "<cmd>Telescope git_status<CR>", desc = "status" },
	{ "<leader>fm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
	{
		"<leader>fs",
		Util.telescope("lsp_document_symbols", {
			symbols = {
				"Class",
				"Function",
				"Method",
				"Constructor",
				"Interface",
				"Module",
				"Struct",
				"Trait",
				"Field",
				"Property",
			},
		}),
		desc = "Goto Symbol",
	},

	{ "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
	{ "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
	{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
	{ "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
	{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
	{ "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
	{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
	{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
	{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
	{ "<leader>st", "<cmd>Telescope builtin<cr>", desc = "Telescope" },
	{ "<leader>su", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
	{
		"<leader>sp",
		function()
			require("telescope.builtin").find_files({
				cwd = require("lazy.core.config").options.root,
			})
		end,
		desc = "Find Plugin File",
	},
}

M.opts = function()
	local action_layout = require("telescope.actions.layout")
	return {
		defaults = {
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "bottom",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.87,
				height = 0.80,
				preview_cutoff = 120,
			},
			sorting_strategy = "ascending",
			winblend = 0,
			prompt_prefix = " ",
			selection_caret = " ",
			entry_prefix = "  ",
			mappings = {
				i = {
					["<c-t>"] = function(...)
						return require("trouble.providers.telescope").open_with_trouble(...)
					end,
					["<C-i>"] = function()
						Util.telescope("find_files", { no_ignore = true })()
					end,
					["<C-h>"] = function()
						Util.telescope("find_files", { hidden = true })()
					end,
					["<C-Down>"] = function(...)
						return require("telescope.actions").cycle_history_next(...)
					end,
					["<C-Up>"] = function(...)
						return require("telescope.actions").cycle_history_prev(...)
					end,
					["<M-p>"] = action_layout.toggle_preview,
				},
				n = {
					["<M-p>"] = action_layout.toggle_preview,
					["<c-t>"] = function(...)
						return require("trouble.providers.telescope").open_with_trouble(...)
					end,
				},
			},
			file_sorter = require("telescope.sorters").get_fuzzy_file,
			file_ignore_patterns = {},
			generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
			path_display = { "smart" },
			border = {},
			borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			color_devicons = true,
			use_less = true,
			set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
			dynamic_preview_title = true,
			extensions = {
				undo = {
					side_by_side = true,
					layout_strategy = "vertical",
					layout_config = {
						preview_height = 0.8,
					},
				},
			},
		},
	}
end

M.config = function(_, opts)
	local telescope = require("telescope")
	telescope.setup(opts)
	telescope.load_extension("fzf")
	telescope.load_extension("undo")
	telescope.load_extension("notify")
end

return M
