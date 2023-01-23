local H = require("hydra")

H({
	name = "Change / Resize windows",
	mode = { "n" },
	body = "<C-w>",
	hint = [[
  ^ ^  Move
  _h_  Left
  _j_  Down
  _k_  Up
  _l_  Right
  
  ^ ^  Resize
  _H_  Horiz -
  _J_  Vert  -
  _K_  Vert  +
  _L_  Horiz +
  _e_  Equalize  
  
  _Q_  Close
  ^
  ^ ^  Exit
  _q_, _<ESC>_, _;_
  ]],
	config = {
		-- invoke_on_body = true,
		timeout = false,
		hint = {
			type = "window",
			position = "middle-right",
			border = "rounded",
		},
	},
	heads = {
		-- move between windows
		{ "h", "<C-w>h" },
		{ "j", "<C-w>j" },
		{ "k", "<C-w>k" },
		{ "l", "<C-w>l" },

		-- resize windows
		{ "H", "<C-w>3<" },
		{ "J", "<C-w>2-" },
		{ "K", "<C-w>2+" },
		{ "L", "<C-w>3>" },

		-- equalize window sizes
		{ "e", "<C-w>=" },

		-- close active window
		{ "Q", ":q<CR>" },
		-- { "<C-q>", ":q<CR>" },

		-- exit this hydra
		{ "q", nil, { exit = true, nowait = true } },
		{ ";", nil, { exit = true, nowait = true } },
		{ "<ESC>", nil, { exit = true, nowait = true } },
	},
})
