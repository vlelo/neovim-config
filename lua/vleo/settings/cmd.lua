local cmd = vim.api.nvim_create_user_command

cmd("Home", Vreq("utils.gui").home, { desc = "Close all buffers and go to startpage" })

local tab = {
	it = "IT",
	de = "DE",
	en = "US",
}
cmd("Spelllang", function(arg)
		if #arg.fargs ~= 1 then
			vim.notify("Spelllang expects one argument", vim.log.levels.ERROR)
			return
		end
		vim.opt.spelllang = arg.fargs[1]
		-- vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/" .. arg.fargs[1] .. "_" .. tab[arg.fargs[1]] .. ".utf-8.add"
		vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/" .. arg.fargs[1] .. ".utf-8.add"
	end,
	{
		desc = "Set spelllang and spellfile correctly",
		nargs = "*",
		complete = "locale",
		bang = false,
		bar = true,
		register = false
	})
cmd("E", function(arg)
	local args = arg.fargs
	local has_bang = arg.bang
	local path = vim.fn.expand("%:p:h")

	for _, file in pairs(args) do
		vim.cmd.edit({
			args = {
				path .. "/" .. file,
			},
			bang = has_bang
		})
	end
end, {
	desc = "Open file in same folder as current buffer",
	nargs = "+",
	-- complete = "file",
	complete = function(ArgLead, CmdLine, CursorPos)
		local path = vim.fn.expand("%:p:h")
		local ret = vim.split(vim.fn.glob(path .. "/*"), "\n")
		for idx, path in pairs(ret) do
			ret[idx] = "./" .. vim.fn.fnamemodify(path, ":t")
		end
		return ret
	end,
	bar = true,
	bang = true,
	register = false,
})
