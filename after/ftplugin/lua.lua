---@diagnostic disable: unused-local, missing-parameter
local q = require("vim.treesitter.query")
local bufnr = 0

local query = vim.treesitter.query.parse("lua", [[
(table_constructor
	(field) @campo
)
]])

local function comma()
	---@diagnostic disable-next-line: param-type-mismatch
	local language_tree = vim.treesitter.get_parser(bufnr, "lua")
	local tree = language_tree:parse()
	local found = false

	local cursor = vim.api.nvim_win_get_cursor(0)
	-- { row, col }

	for id, node, metadata in query:iter_matches(tree[1]:root(), bufnr) do
		local row1, col1, row2, col2 = node[1]:range()

		if row1 + 1 == cursor[1] and cursor[2] <= col2 then
			found = true
			local pos = {
				row1 + 1,
				col2
			}
			vim.api.nvim_win_set_cursor(0, pos)

			local new_cursor = vim.api.nvim_win_get_cursor(0)
			-- if EOF
			if pos[2] ~= new_cursor[2] then
				vim.api.nvim_buf_set_text(bufnr, new_cursor[1] - 1, new_cursor[2] + 1, new_cursor[1] - 1, new_cursor[2] + 1,
					{ ',' })
			else
				local char = vim.api.nvim_get_current_line():sub(new_cursor[2] + 1, new_cursor[2] + 1)
				if char ~= ',' then
					vim.api.nvim_buf_set_text(bufnr, new_cursor[1] - 1, new_cursor[2], new_cursor[1] - 1, new_cursor[2], { ',' })
				else
					vim.api.nvim_win_set_cursor(0, cursor)
				end
			end
		end
	end
	if not found then
		vim.api.nvim_win_set_cursor(0, { cursor[1], 10000 })
		local pos = vim.api.nvim_win_get_cursor(0)
		local char = vim.api.nvim_get_current_line():sub(pos[2], pos[2])
		if char == ',' then
			vim.api.nvim_buf_set_text(bufnr, pos[1] - 1, pos[2] - 1, pos[1] - 1, pos[2], { '' })
		end
		vim.api.nvim_win_set_cursor(0, cursor)
	end
end

vim.keymap.set("i", ",,", comma, { buffer = true, desc = "which_key_ignore" })
