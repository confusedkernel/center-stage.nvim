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

local subcommands = {
	enable = function()
		M.enable()
	end,
	disable = function()
		M.disable()
	end,
	toggle = function()
		M.toggle()
	end,
	status = function()
		vim.notify("Center stage is " .. (M.is_enabled() and "enabled." or "disabled."), vim.log.levels.INFO)
	end,
}

function M.create_commands()
	api.nvim_create_user_command("CenterStage", function(cmd)
		local name = cmd.fargs[1] or "toggle"
		local sub = subcommands[name]
		if not sub then
			vim.notify("center-stage: unknown subcommand '" .. name .. "'", vim.log.levels.ERROR)
			return
		end
		sub()
	end, {
		nargs = "?",
		desc = "Center stage: enable, disable, toggle or status",
		complete = function(arg_lead)
			local names = vim.tbl_keys(subcommands)
			table.sort(names)
			return vim.tbl_filter(function(name)
				return vim.startswith(name, arg_lead)
			end, names)
		end,
	})
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
