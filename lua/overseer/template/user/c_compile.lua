return {
	name = "C file compile",
	builder = function()
		local file = vim.fn.expand("%:p")
		local out = vim.fn.expand("%:p:r")
		return {
			cmd = { "cc" },
			args = { "-o", out, file },
			components = { { "on_output_quickfix", open = true }, "default" },
		}
	end,
	condition = {
		filetype = { "c" },
	},
}
