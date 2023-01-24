return {
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{ "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		---@class PluginLspOpts
		opts = {
			ensure_installed = {
				"clangd",
				"sumneko_lua",
			},
		},
		---@param opts PluginLspOpts
		config = function(_, opts)
			-- setup formatting and keymaps
			Vreq("utils.lsp").on_attach(function(client, buffer)
				Vreq("plugins.configs.lsp-config.format").on_attach(client, buffer)
				Vreq("plugins.configs.lsp-config.keymaps").on_attach(client, buffer)
			end)

			--[[ -- add rounded corner to :LspInfo ]]
			local win = require("lspconfig.ui.windows")
			win.default_options.border = "rounded"

			-- diagnostics
			for name, icon in pairs(Vreq("utils.config.icons").diagnostics) do
				name = "DiagnosticSign" .. name
				vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
			end
			vim.diagnostic.config({
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, prefix = "●" },
				severity_sort = true,
				float = { border = "rounded" },
			})

			local servers = opts.ensure_installed
			local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true
			}
			local serv_conf = "plugins.configs.lsp-config.servers."

			require("mason-lspconfig").setup({ ensure_installed = servers })
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					local server_opts = {}
					server_opts.capabilities = capabilities
					require("lspconfig")[server_name].setup(server_opts)
				end,
				["arduino_language_server"] = Vreq(serv_conf .. "arduino_language_server")(capabilities),
				["clangd"] = Vreq(serv_conf .. "clangd")(capabilities),
				["jsonls"] = Vreq(serv_conf .. "jsonls")(capabilities),
				--[[ ["ltex"] = Vreq(serv_conf .. "ltex")(capabilities), ]]
				["pyright"] = Vreq(serv_conf .. "pyright")(capabilities),
				["sumneko_lua"] = Vreq(serv_conf .. "sumneko_lua")(capabilities),
				["texlab"] = Vreq(serv_conf .. "texlab")(capabilities),
			})
		end,
	},
}
