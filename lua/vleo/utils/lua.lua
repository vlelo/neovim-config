local M = {}

--- Split string at delimiter and return table
---@param s string String input
---@param delimiter string Delimiting charater
---@return table Table containing split string
function M.ssplit(s, delimiter)
	local result = {}
	for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
		table.insert(result, match)
	end
	return result
end

--- Check if table `tab` has value `val`
---@param tab table Table to check
---@param val any Value to check existence
---@return boolean
function M.has_value(tab, val)
	for _, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

--- Recursively print table
---@param o table
function M.dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. vleo.dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function M.os_capture(cmd, raw)
	local f = assert(io.popen(cmd, 'r'))
	local s = assert(f:read('*a'))
	f:close()
	if raw then return s end
	s = string.gsub(s, '^%s+', '')
	s = string.gsub(s, '%s+$', '')
	s = string.gsub(s, '[\n\r]+', '')
	return s
end

return M
