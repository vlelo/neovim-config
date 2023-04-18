return {
	{
		"alanfortlink/blackjack.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		cmd = { "BlackJackNewGame" },
	},

	{
		"jim-fx/sudoku.nvim",
		cmd = "Sudoku",
		config = function()
			require("sudoku").setup({})
		end,
	}
}
