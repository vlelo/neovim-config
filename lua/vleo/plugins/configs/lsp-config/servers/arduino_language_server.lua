---@diagnostic disable: missing-parameter
-- -- https://github.com/williamboman/nvim-lsp-installer/tree/main/lua/nvim-lsp-installer/servers/arduino_language_server
-- return function(opts, server)
-- 	opts.on_new_config = function(config, root_dir)
-- 		local partial_cmd = server:get_default_options().cmd
-- 		local MY_FQBN = "arduino:avr:nano"
-- 		config.cmd = vim.list_extend(partial_cmd, { "-fqbn", MY_FQBN })
-- 	end
-- 	return opts
-- end

local MY_FQBN = "arduino:avr:uno"

--[[ -- local arduino_cli_yaml, _ = string.gsub(vleo.CONFIGROOT, "nvim/", "", 1) ]]
--[[ -- arduino_cli_yaml = arduino_cli_yaml .. "arduino-cli/arduino-cli.yaml" ]]
--[[ local f = assert(io.popen("which arduino-cli", 'r')) ]]
--[[ local cli_path = assert(f:read('*a')) ]]
--[[ f:close() ]]

local arduino_cli_yaml = vim.fn.expand("~/.config/arduino-cli/arduino-cli.yaml")

--[[ -- local clangd_location = vim.fn.expand("~/.local/share/nvim/lsp_servers/clangd/clangd/bin/clangd") ]]
--[[ f = assert(io.popen("which clangd", 'r')) ]]
--[[ local clangd_location = assert(f:read('*a')) ]]
--[[ f:close() ]]

local clangd_location = "clangd"
local cli_path = "arduino-cli"

return function(capabilities)
	local opts = {}
	opts.settings = {}

	opts.capabilities = capabilities

	opts.cmd = {
		"arduino-language-server",
		"-cli-config", arduino_cli_yaml,
		"-fqbn", MY_FQBN,
		"-cli", cli_path,
		"-clangd", clangd_location,
		--[[ "-logpath", "/Users/vleo/Downloads/arduinoservermerda", ]]
		--[[ "-log" ]]
	}

	require("lspconfig").arduino_language_server.setup(opts)
end
