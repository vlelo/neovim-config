local M = {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
}

M.config = function()
	local focused = true
	vim.api.nvim_create_autocmd("FocusGained", {
		callback = function()
			focused = true
		end,
	})
	vim.api.nvim_create_autocmd("FocusLost", {
		callback = function()
			focused = false
		end,
	})

	require("noice").setup({
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		routes = {
			{
				filter = {
					error = true,
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			},
			{
				filter = {
					event = "msg_show",
					find = "%d+L, %d+B",
				},
				view = "mini",
			},
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			inc_rename = true,
			long_message_to_split = true,
			lsp_doc_border = true, -- add a border to hover docs and signature help
			cmdline_output_to_split = false,
		},
		messages = {
			-- NOTE: If you enable messages, then the cmdline is enabled automatically.
			-- This is a current Neovim limitation.
			enabled = true, -- enables the Noice messages UI
			view = "mini", -- default view for messages
			view_error = "mini", -- view for errors
			view_warn = "mini", -- view for warnings
			view_history = "mini", -- view for :messages
			view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
		},
		popupmenu = {
			enabled = true, -- enables the Noice popupmenu UI
			backend = "cmp", -- backend to use to show regular cmdline completions
		},
		commands = {
			all = {
				-- options for the message history that you get with `:Noice`
				view = "split",
				opts = { enter = true, format = "details" },
				filter = {},
			},
		},
	})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "markdown",
		callback = function(event)
			vim.schedule(function()
				require("noice.text.markdown").keys(event.buf)
			end)
		end,
	})
end

M.keys = {
	{ "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
	{ "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true,
		desc = "Scroll forward" },
	{ "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true,
		desc = "Scroll backward" },
}

return M
