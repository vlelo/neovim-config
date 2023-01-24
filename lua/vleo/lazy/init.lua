local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
	Vconf .. "." .. "plugins",
	{
		root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
		defaults = {
			-- NOTE false
			lazy = true, -- should plugins be lazy-loaded?
			version = nil,
			-- version = "*", -- enable this to try installing the latest stable versions of plugins
		},

		---@type LazySpec leave nil when passing the spec as the first argument to setup()
		spec = nil,

		-- lockfile generated after running update.
		-- NOTE vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
		lockfile = vim.fn.stdpath("config") .. "/lua/" .. Vconf .. "/lazy/lazy-lock.json",

		---@type number limit the maximum amount of concurrent tasks
		concurrency = nil,

		git = {
			-- defaults for the `Lazy log` command
			-- log = { "-10" }, -- show the last 10 commits
			log = { "--since=3 days ago" }, -- show commits from the last 3 days
			timeout = 120, -- kill processes that take more than 2 minutes
			url_format = "https://github.com/%s.git",
		},

		install = {
			-- install missing plugins on startup. This doesn't increase startup time.
			missing = true,
			-- try to load one of these colorschemes when starting an installation during startup
			colorscheme = { "gruvbox", "habamax" },
		},

		ui = {
			-- a number <1 is a percentage., >1 is a fixed size
			size = { width = 0.7, height = 0.7 },
			-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
			border = "rounded",
			icons = {
				cmd = " ",
				config = "",
				event = "",
				ft = " ",
				init = " ",
				import = " ",
				keys = " ",
				lazy = "鈴 ",
				loaded = "●",
				not_loaded = "○",
				plugin = " ",
				runtime = " ",
				source = " ",
				start = "",
				task = "✔ ",
				list = {
					"●",
					"➜",
					"★",
					"‒",
				},
			},

			-- leave nil, to automatically select a browser depending on your OS.
			-- If you want to use a specific browser, you can define it here
			browser = nil, ---@type string?
			throttle = 20, -- how frequently should the ui process render events
			custom_keys = {
				-- you can define custom key maps here.
				-- To disable one of the defaults, set it to false

				-- open lazygit log
				["<localleader>l"] = function(plugin)
					require("lazy.util").float_term({ "lazygit", "log" }, {
						cwd = plugin.dir,
					})
				end,

				-- open a terminal for the plugin dir
				["<localleader>t"] = function(plugin)
					require("lazy.util").float_term(nil, {
						cwd = plugin.dir,
					})
				end,
			},
		},

		diff = {
			-- diff command <d> can be one of:
			-- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
			--   so you can have a different command for diff <d>
			-- * git: will run git diff and open a buffer with filetype git
			-- * terminal_git: will open a pseudo terminal with git diff
			-- * diffview.nvim: will open Diffview to show the diff
			cmd = "diffview.nvim",
		},

		checker = {
			-- automatically check for plugin updates
			-- NOTE false
			enabled = false,
			concurrency = nil, ---@type number? set to 1 to check for updates very slowly
			notify = true, -- get a notification when new updates are found
			frequency = 3600, -- check for updates every hour
		},

		change_detection = {
			-- automatically check for config file changes and reload the ui
			enabled = true,
			notify = true, -- get a notification when changes are found
		},

		performance = {
			cache = {
				enabled = true,
				path = vim.fn.stdpath("cache") .. "/lazy/cache",
				-- Once one of the following events triggers, caching will be disabled.
				-- To cache all modules, set this to `{}`, but that is not recommended.
				-- The default is to disable on:
				--  * VimEnter: not useful to cache anything else beyond startup
				--  * BufReadPre: this will be triggered early when opening a file from the command line directly
				disable_events = { "UIEnter", "BufReadPre" },
				ttl = 3600 * 24 * 5, -- keep unused modules for up to 5 days
			},
			reset_packpath = true, -- reset the package path to improve startup time
			rtp = {
				reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
				---@type string[]
				paths = {}, -- add any custom paths here that you want to indluce in the rtp
				---@type string[] list any plugins you want to disable here
				disabled_plugins = {
					"gzip",
					"matchit",
					"matchparen",
					"netrwPlugin",
					"tarPlugin",
					"tohtml",
					"tutor",
					"zipPlugin",
				},
			},
		},

		-- lazy can generate helptags from the headings in markdown readme files,
		-- so :help works even for plugins that don't have vim docs.
		-- when the readme opens with :help it will be correctly displayed as markdown
		readme = {
			root = vim.fn.stdpath("state") .. "/lazy/readme",
			files = { "README.md", "lua/**/README.md" },
			-- only generate markdown helptags for plugins that dont have docs
			skip_if_doc_exists = true,
		},
	})
