return function(capabilities)
	local opts = {
		capabilities = capabilities,
		settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
					useLibraryCodeForTypes = true,
					stubPath = "src/stubs",
				},
				venvPath = "/opt/homebrew/Caskroom/miniforge/base/envs/",
				useLibraryCodeForTypes = true,
				pythonPath = "python3"
			},
		},
		single_file_support = true,
	}
	require("lspconfig").pyright.setup(opts)
end

