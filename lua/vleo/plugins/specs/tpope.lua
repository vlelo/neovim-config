local wk = Vreq("utils.keys").wk_defer

return {
	{ "tpope/vim-repeat", event = "VeryLazy" },
	{ "tpope/vim-fugitive", cmd = { "G", "Git" } },
	{
		"tpope/vim-capslock",
		event = "VeryLazy",
		config = function(_, _)
			wk({
				gC = "Toggle Capslock",
			})
		end,
	},

	{
		"tpope/vim-unimpaired",
		event = "VeryLazy",
		config = function(_, _)
			wk({
				["[a"] = ":previous",
				["]a"] = ":next",
				["[A"] = ":first",
				["]A"] = ":last",
				-- ["[b"] = ":bprevious",
				-- ["]b"] = ":bnext",
				["[B"] = ":bfirst",
				["]B"] = ":blast",
				["[l"] = ":lprevious",
				["]l"] = ":lnext",
				["[L"] = ":lfirst",
				["]L"] = ":llast",
				["[<C-L>"] = ":lpfile",
				["]<C-L>"] = ":lnfile",
				["[q"] = ":cprevious",
				["]q"] = ":cnext",
				["[Q"] = ":cfirst",
				["]Q"] = ":clast",
				["[<C-Q>"] = ":cpfile",
				["]<C-Q>"] = ":cnfile",
				["[t"] = ":tprevious",
				["]t"] = ":tnext",
				["[T"] = ":tfirst",
				["]T"] = ":tlast",
				["[<C-T>"] = ":ptprevious",
				["]<C-T>"] = ":ptnext",
				--
				["[f"] = "Next file in directory",
				["]f"] = "Prev file in directory",
				["[n"] = "Next conflict",
				["]n"] = "Prev conflict",
				--
				["[<Space>"] = "Add line above",
				["]<Space>"] = "Add line below",
				["[e"] = "Swap line above",
				["]e"] = "Swap line below",
				--
				["[o"] = {
					name = "Turn Option On",
					b = "background",
					c = "cursorline",
					d = "diff",
					e = "spell",
					h = "hlsearch",
					i = "ignorecase",
					l = "list",
					n = "number",
					r = "relativenumber",
					u = "cursorcolumn",
					v = "virtualedit",
					w = "wrap",
					x = "cursorline and cursorcolumn",
				},
				["]o"] = {
					name = "Turn Option Off",
					b = "background",
					c = "cursorline",
					d = "diff",
					e = "spell",
					h = "hlsearch",
					i = "ignorecase",
					l = "list",
					n = "number",
					r = "relativenumber",
					u = "cursorcolumn",
					v = "virtualedit",
					w = "wrap",
					x = "cursorline and cursorcolumn",
				},
				--
				["[x"] = "XML encode",
				["[xx"] = "XML encode line",
				["]x"] = "XML decode",
				["]xx"] = "XML decode line",
				--
				["[u"] = "URL encode",
				["[uu"] = "URL encode line",
				["]u"] = "URL decode",
				["]uu"] = "URL decode line",
				--
				["[C"] = "C String encode",
				["[CC"] = "C String encode line",
				["]C"] = "C String decode",
				["]CC"] = "C String decode line",
				--
				["[y"] = "which_key_ignore",
				["[yy"] = "which_key_ignore",
				["]y"] = "which_key_ignore",
				["]yy"] = "which_key_ignore",
				--
				["<s"] = "which_key_ignore",
				[">s"] = "which_key_ignore",
				["=s"] = "which_key_ignore",
				--
				["<p"] = "Paste after indenting",
				[">p"] = "Paste after deintenting",
				["=p"] = "Paste after reindenting",
				--
				["<P"] = "Paste before indenting",
				[">P"] = "Paste before deintenting",
				["=P"] = "Paste before reindenting",
				--
				["]p"] = "Paste after linewise",
				["[p"] = "Paste before linewise",
				["]P"] = "Paste before linewise",
				["[P"] = "Paste before linewise",
			})
			wk({
				["[x"] = "XML encode",
				["]x"] = "XML decode",
				--
				["[u"] = "URL encode",
				["]u"] = "URL decode",
				--
				["[C"] = "C String encode",
				["]C"] = "C String decode",
				--
				["[y"] = "which_key_ignore",
				["]y"] = "which_key_ignore",
			},
				{
					mode = "v"
				})
			vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Buffer" })
			vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Buffer" })
		end,
	},
}
