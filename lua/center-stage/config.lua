local M = {}

local defaults = {
	enabled = false,
	center_on = { "CursorMoved", "CursorMovedI" },
	offset = 0,
	pattern = "*",
	ignore_buftypes = { "nofile", "quickfix", "help", "terminal", "prompt" },
	ignore_filetypes = {},
}

local config = vim.tbl_deep_extend("force", {}, defaults)

local function normalize_list(value)
	if value == nil then
		return {}
	end
	if type(value) == "string" then
		return { value }
	end
	if type(value) == "table" then
		return value
	end
	return {}
end

local function filter_strings(list)
	return vim.tbl_filter(function(item)
		return type(item) == "string" and item ~= ""
	end, list)
end

function M.setup(opts)
	config = vim.tbl_deep_extend("force", {}, defaults, opts or {})
	config.center_on = filter_strings(normalize_list(config.center_on))
	config.ignore_buftypes = filter_strings(normalize_list(config.ignore_buftypes))
	config.ignore_filetypes = filter_strings(normalize_list(config.ignore_filetypes))
	if #config.center_on == 0 then
		config.center_on = defaults.center_on
		vim.notify("center-stage: center_on must be a string or list of event names; using defaults", vim.log.levels.WARN)
	end
	return config
end

function M.get()
	return config
end

return M
