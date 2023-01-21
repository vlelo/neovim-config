return {
	{
		"folke/neodev.nvim",
	},

	{
		"p00f/clangd_extensions.nvim",
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
					package_installed = "",
					package_pending = "",
					package_uninstalled = ""
				}
			},
		}
	},

	{ "williamboman/mason-lspconfig.nvim", },

	-- null-ls
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local nls = require("null-ls")
			nls.setup({
				debounce = 150,
				save_after_format = false,
				sources = {
					-- nls.builtins.formatting.prettierd,
					nls.builtins.formatting.stylua,
					nls.builtins.formatting.fish_indent,
					-- nls.builtins.formatting.fixjson.with({ filetypes = { "jsonc" } }),
					-- nls.builtins.formatting.eslint_d,
					-- nls.builtins.diagnostics.shellcheck,
					nls.builtins.formatting.shfmt,
					nls.builtins.diagnostics.markdownlint,
					-- nls.builtins.diagnostics.luacheck,
					nls.builtins.formatting.prettierd.with({
						filetypes = { "markdown" }, -- only runs `deno fmt` for markdown
					}),
					nls.builtins.diagnostics.selene.with({
						condition = function(utils)
							return utils.root_has_file({ "selene.toml" })
						end,
					}),
					nls.builtins.code_actions.gitsigns,
					nls.builtins.formatting.isort,
					nls.builtins.formatting.black,
					nls.builtins.diagnostics.flake8,
				},
				root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", ".git"),
			})
		end,
	},

	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
	},
}
