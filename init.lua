_G.Vconf = "vleo"
_G.Vreq = require(Vconf .. "." .. "utils").vreq

Vreq("utils").load_mod(nil, {
	"settings",
	"lazy",
})

local colorscheme = "gruvbox"

---@diagnostic disable-next-line: param-type-mismatch
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!", vim.log.levels.WARN, { title = "Colorscheme" })
	return
end
