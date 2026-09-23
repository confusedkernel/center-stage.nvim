local M = {}
local api = vim.api

local config = require("center-stage.config")
local commands = require("center-stage.commands")

M.enable = commands.enable
M.disable = commands.disable
M.toggle = commands.toggle
M.is_enabled = commands.is_enabled
M.center = commands.center_cursor

-- Aliases kept for existing configs
M.center_cursor = commands.center_cursor
M.cs_enable = commands.enable
M.cs_disable = commands.disable
M.cs_toggle = commands.toggle

function M.create_commands()
	-- Wrap callbacks so the command's opts table isn't passed as `quiet`
	api.nvim_create_user_command("CSEnable", function()
		M.enable()
	end, {})
	api.nvim_create_user_command("CSDisable", function()
		M.disable()
	end, {})
	api.nvim_create_user_command("CSToggle", function()
		M.toggle()
	end, {})
end

function M.setup(opts)
	config.setup(opts)
	M.create_commands()
	if config.get().enabled then
		M.enable(true)
	end
end

return M
