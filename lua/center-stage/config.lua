local M = {}

local defaults = {
	enabled = false,
	center_on = { "CursorMoved", "CursorMovedI" },
	offset = 0,
}

local config = vim.tbl_deep_extend("force", {}, defaults)

function M.setup(opts)
	config = vim.tbl_deep_extend("force", {}, defaults, opts or {})
	if type(config.center_on) == "string" then
		config.center_on = { config.center_on }
	end
	return config
end

function M.get()
	return config
end

return M
