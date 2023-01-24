local M = {
	"mfussenegger/nvim-dap",

	dependencies = {
		{
			"rcarriga/nvim-dap-ui",

			opts = {
				icons = { expanded = "▾", collapsed = "▸", current_frame = "⇒" },
				mappings = {
					-- Use a table to apply multiple mappings
					expand = { "<CR>", "<2-LeftMouse>", "i" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				expand_lines = true,
				layouts = {
					{
						elements = {
							-- Elements can be strings or table with id and size keys.
							{ id = "scopes", size = 0.25 },
							--[[ { id = "breakpoints", size = 0.25 }, ]]
							--[[ { id = "watches", size = 0.25 }, ]]
							"breakpoints",
							"watches",
							"stacks",
							-- { id = "stacks", size = 0.25 },
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							"repl",
							-- "console",
						},
						size = 0.25,
						position = "bottom",
					},
				},
				controls = {
					-- Requires Neovim nightly (or 0.8 when released)
					enabled = true,
					-- Display controls in this element
					element = "repl",
					icons = {
						pause = "",
						play = "",
						step_into = "",
						step_over = "",
						step_out = "",
						step_back = "",
						run_last = "",
						terminate = "",
					},
				},
				floating = {
					max_height = nil, -- These can be integers or a float between 0 and 1.
					max_width = nil, -- Floats will be treated as percentage of your screen.
					border = "rounded", -- Border style. Can be "single", "double" or "rounded"
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = {
					indent = 1
				},
				render = {
					max_type_length = nil, -- Can be integer or nil.
					maz_value_lines = 100,
				},
			},
			config = function(_, opts)
				require("dapui").setup(opts)
			end,
		},
		{ "jbyuki/one-small-step-for-vimkind" },
		{ "theHamsta/nvim-dap-virtual-text" },
	},
}

function M.init()
	Vreq("utils.keys").wk_defer({
		["<leader>d"] = "Debug",
	})

	vim.keymap.set("n", "<leader>db", function()
		require("dap").toggle_breakpoint()
	end, { desc = "Toggle Breakpoint" })

	vim.keymap.set("n", "<leader>dc", function()
		require("dap").continue()
	end, { desc = "Continue" })

	vim.keymap.set("n", "<leader>dC", function()
		require("dap").run_to_cursor()
	end, { desc = "Run to cursor" })

	vim.keymap.set("n", "<leader>do", function()
		require("dap").step_over()
	end, { desc = "Step Over" })

	vim.keymap.set("n", "<leader>di", function()
		require("dap").step_into()
	end, { desc = "Step Into" })

	vim.keymap.set("n", "<leader>dw", function()
		require("dap.ui.widgets").hover()
	end, { desc = "Widgets" })

	vim.keymap.set("n", "<leader>dr", function()
		require("dap").repl.open()
	end, { desc = "Repl" })

	vim.keymap.set("n", "<leader>du", function()
		require("dapui").toggle({})
	end, { desc = "Dap UI" })

	vim.keymap.set("n", "<leader>ds", function()
		require("osv").launch({ port = 8086 })
	end, { desc = "Launch Lua Debugger Server" })

	vim.api.nvim_create_user_command("NeovimDebug", function()
		require("osv").run_this()
	end, {
		desc = "Launch Lua Debugger",
	})
end

function M.config()
	local dap = require("dap")

	Vreq("utils").load_mod("plugins.configs.dap.adapters", {
		"nlua",
		"lldb-vscode",
	})

	local dapui = require("dapui")
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open({})
	end
	-- dap.listeners.before.event_terminated["dapui_config"] = function()
	-- 	dapui.close({})
	-- end
	-- dap.listeners.before.event_exited["dapui_config"] = function()
	-- 	dapui.close({})
	-- end

	vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
	vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "", linehl = "", numhl = "" })
	vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
	vim.fn.sign_define("DapStopped",
		{ text = "", texthl = "DiagnosticSignInfo", linehl = "DiagnosticUnderlineInfo",
			numhl = "DiagnosticSignInfo" })
	vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticSignHint", linehl = "", numhl = "" })

	local keymap_restore = {}
	dap.listeners.after["event_initialized"]["me"] = function()
		for _, buf in pairs(vim.api.nvim_list_bufs()) do
			local keymaps = vim.api.nvim_buf_get_keymap(buf, "n")
			for _, keymap in pairs(keymaps) do
				if keymap.lhs == "K" then
					table.insert(keymap_restore, keymap)
					vim.api.nvim_buf_del_keymap(buf, "n", "K")
				end
			end
		end
		vim.keymap.set(
			'n', 'K', '<Cmd>lua require("dapui").eval()<CR>', { desc = "Dap inspect" })
	end

	dap.listeners.after['event_terminated']['me'] = function()
		for _, keymap in pairs(keymap_restore) do
			print(vim.inspect(keymap))
			vim.keymap.set(
				keymap.mode,
				keymap.lhs,
				keymap.rhs or keymap.callback,
				{ silent = keymap.silent == 1, buffer = keymap.buffer, desc = keymap.desc }
			)
		end
		keymap_restore = {}
	end

	local cmd = vim.api.nvim_create_user_command
	cmd('Dap', function() require 'telescope'.extensions.dap.commands(
			require 'telescope.themes'.get_dropdown({
				previewer = false,
			})
		)
	end, {})
	cmd('DapFrames', function() require 'telescope'.extensions.dap.frames(
			require 'telescope.themes'.get_dropdown({
				-- previewer = false,
			})
		)
	end, {})
	cmd('DapVars', function() require 'telescope'.extensions.dap.variables(
			require 'telescope.themes'.get_dropdown({
				-- previewer = false,
			})
		)
	end, {})
	cmd('DapClearBreakpoints', function() require('dap').clear_breakpoints() end, {})
	cmd('DapShowLog', 'split | e ' .. vim.fn.stdpath('cache') .. '/dap.log | normal! G', {})
	cmd('DapContinue', function() require('dap').continue() end, { nargs = 0 })
	cmd('DapToggleBreakpoint', function() require('dap').toggle_breakpoint() end, { nargs = 0 })
	cmd('DapToggleRepl', function() require('dap.repl').toggle() end, { nargs = 0 })
	cmd('DapStepOver', function() require('dap').step_over() end, { nargs = 0 })
	cmd('DapStepInto', function() require('dap').step_into() end, { nargs = 0 })
	cmd('DapStepOut', function() require('dap').step_out() end, { nargs = 0 })
	cmd('DapTerminate', function() require('dap').terminate() end, { nargs = 0 })
	cmd('DapRestartFrame', function() require('dap').restart_frame() end, { nargs = 0 })
end

return M
