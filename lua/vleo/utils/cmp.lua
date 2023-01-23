local M = {}

local cmp_active = true
local config

function M.toggle()
	if package.loaded["cmp"] == nil then
		return false
	end

	local cmp = require("cmp")

	if cmp_active then
		cmp_active = false
		config = cmp.get_config()
		cmp.setup({ enabled = false })
	else
		cmp_active = true
		cmp.setup(config)
	end
end

function M.enable()
	if package.loaded["cmp"] == nil then
		return false
	end
	if cmp_active then
		return
	end
	cmp_active = true
	require("cmp").setup(config)
end

function M.disable()
	if package.loaded["cmp"] == nil then
		return false
	end
	if not cmp_active then
		return
	end
	local cmp = require("cmp")
	cmp_active = false
	cmp.close()
	config = cmp.get_config()
	cmp.setup({ enabled = false })
end

function M.is_active()
	if package.loaded["cmp"] == nil then
		return "not_loaded"
	end
	return cmp_active
end

return M
