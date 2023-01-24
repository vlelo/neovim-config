local map = vim.keymap.set

map({ "n", "i", "c", "o" }, "<D-n>", "<cmd>confirm enew<cr>", { desc = "New file" })
map("v", "<D-n>", "<Esc><D-n>gv", { desc = "New file", remap = true })

map({ "n", "i", "c", "o" }, "<D-o>", "<cmd>browse confirm e<cr>", { desc = "Open file" })
map("v", "<D-o>", "<Esc><D-o>gv", { desc = "New file", remap = true })

map({ "n", "i", "c", "o" }, "<D-w>",
	"<cmd>if winheight(2) < 0 <Bar> confirm enew <Bar> else <Bar> confirm close <Bar> endif<cr>", { desc = "Close file" })
map("v", "<D-w>", "<Esc><D-w>gv", { desc = "Close file", remap = true })

map({ "n", "i", "c", "o" }, "<D-s>",
	"<cmd>if expand(\"%\") == \"\"<Bar>browse confirm w<Bar> else<Bar>confirm w<Bar>endif<cr>", { desc = "Save file" })
map("v", "<D-s>", "<Esc><D-s>gv", { desc = "Save file", remap = true })

map({ "n", "i", "c", "o" }, "<D-S-s>", "<cmd>browse confirm saveas<cr>", { desc = "Save as" })
map("v", "<D-S-s>", "<Esc><D-S-s>gv", { desc = "Save as", remap = true })

map({ "n", "i", "c", "o" }, "<D-z>", "u", { desc = "Save as" })
map("v", "<D-z>", "<Esc><D-z>gv", { desc = "Save as", remap = true })

map("v", "<D-x>", '"+x', { desc = "Cut" })
map("v", "<D-c>", '"+y', { desc = "Copy" })
map("c", "<D-c>", "<C-Y>", { desc = "Cut" })

map({ "n", "i", "c", "o", "v" }, "<D-v>", function()
	vim.api.nvim_paste(vim.fn.getreg "+", false, -1)
end, { desc = false })

map({ "n", "i", "v", "o", "c" }, "<D-a>",
	'<cmd>if &slm != ""<Bar>exe ":norm gggH<C-O>G"<Bar> else<Bar>exe ":norm ggVG"<Bar>endif<CR>', { desc = "Select all" })

map("n", "<D-f>", "/", { desc = "Search" })
map({ "i", "v", "o" }, "<D-f>", "<Esc><D-f>", { desc = "Search", remap = true })
map("c", "<D-f>", "<C-C><D-f>", { desc = "Search", remap = true })

map("n", "<D-g>", "n", { desc = "Next result" })
map({ "i", "v", "o" }, "<D-g>", "<Esc><D-g>", { desc = "Next result", remap = true })
map("c", "<D-g>", "<C-C><D-g>", { desc = "Next result", remap = true })

vim.keymap.set("n", "<D-+>", function() Vreq("utils.gui").fontscale(1) end, { noremap = true })
vim.keymap.set("n", "<D-->", function() Vreq("utils.gui").fontscale(-1) end, { noremap = true })
