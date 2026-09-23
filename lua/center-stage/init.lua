-- ~/.local/share/nvim/lazy/center-stage/lua/center-stage/init.lua

local M = {}
local api = vim.api

local config = require("center-stage.config")
local commands = require("center-stage.commands")

M.center_cursor = commands.center_cursor
M.cs_enable = commands.enable
M.cs_disable = commands.disable
M.cs_toggle = commands.toggle
M.cc_enable = commands.enable
M.cc_disable = commands.disable
M.cc_toggle = commands.toggle


function M.create_commands()
	-- Wrap callbacks so the command's opts table isn't passed as `quiet`
	api.nvim_create_user_command("CSEnable", function()
		M.cs_enable()
	end, {})
	api.nvim_create_user_command("CSDisable", function()
		M.cs_disable()
	end, {})
	api.nvim_create_user_command("CSToggle", function()
		M.cs_toggle()
	end, {})
end

function M.setup(opts)
	config.setup(opts)
	M.create_commands()
	if config.get().enabled then
		M.cc_enable(true)
	end
end

return M
