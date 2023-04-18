return function(capabilities)
	local opts = {
		capabilities = capabilities,
		settings = {
			Lua = {
				workspace = {
					checkThirdParty = false,
				},
				completion = {
					workspaceWord = true,
					callSnippet = "Both",
					keywordSnippet = "Both",
					autoRequire = true,
					displayContext = 8,
				},
				diagnostics = {
					globals = {
						Vconf,
					},
					-- enable = false,
					groupSeverity = {
						strong = "Warning",
						strict = "Warning",
					},
					groupFileStatus = {
						["ambiguity"] = "Opened",
						["await"] = "Opened",
						["codestyle"] = "None",
						["duplicate"] = "Opened",
						["global"] = "Opened",
						["luadoc"] = "Opened",
						["redefined"] = "Opened",
						["strict"] = "Opened",
						["strong"] = "Opened",
						["type-check"] = "Opened",
						["unbalanced"] = "Opened",
						["unused"] = "Opened",
					},
					unusedLocalExclude = { "_*" },
				},
				format = {
					enable = false,
					defaultConfig = {
						indent_style = "space",
						indent_size = "2",
						continuation_indent_size = "2",
					},
				},
				hint = {
					enable = true,
				},
				telemetry = {
					enable = false,
				},
			},
		},
		single_file_support = true,
	}

	require("neodev").setup()
	require("lspconfig").lua_ls.setup(opts)
end
