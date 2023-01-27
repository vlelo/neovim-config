local M = {}

function M.fontscale(n)
	if type(n) ~= "number" then
		return
	end

	local gfa = {}
	for c in vim.gsplit(vim.o.guifont, ":") do
		table.insert(gfa, c)
	end
	local buildnewgf = ""
	for k, v in ipairs(gfa) do
		if v:find("h", 1, true) == 1 then
			local fweight = ""
			for w in vim.gsplit(v, "h") do
				if tonumber(w) == nil then
					goto continue
				end
				local wn = tonumber(w)
				wn = wn + n
				fweight = fweight .. tostring(wn)
				::continue::
			end

			buildnewgf = buildnewgf .. "h" .. fweight .. ":"
		else
			v = string.gsub(v, " ", "_")
			buildnewgf = buildnewgf .. v .. ":"

		end
	end

	local setcmd = "set guifont=" .. buildnewgf
	vim.cmd(setcmd)
end

function M.home()
	require("alpha").start()
	local startpage = vim.api.nvim_get_current_buf()
	local buffers = vim.api.nvim_list_bufs()
	for _, buf in ipairs(buffers) do
		if buf ~= startpage then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
	-- vim.cmd":bd|e#"
	vim.fn.chdir(vim.loop.os_getenv("HOME"))
end

return M
