local H = require("hydra")

local hint = [[
           DAP
	_b_ Toggle breakpoint
	_c_ Continue
	_C_ Run to cursor
	_o_ Step over
	_i_ Step into
  ^ ^                     
	_q_            _<Esc>_
]]

H({
	name = "DAP",
	mode = { "n" },
	body = "<leader>dd",
	hint = hint,
	config = {
		exit = false,
		color = "pink",
		invoke_on_body = true,
		desc = "Hydra DAP",
		timeout = false,
		hint = {
			type = "window",
			position = "middle-right",
			border = "rounded",
		},
	},
	heads = {
		{ "b", require("dap").toggle_breakpoint },
		{ "c", require("dap").continue },
		{ "C", require("dap").run_to_cursor },
		{ "o", require("dap").step_over },
		{ "i", require("dap").step_into },
		{ "q", nil, { exit = true } },
		{ "<Esc>", nil, { exit = true } },
	},
})
