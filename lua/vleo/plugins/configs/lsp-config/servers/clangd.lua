local icons = Vreq("utils.config.icons").kind
local extensions = {
	-- defaults:
	-- Automatically set inlay hints (type hints)
	autoSetHints = true,
	-- Whether to show hover actions inside the hover window
	-- This overrides the default hover handler
	hover_with_actions = true,
	-- These apply to the default ClangdSetInlayHints command
	inlay_hints = {
		-- Only show inlay hints for the current line
		only_current_line = false,
		-- Event which triggers a refersh of the inlay hints.
		-- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
		-- not that this may cause  higher CPU usage.
		-- This option is only respected when only_current_line and
		-- autoSetHints both are true.
		only_current_line_autocmd = "CursorHold",
		-- whether to show parameter hints with the inlay hints or not
		show_parameter_hints = true,
		-- prefix for parameter hints
		parameter_hints_prefix = "<- ",
		-- prefix for all the other hints (type, chaining)
		other_hints_prefix = "=> ",
		-- whether to align to the length of the longest line in the file
		max_len_align = false,
		-- padding from the left if max_len_align is true
		max_len_align_padding = 1,
		-- whether to align to the extreme right or not
		right_align = false,
		-- padding from the right if right_align is true
		right_align_padding = 7,
		-- The color of the hints
		highlight = "Comment",
		-- The highlight group priority for extmark
		priority = 100,
	},
	ast = {
		role_icons = {
			type = icons.TypeParameter,
			declaration = icons.Package,
			expression = " ",
			specifier = icons.Value,
			statement = " ",
			["template argument"] = " ",
		},
		kind_icons = {
			Compound = icons.Struct,
			Recovery = " ",
			TranslationUnit = " ",
			PackExpansion = " ",
			TemplateTypeParm = " ",
			TemplateTemplateParm = icons.Unit,
			TemplateParamObject = icons.Object,
		},
		highlights = {
			detail = "Comment",
		},
	},
	memory_usage = {
		border = "rounded",
	},
	symbol_info = {
		border = "rounded",
	},
}

return function(capabilities)
	local opts = {}
	opts.capabilities = capabilities
	opts.capabilities.offsetEncoding = "utf-8"
	opts.cmd = {
		"clangd",
		"-Wno-unknown-warning-option",
		"--enable-config",
		-- NOTE only for sage
		"-header-insertion=never",
	}

	-- Have to call special function to run clangd
	require("clangd_extensions").setup({
		server = opts,
		extensions = extensions,
	})
end
