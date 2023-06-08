return function(capabilities)
	local opts = {}
	opts.capabilities = capabilities
	opts.capabilities.offsetEncoding = { "utf-16" }

	require("lspconfig").ccls.setup(opts)
	-- require("ccls").setup({ lsp = { lspconfig = opts } })
end
