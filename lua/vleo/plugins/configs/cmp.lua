local M = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		{
			"tzachar/cmp-fuzzy-path",
			dependencies = { "tzachar/fuzzy.nvim" },
		},
		{
			"tzachar/cmp-fuzzy-buffer",
			dependencies = { "tzachar/fuzzy.nvim" },
		},
		"saadparwaiz1/cmp_luasnip",
		"f3fora/cmp-spell",
		"hrsh7th/cmp-nvim-lsp-document-symbol",
		"hrsh7th/cmp-cmdline",
		{
			"petertriho/cmp-git",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = {
				remotes = { "upstream", "origin", "github" },
			}
		},
		"davidsierradz/cmp-conventionalcommits",
		{ "rcarriga/cmp-dap", dependencies = { "mfussenegger/nvim-dap" } },
	},
}

M.config = function(_, _)
	local cmp = require("cmp")
	cmp.setup({
		completion = {
			completeopt = "menu,menuone,noinsert",
		},
		window = {
			--[[ documentation = "native", ]]
			documentation = cmp.config.window.bordered(),
			completion = cmp.config.window.bordered(),
		},
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1)),
			["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1)),
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = function() cmp.complete() end,
			--[[ ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), ]]
			["<C-c>"] = cmp.mapping {
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			},
			["<C-e>"] = cmp.mapping.abort(),

			["<CR>"] = cmp.mapping.confirm({ select = true }),
			--[[ ["<CR>"] = cmp.mapping.confirm { ]]
			--[[	behavior = cmp.ConfirmBehavior.Replace, ]]
			--[[	select = false ]]
			--[[ }, ]]
			["<C-k>"] = cmp.mapping.confirm {
				behavior = cmp.ConfirmBehavior.Replace,
				select = true
			},
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-n>"] = cmp.mapping.select_next_item(),
		}),
		sources = cmp.config.sources(
			{
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			},
			{
				-- { name = "path" },
				{ name = 'fuzzy_path' },
				{ name = "buffer" },
				-- { name = 'fuzzy_buffer' },
			},
			{ { name = "git" } },
			{ {
				name = "spell",
				option = {
					keep_all_entries = false,
					enable_in_context = function()
						return require('cmp.config.context').in_treesitter_capture('spell')
					end,
					is_available = function()
						return require('cmp.config.context').in_treesitter_capture('spell')
					end,
				},
			} }
		),
		formatting = {
			format = function(_, item)
				local icons = Vreq("utils.config.icons").kinds
				if icons[item.kind] then
					item.kind = icons[item.kind] .. item.kind
				end
				return item
			end,
		},
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Insert,
			-- select = false,
			select = true,
		},
		experimental = {
			ghost_text = {
				hl_group = "LspCodeLens",
			},
		},
		--[[ sorting = { ]]
		--[[	comparators = { ]]
		--[[		compare.offset, ]]
		--[[		compare.exact, ]]
		--[[		compare.score, ]]
		--[[		require "cmp-under-comparator".under, ]]
		--[[		require("clangd_extensions.cmp_scores"), ]]
		--[[		compare.kind, ]]
		--[[		compare.sort_text, ]]
		--[[		compare.length, ]]
		--[[		compare.order, ]]
		--[[	}, ]]
		--[[ }, ]]

		enabled = function()
			-- disable completion in comments
			local context = require 'cmp.config.context'
			-- keep command mode completion enabled when cursor is in a comment
			if vim.api.nvim_get_mode().mode == 'c' then
				return true
			else
				return not context.in_treesitter_capture("comment")
						and not context.in_syntax_group("Comment")
						and vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
						or require("cmp_dap").is_dap_buffer()
			end
		end,
		--[[ enabled = function() ]]
		--[[ return	vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" ]]
		--[[ 				--[[ or require("cmp_dap").is_dap_buffer() ]]
		--[[ end, ]]
	})

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline({
			["<C-k>"] = {
				c = function()
					cmp.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true
					})
					cmp.complete()
				end,
			}
		}),
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		sources = cmp.config.sources(
		-- { { name = "path" } },
			{ { name = 'fuzzy_path' } },
			{ { name = "cmdline" } }
		)
	})

	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources(
			{ { name = "nvim_lsp_document_symbol" } },
			{ { name = "buffer" } }
		-- { { name = 'fuzzy_buffer' } }
		)
	})

	cmp.setup.filetype("gitcommit", {
		sources = cmp.config.sources(
			{ { name = "conventionalcommits" } },
			{ { name = "git" } },
			{ { name = "buffer" } }
		-- { { name = 'fuzzy_buffer' } }
		),
	})

	cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
		sources = cmp.config.sources(
			{ { name = "dap" } }
		)
	})

	---@diagnostic disable-next-line: missing-parameter
	vim.keymap.set("i", "<c-p>", cmp.mapping.complete(), { desc = "Previous completion item" })
	---@diagnostic disable-next-line: missing-parameter
	vim.keymap.set("i", "<c-n>", cmp.mapping.complete(), { desc = "Next completion item" })

	Vreq("utils").allmap("<M-k>", Vreq("utils.cmp").toggle, { desc = "Toggle CMP" })
end

return M
