local dap = require("dap")

-- local f = assert(io.popen("which lldb-vscode", 'r'))
-- local lldb_vscode_path = assert(f:read('*a'))
-- f:close()
--
dap.adapters.lldb = {
	type = 'executable',
	command = "lldb-vscode",
	name = "lldb"
}

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",

		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		runInTerminal = false,

		--[[ program = function () return vim.fn.getcwd() .. "/build/mhnac" end, ]]

		args = {},
		env = function()
			local variables = {}
			for k, v in pairs(vim.fn.environ()) do
				table.insert(variables, string.format("%s=%s", k, v))
			end
			return variables
		end,
	},
	{
		-- If you get an "Operation not permitted" error using this, try disabling YAMA:
		--  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		name = "Attach to process",
		type = 'lldb', -- Adjust this to match your adapter name (`dap.adapters.<name>`)
		request = 'attach',
		pid = require('dap.utils').pick_process,
		args = {},
		env = function()
			local variables = {}
			for k, v in pairs(vim.fn.environ()) do
				table.insert(variables, string.format("%s=%s", k, v))
			end
			return variables
		end,
	},
}

---@type string
local _launch_last = nil
dap.configurations.cpp[1].program = function()
	---@type string
	local input

	if _launch_last then
		---@diagnostic disable-next-line: redundant-parameter, param-type-mismatch
		input = vim.fn.input('Path to executable: ', _launch_last, 'file')
	else
		---@diagnostic disable-next-line: redundant-parameter, param-type-mismatch
		input = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
	end
	_launch_last = input

	dap.configurations.cpp[1].args = {}

	local i, j = input:find("%S+")

	for w in input:sub(j + 2, -1):gmatch("%S+") do
		---@diagnostic disable-next-line: undefined-field
		table.insert(dap.configurations.cpp[1].args, w)
	end


	return input:sub(i, j)
end


-- Same for C and Rust
dap.configurations.c = dap.configurations.cpp
dap.configurations.c[2].type = "c"
