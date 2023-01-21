local window_width_limit = 80

local M = {}

M.buffer_not_empty = function()
	return vim.fn.empty(vim.fn.expand "%:t") ~= 1
end

M.hide_in_width = function()
	return vim.fn.winwidth(0) > window_width_limit
end

M.is_toggleterm = function()
	return vim.bo.filetype == "toggleterm"
end

return M
