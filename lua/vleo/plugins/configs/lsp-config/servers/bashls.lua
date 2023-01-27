return function(capabilities)
	local opts = {
		capabilities = capabilities,
		filetypes = { "sh", "zsh", "bash" },
		single_file_support = true,
	}
	require("lspconfig").bashls.setup(opts)
end
