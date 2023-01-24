vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.autowrite = true -- enable auto write
--[[ opt.clipboard = "unnamedplus" -- sync with system clipboard ]]
opt.cmdheight = 0
opt.completeopt = {
	"menu",
	"menuone",
	"noselect",
}
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.confirm = true -- confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = false -- Use spaces instead of tabs
opt.formatoptions = "jcrqlnt1"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.guifont = "JetBrainsMono Nerd Font:h14"
opt.hidden = true -- Enable modified buffers in background
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.joinspaces = false -- No double spaces with join after a dot
opt.laststatus = 3
opt.list = false -- Show some invisible characters (tabs...
opt.mouse = "a" -- enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.showmode = false -- dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
-- opt.spelllang = { "en", "it", "de" }
opt.spelllang = "en_us"
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- minimum window width
opt.wrap = false -- Disable line wrap
opt.breakindent = true
---@diagnostic disable-next-line: assign-type-mismatch
opt.showbreak = string.rep("+", 3)
opt.linebreak = true


if vim.fn.has("nvim-0.9.0") == 1 then
	opt.splitkeep = "screen"
	opt.shortmess = "filnxtToOFWIcC"
end

-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0

--[[ vim.o.syntax = "on" ]]
opt.title = true
-- opt.titlestring = "nvim: %-25.55F %a%r%m"
opt.titlestring = "nvim"
opt.titlelen = 70
opt.backup = false -- creates a backup file
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.hlsearch = true
opt.incsearch = true
opt.softtabstop = 2
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldcolumn = "0"
--[[ opt.wildoptions = "pum" ]]
opt.showcmd = true
opt.showmatch = true -- Show matching brackets when text indicator is over them
opt.autoindent = true
opt.cindent = true
opt.nrformats = "bin"
opt.history = 200
opt.path:append("app/**")
opt.shortmess:append("c")
opt.listchars:append("tab:> ")
opt.listchars:append("trail:+")
opt.listchars:append("eol:↲")
opt.virtualedit = "block"
opt.iskeyword:append("-")
opt.numberwidth = 2
opt.cursorline = true
opt.equalalways = false
opt.background = "dark"
opt.exrc = true
opt.fillchars:append("foldopen:")
opt.fillchars:append("foldclose:")
opt.fillchars:append("fold:─")

-- vim.o.foldmethod = "syntax"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
