local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name) return vim.api.nvim_create_augroup(name, { clear = true }) end

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })

-- Highlight on yank
autocmd("TextYankPost", {
	desc = "Highlight on yank",
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
	desc = "Go to last location when opening a buffer",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

autocmd("FileType", {
	desc = "Close some filetypes with q",
	pattern = {
		"qf",
		"help",
		-- "man",
		"notify",
		"lspinfo",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"PlenaryTestPopup",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

autocmd("FileType", {
	pattern = { "gitcommit", "markdown" },
	desc = "Better markdown",
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

autocmd({ "BufWritePre" }, {
	group = augroup("noTempUndofile"),
	desc = "Disable undofile for temporary files.",
	pattern = "/tmp/*",
	command = "setlocal noundofile",
})

autocmd({ "DirChanged" }, {
	group = augroup("exrc"),
	desc = "Automatically execute exrc when changing directory",
	callback = function()
		local cwd = vim.loop.cwd()
		local res = vim.secure.read(cwd .. "/.nvim.lua")
		if res then
			dofile(cwd .. "/.nvim.lua")
			return
		end
		res = vim.secure.read(cwd .. "/.nvimrc")
		if res then
			vim.cmd("source " .. cwd .. "/.nvimrc")
			return
		end
		res = vim.secure.read(cwd .. "/.exrc")
		if res then
			vim.cmd("source " .. cwd .. "/.exrc")
			return
		end
	end,
})

autocmd({ "BufNewFile", "BufRead" }, {
	group = augroup("direnvFiletype"),
	pattern = ".envrc",
	desc = "Set `sh` filetype when loading .envrc file.",
	command = "set filetype=sh",
})
