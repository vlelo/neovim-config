local H = require("hydra")

-- local hint = [[
--   ^ ^                  Options
--   ^
--   _n_ %{relativenumber}^^^^^^^ Relative numbers      _h_ %{hlsearch}^^^ Search highlight
--   _v_ %{virtualedit}^^^^^^^^ Virtual edit          _r_ %{colorizer}^^ Colorizer
--   _e_ %{list}^^^^^^ Invisible characters  _k_ %{cmp}^^^^^^^^ CMP
-- 	_c_ %{comments}^^ Auto comment          _l_ %{indent_bl}^^ Indent blankline
--   _s_ %{spell}^^^^^ Spell check           _t_ %{cursorline}^^^^^^^^ Cursor line
--   _w_ %{wrap}^^^^^^ Wrap                 	_g_ %{illuminate}^ Illuminate
--   ^
--   _q_    ^^^^^^^^^^                              ^^^^^^^^^          _<Esc>_
-- ]]

local hint = [[
  ^ ^                     Options
  ^
  _n_ %{relativenumber}^^^^ Relative numbers        _h_ %{hlsearch}^^^^^^^^^^ Search highlight
  _v_ %{virtualedit}^^^^^^^ Virtual edit            _g_ %{illuminate}^^^^^^^^ Illuminate
  _e_ %{list}^^^^^^^^^^^^^^ Invisible characters    _w_ %{wrap}^^^^^^^^^^^^^^ Wrap
	_l_ %{indent_blankline}^^ Indent blankline        _t_ %{cursorline}^^^^^^^^ Cursor line
  _s_ %{spell}^^^^^^^^^^^^^ Spell check
  ^ ^   ^^^^^^^^^^^^^^^^^^^                         ^ ^   ^^^^^^^^^^^^^^^^^^^                   
  _q_   ^^^^^^^^^^^^^^^^^^^                         ^ ^   ^^^^^^^^^^^^^^^^^^^          _<Esc>_
]]


local function vim_option(option)
	return function()
		local flag = vim.o[option]
		if flag then
			return " "
		else
			return " "
		end
	end
end

local function ve()
	if vim.o.virtualedit == "all" then
		return " "
	else
		return " "
	end
end

H({
	name = "Options",
	mode = { "n" },
	body = "<leader>m",
	hint = hint,
	config = {
		exit = false,
		color = "amaranth",
		invoke_on_body = true,
		desc = "Toggle options",
		timeout = false,
		hint = {
			type = "window",
			position = "middle",
			border = "rounded",
			funcs = {
				relativenumber = vim_option("relativenumber"),
				virtualedit = ve,
				list = vim_option("list"),
				spell = vim_option("spell"),
				wrap = vim_option("wrap"),
				cursorline = vim_option("cursorline"),
				hlsearch = vim_option("hlsearch"),
				illuminate = function()
					return " "
				end,
				indent_blankline = function()
					local flag = vim.g["indent_blankline_enabled"]
					if flag then
						return " "
					else
						return " "
					end
				end,
			},
		},
	},
	heads = {
		{ "n", function()
			if vim.o.relativenumber == true then
				vim.o.relativenumber = false
			else
				vim.o.number = true
				vim.o.relativenumber = true
			end
		end
		},
		{ "v", function()
			if vim.o.virtualedit == "all" then
				vim.o.virtualedit = "block"
			else
				vim.o.virtualedit = "all"
			end
		end,
		},
		{
			"e",
			function()
				if vim.o.list == true then
					vim.o.list = false
				else
					vim.o.list = true
				end
			end,
		},
		{
			"s",
			function()
				if vim.o.spell == true then
					vim.o.spell = false
				else
					vim.o.spell = true
				end
			end,
		},
		{
			"w",
			function()
				if vim.o.wrap ~= true then
					vim.o.wrap = true
				else
					vim.o.wrap = false
				end
			end,
		},
		{
			"t",
			function()
				if vim.o.cursorline == true then
					vim.o.cursorline = false
				else
					vim.o.cursorline = true
				end
			end,
		},
		{
			"h",
			function()
				if vim.o.hlsearch == true then
					vim.o.hlsearch = false
				else
					vim.o.hlsearch = true
				end
			end,
		},
		{
			"g",
			require("illuminate").toggle,
		},
		{
			"l",
			function() return require("indent_blankline.commands").toggle(true) end,
		},
		{ "q", nil, { exit = true } },
		{ "<Esc>", nil, { exit = true } },
	},
})
