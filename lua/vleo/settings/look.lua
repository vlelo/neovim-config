local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local cursor_group = augroup("CursorLineToggle", { clear = true })
autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
	group = cursor_group,
	desc = "Set cursorline when giving focus to buffer.",
	command = "set cursorline",
})
autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
	group = cursor_group,
	desc = "Remove cursorline when losing focus to buffer.",
	command = "set nocursorline",
})

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "rounded"
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local number_group = augroup("NumberToggle", { clear = true })
autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
	group = number_group,
	desc = "Set relative numbers when giving focus to buffer.",
	callback = function()
		if vim.wo.number == true then
			vim.wo.relativenumber = true
		end
	end
})
autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
	group = number_group,
	desc = "Set absolute numbers when giving focus to buffer.",
	callback = function()
		if vim.wo.number == true and vim.wo.relativenumber == true then
			vim.wo.relativenumber = false
		end
	end
})

-- -- override float function to set rounded border as default
-- local orig_nvim_open_win = vim.api.nvim_open_win
-- function vim.api.nvim_open_win(buffer, enter, config, ...)
-- 	config = config or {}
-- 	config.border = config.border or "rounded"
-- 	return orig_nvim_open_win(buffer, enter, config, ...)
-- end

vim.cmd [[
aunmenu PopUp
anoremenu <silent> PopUp.Detach\ Window			ge
anoremenu <silent> PopUp.Close\ Window      q
anoremenu <silent> PopUp.-1-                <Nop>
anoremenu <silent> PopUp.New\ File					<cmd>ene<cr>
anoremenu <silent> PopUp.Open\ Config				<cmd>e $MYVIMRC<cr>
" anoremenu PopUp.-2-                       <Nop>
]]
