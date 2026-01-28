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


function M.setup(opts)
	config.setup(opts)
	api.nvim_create_user_command("CSEnable", M.cc_enable, {})
	api.nvim_create_user_command("CSDisable", M.cc_disable, {})
	api.nvim_create_user_command("CSToggle", M.cc_toggle, {})
	if config.get().enabled then
		M.cc_enable(true)
	end
end

return M
