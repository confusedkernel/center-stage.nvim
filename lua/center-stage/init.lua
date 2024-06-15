-- ~/.local/share/nvim/lazy/center-stage/lua/center-stage/init.lua

local M = {}
local api = vim.api

local center_stage = false

function M.center_cursor()
	local cursor = api.nvim_win_get_cursor(0)
	api.nvim_command("normal! zz")
	api.nvim_win_set_cursor(0, cursor)
end

function M.cc_enable()
	center_stage = true
	api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		pattern = "*",
		callback = M.center_cursor,
		group = api.nvim_create_augroup("CenterStage", { clear = true }),
	})
	print("Center stage enabled.")
end

function M.cc_disable()
	center_stage = false
	api.nvim_clear_autocmds({ group = "CenterStage" })
	print("Center stage disabled.")
end

function M.cc_toggle()
	if center_stage then
		M.cc_disable()
	else
		M.cc_enable()
	end
end

function M.setup()
	api.nvim_create_user_command("CCEnable", M.cc_enable, {})
	api.nvim_create_user_command("CCDisable", M.cc_disable, {})
	api.nvim_create_user_command("CCToggle", M.cc_toggle, {})
end

return M
