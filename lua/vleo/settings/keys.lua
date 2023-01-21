-- Insert mode correction
vim.keymap.set("i", "<c-f>", "<Del>", { desc = "Del" })

-- better up/down
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
vim.keymap.set("n", "<C-q>", "<C-w>q", { desc = "Close window" })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
vim.keymap.set("n", "<A-j>", ":m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", ":m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<cr>==gi", { desc = "Move up" })

-- buffers
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search and redraw
vim.keymap.set("n", "<leader>r", "<cmd>noh<cr><cmd>redraw<cr><c-l>", { desc = "Redraw and clear hlsearch" })

vim.keymap.set("n", "gw", "*N")
vim.keymap.set("x", "gw", "*N")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- save file
--[[ vim.keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" }) ]]
require("vleo.utils").allmap("<M-w>", "<cmd>write<CR>", { desc = "Save file" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- new file
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

vim.keymap.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Open Location List" })
vim.keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Open Quickfix List" })

-- windows
vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "other-window" })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "delete-window" })
vim.keymap.set("n", "<leader>w-", "<C-W>s", { desc = "split-window-below" })
vim.keymap.set("n", "<leader>w|", "<C-W>v", { desc = "split-window-right" })

-- tabs
vim.keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last" })
vim.keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First" })
vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next" })
vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close" })
vim.keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous" })

--[[ -- toggle options ]]
--[[ vim.keymap.set("n", "<leader>tf", require("lazyvim.plugins.lsp.format").toggle, { desc = "Toggle format on Save" }) ]]
--[[ vim.keymap.set("n", "<leader>ts", function() Util.toggle("spell") end, { desc = "Toggle Spelling" }) ]]
--[[ vim.keymap.set("n", "<leader>tw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" }) ]]
--[[ vim.keymap.set("n", "<leader>tn", function() Util.toggle("relativenumber", true) Util.toggle("number") end, { desc = "Toggle Line Numbers" }) ]]
--[[ vim.keymap.set("n", "<leader>td", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" }) ]]
--[[ local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3 ]]
--[[ vim.keymap.set("n", "<leader>tc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" }) ]]

--[[ require("vleo.utils").allmap("<M-h>", "<cmd>lua vim.o.hlsearch = not vim.o.hlsearch<CR>") ]]
--[[ require("vleo.utils").allmap("<M-n>", "<cmd>lua vim.o.relativenumber = not vim.o.relativenumber<CR>") ]]
--[[ require("vleo.utils").allmap("<M-e>", "<cmd>set list!<CR>") ]]

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
--[[ vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()') ]]

local cmd = function(name, fun) vim.api.nvim_create_user_command(name, fun, {}) end
cmd("W", "w")
cmd("Q", "q")
cmd("Qa", "qa")
cmd("Wa", "wa")
cmd("Wq", "wq")
cmd("Wqa", "wqa")

vim.keymap.set('t', '<C-[>', [[<C-\><C-n>]], { desc = "Normal mode" })
vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], { desc = "Window left" })
vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], { desc = "Window down" })
vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], { desc = "Window up" })
vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], { desc = "Window right" })
