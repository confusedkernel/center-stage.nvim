local M = {}
local api = vim.api

local config = require("center-stage.config")

local center_stage = false
local augroup = "CenterStage"

function M.center_cursor()
	local cursor = api.nvim_win_get_cursor(0)
	api.nvim_command("normal! zz")
	local cfg = config.get()
	if cfg.offset ~= 0 then
		local view = vim.fn.winsaveview()
		view.topline = math.max(1, view.topline + cfg.offset)
		view.cursor = cursor
		vim.fn.winrestview(view)
	else
		api.nvim_win_set_cursor(0, cursor)
	end
end

function M.enable()
	center_stage = true
	local cfg = config.get()
	api.nvim_create_autocmd(cfg.center_on, {
		pattern = "*",
		callback = M.center_cursor,
		group = api.nvim_create_augroup(augroup, { clear = true }),
	})
	print("Center stage enabled.")
end

function M.disable()
	center_stage = false
	api.nvim_clear_autocmds({ group = augroup })
	print("Center stage disabled.")
end

function M.toggle()
	if center_stage then
		M.disable()
	else
		M.enable()
	end
end

return M
