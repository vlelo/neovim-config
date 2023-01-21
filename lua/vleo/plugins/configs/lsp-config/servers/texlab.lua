return function(capabilities)
	local opts = {}
	opts.settings = {}
	opts.flags = {}

	opts.filetypes = { "tex", }

	opts.capabilities = capabilities

	opts.settings.texlab = {}
	local texlab = opts.settings.texlab

	texlab.auxDirectory = "out"
	texlab.diagnostics = {
		ignoredPatterns = {
			"Overfull",
			"Underfull",
			"inputenc package ignored with utf8 based engines.",
		},
		allowedPatterns = {},
	}
	texlab.chktex = {
		onEdit =false,
		onOpenAndSave =false,
	}
	texlab.build = {
		executable = "latexmk",
		args = {
			"-outdir=out",
			-- "-verbose",
			"-shell-escape",
			"-halt-on-error",
			"-file-line-error",
			"-synctex=1",
			"-interaction=nonstopmode",
			"-recorder",
			-- "-view=none"
		},
		forwardSearchAfter = false,
		onSave = false,
	}
	local uname = vim.loop.os_uname().sysname
	if uname == "Darwin" then
		texlab.forwardSearch = {
			executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
			args = {
				"%l",
				"%p",
				"%f",
			},
		}
	elseif uname == "Linux" then
		texlab.forwardSearch = {
			executable = "okular",
			args = {
				"--unique",
				"file:%p#src:%l%f",
			},
		}
	end

	require("lspconfig").texlab.setup(opts)
end
