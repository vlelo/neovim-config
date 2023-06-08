return {
	{
		"folke/neodev.nvim",
	},

	{
		"p00f/clangd_extensions.nvim",
	},

	{
		"ranjithshegde/ccls.nvim",
	},

	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		opts = {
			ui = {
				widht = 0.7,
				height = 0.7,
				border = "rounded",
				icons = {
					package_installed = " ",
					package_pending = " ",
					package_uninstalled = " ",
				},
			},
		},
	},

	{ "williamboman/mason-lspconfig.nvim" },
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			{
				"jose-elias-alvarez/null-ls.nvim",
				event = { "BufReadPre", "BufNewFile" },
			},
		},
		config = function()
			local nls = require("null-ls")
			require("mason-null-ls").setup({
				ensure_installed = {},
				automatic_installation = false,
				handlers = {
					-- function() end, -- disables automatic setup of all null-ls sources

					stylua = function(source_name, methods)
						nls.register(nls.builtins.formatting.stylua)
					end,
					shfmt = function(source_name, methods)
						require("mason-null-ls").default_setup(source_name, methods) -- to maintain default behavior
					end,
					fixjson = function(source_name, methods)
						nls.register(nls.builtins.formatting.fixjson.with({ filetypes = { "jsonc", "json" } }))
					end,
					-- nls.builtins.diagnostics.luacheck,
					selene = function(source_name, methods)
						nls.register(nls.builtins.diagnostics.selene.with({
							condition = function(utils)
								return utils.root_has_file({ "selene.toml" })
							end,
						}))
					end,

					flake8 = function(source_name, methods)
						nls.register(nls.builtins.diagnostics.flake8.with({
							extra_args = {
								"--max-line-length=90",
							},
						}))
					end,
				},
			})
			nls.setup({ -- everything else not supported by mason
				debounce = 150,
				save_after_format = false,
				sources = {
					-- nls.builtins.formatting.fish_indent,
					-- nls.builtins.diagnostics.mlint,

					nls.builtins.code_actions.gitsigns,
				},
				root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", ".git", "Makefile"),
			})
		end,
	},

	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
	},
}
