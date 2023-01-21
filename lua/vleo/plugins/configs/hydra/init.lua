return {
	"anuvyklack/hydra.nvim",
	event = "VeryLazy",
	config = function(_, _)
		Vreq("utils").load_mod("plugins.configs.hydra", {
			"window",
			"options",
			"dap",
		})
	end,
}
