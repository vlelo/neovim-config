vim.bo.textwidth = 90
vim.wo.colorcolumn = "90"
vim.o.formatoptions = vim.o.formatoptions .. "t"
vim.o.spell = true
vim.o.cmdheight = 1

Vreq("utils.keys").wk_defer({
		["<leader>l"] = {
			c = { "<plug>(vimtex-compile)", "Compile document" },
			C = { "<plug>(vimtex-compile-ss)", "Compile document one time" },
			v = { "<plug>(vimtex-compile-selected)", "Compile selected" },
			w = { "<cmd>VimtexCountWords<CR>", "Count words" },
			l = { "<plug>(vimtex-view)", "View line" },
			r = { "<plug>(vimtex-reverse-search)", "Reverse search" },
			x = { "<plug>(vimtex-clean)", "Clean" },
			X = { "<plug>(vimtex-clean-full)", "Full clean" },
			a = { "<cmd>VimtexContextMenu<CR>", "Context menu" },
			q = { "<cmd>VimtexQFMode<cr>", "Toggle Quickfix mode" },
		},
		gO = { "<plug>(vimtex-toc-toggle)", "Toggle ToC" },
	},
	{
		buffer = 0,
	})

vim.api.nvim_buf_create_user_command(0, "DeWordify", function()
	vim.cmd [[silent! %s/’/'/g]]
	vim.cmd [[silent! %s/“/``/g]]
	vim.cmd [[silent! %s/”/''/g]]
end, {
	bang = false,
})

vim.api.nvim_buf_create_user_command(0, "VimtexQFMode", function()
	if vim.g.vimtex_quickfix_open_on_warning == 1 then
		vim.g.vimtex_quickfix_open_on_warning = 0
		vim.g.vimtex_quickfix_ignore_filters = {
			-- "Warning",
			[[Entry type for ".*" isn't style-file defined]],
			[[Missing ".*" in]],
			"Overfull",
			"Underfull",
			"specifier changed to",
			"Token not allowed in a PDF string",
		}
	else
		vim.g.vimtex_quickfix_open_on_warning = 1
		vim.g.vimtex_quickfix_ignore_filters = {}
	end
end, {
	bang = false,
})

-- local config = require("nvim-surround.config")
require("nvim-surround").buffer_setup({
	surrounds = {
		-- ["e"] = {
		--   add = function()
		--     local env = require("nvim-surround.config").get_input ("Environment: ")
		--     return { { "\\begin{" .. env .. "}" }, { "\\end{" .. env .. "}" } }
		--   end,
		-- },
		["Q"] = {
			add = { "``", "''" },
			find = "%b``.-''",
			delete = "^(``)().-('')()$",
		},
		["q"] = {
			add = { "`", "'" },
			find = "`.-'",
			delete = "^(`)().-(')()$",
		},
		["b"] = {
			add = { "\\textbf{", "}" },
			-- add = function()
			--   if vim.fn["vimtex#syntax#in_mathzone"]() == 1 then
			--     return { { "\\mathbf{" }, { "}" } }
			--   end
			--   return { { "\\textbf{" }, { "}" } }
			-- end,
			find = "\\%a-bf%b{}",
			delete = "^(\\%a-bf{)().-(})()$",
		},
		["i"] = {
			add = { "\\textit{", "}" },
			-- add = function()
			--   if vim.fn["vimtex#syntax#in_mathzone"]() == 1 then
			--     return { { "\\mathit{" }, { "}" } }
			--   end
			--   return { { "\\textit{" }, { "}" } }
			-- end,
			find = "\\%a-it%b{}",
			delete = "^(\\%a-it{)().-(})()$",
		},
		["s"] = {
			add = { "\\textsc{", "}" },
			find = "\\textsc%b{}",
			delete = "^(\\textsc{)().-(})()$",
		},
		["t"] = {
			add = { "\\texttt{", "}" },
			-- add = function()
			--   if vim.fn["vimtex#syntax#in_mathzone"]() == 1 then
			--     return { { "\\mathtt{" }, { "}" } }
			--   end
			--   return { { "\\texttt{" }, { "}" } }
			-- end,
			find = "\\%a-tt%b{}",
			delete = "^(\\%a-tt{)().-(})()$",
		},
		["$"] = {
			add = { "$", "$" },
			-- find = "%b$.-$",
			-- delete = "^($)().-($)()$",
		},
	},
})

-- PdfAnnots
local function PdfAnnots()
	local ok, pdf = pcall(vim.api.nvim_eval,
		"vimtex#context#get().handler.get_actions().entry.file")
	if not ok then
		vim.notify "No file found"
		return
	end

	local cwd = vim.fn.getcwd()
	vim.fn.chdir(vim.b.vimtex.root)

	if vim.fn.isdirectory('Annotations') == 0 then
		vim.fn.mkdir('Annotations')
	end

	local md = vim.fn.printf("Annotations/%s.md", vim.fn.fnamemodify(pdf, ":t:r"))
	vim.fn.system(vim.fn.printf('pdfannots -o "%s" "%s"', md, pdf))
	vim.cmd.split(vim.fn.fnameescape(md))

	vim.fn.chdir(cwd)
end

vim.api.nvim_buf_create_user_command(0, "PdfAnnots", PdfAnnots, { bang = false })
