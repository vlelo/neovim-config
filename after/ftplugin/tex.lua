vim.bo.textwidth = 90
vim.wo.colorcolumn = "90"
vim.o.formatoptions = vim.o.formatoptions .. "t"
vim.o.spell = true
vim.o.cmdheight = 1

Vreq("utils.keys").wk_defer({
	["<leader>l"] = {
		c = { "<plug>(vimtex-compile)", "Compile document" },
		C = { "<plug>(vimtex-compile-ss)", "Compile document one time" },
		v = { "<plug>(vimtex-compile-selected)", "Compile selected" },
		w = { "<cmd>VimtexCountWords<CR>", "Count words" },
		l = { "<plug>(vimtex-view)", "View line" },
		r = { "<plug>(vimtex-reverse-search)", "Reverse search" },
		x = { "<plug>(vimtex-clean)", "Clean" },
		X = { "<plug>(vimtex-clean-full)", "Full clean" },
		a = { "<cmd>VimtexContextMenu<CR>", "Context menu" },
		q = { "<cmd>VimtexQFMode<cr>", "Toggle Quickfix mode" },
	},
	gO = { "<plug>(vimtex-toc-toggle)", "Toggle ToC" },
},
	{
		buffer = 0,
	})

vim.api.nvim_buf_create_user_command(0, "DeWordify", function()
	vim.cmd [[silent! %s/’/'/g]]
	vim.cmd [[silent! %s/“/``/g]]
	vim.cmd [[silent! %s/”/''/g]]
end, {
	bang = false,
})

vim.api.nvim_buf_create_user_command(0, "VimtexQFMode", function()
	if vim.g.vimtex_quickfix_open_on_warning == 1 then
		vim.g.vimtex_quickfix_open_on_warning = 0
		vim.g.vimtex_quickfix_ignore_filters = {
			"Warning",
			[[Entry type for ".*" isn't style-file defined]],
			[[Missing ".*" in]],
			"Overfull",
			"Underfull",
		}
	else
		vim.g.vimtex_quickfix_open_on_warning = 1
		vim.g.vimtex_quickfix_ignore_filters = {}
	end
end, {
	bang = false,
})
