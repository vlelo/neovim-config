local M = {}

local wk_table = {}
function M.wk_defer(keys, opts)
	if wk_table then -- keys not yet applied
		table.insert(wk_table, { keys = keys, opts = opts })
	else
		require("which-key").register(keys, opts)
	end
end

function M.wk_apply(wk)
	for _, kmap in ipairs(wk_table) do
		wk.register(kmap.keys, kmap.opts)
	end
	wk_table = nil
end

return M
