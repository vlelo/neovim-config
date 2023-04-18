local function read_dict()
	local dirname = vim.fn.stdpath("config") .. "/spell/"
	local dict = {}
	local file
	local lang

	local dir = vim.loop.fs_opendir(dirname)
	if not dir then
		vim.notify("Could not open directory `" .. dirname .. "`", vim.log.levels.ERROR)
		return
	end
	file = dir:readdir()
	while file do
		file = file[1]
		if file.type == "file" then
			lang = file.name:match("^(%l%l_%u%u)%.")
			lang = lang:gsub("_", "-")

			dict[lang] = {}
			for word in io.open(dirname .. file.name, "r"):lines() do
				table.insert(dict[lang], word)
			end
		end
		file = dir:readdir()
	end
	dir:closedir()
	return dict
end

return function(capabilities)
	local opts = {}
	opts.settings = {}
	opts.flags = {}

	opts.filetypes = {
		"bib",
		"gitcommit",
		"markdown",
		"org",
		"plaintex",
		"rst",
		"rnoweb",
		"tex",
		"pandoc",
		"norg",
	}

	opts.capabilities = capabilities

	opts.settings.ltex = {
		language = "en-US",
		dictionary = read_dict(),
	}

	require("lspconfig").ltex.setup(opts)
end
