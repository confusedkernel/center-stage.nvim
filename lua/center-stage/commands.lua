local M = {}
local api = vim.api

local config = require("center-stage.config")

local center_stage = false
local augroup_name = "CenterStage"
local augroup_id = api.nvim_create_augroup(augroup_name, { clear = false })

local function clear_augroup()
	local ok = pcall(api.nvim_clear_autocmds, { group = augroup_id })
	if not ok then
		augroup_id = api.nvim_create_augroup(augroup_name, { clear = true })
	end
end

local function is_enabled()
	local ok, autocmds = pcall(api.nvim_get_autocmds, { group = augroup_id })
	if not ok then
		return false
	end
	return #autocmds > 0
end

local function should_ignore(cfg)
	local buftype = vim.bo.buftype
	if buftype ~= "" and vim.tbl_contains(cfg.ignore_buftypes or {}, buftype) then
		return true
	end
	local filetype = vim.bo.filetype
	if filetype ~= "" and vim.tbl_contains(cfg.ignore_filetypes or {}, filetype) then
		return true
	end
	return false
end

function M.center_cursor()
	local cursor = api.nvim_win_get_cursor(0)
	local cfg = config.get()
	local view = vim.fn.winsaveview()
	local win_height = api.nvim_win_get_height(0)
	local target_topline = cursor[1] - math.floor(win_height / 2) + cfg.offset
	view.topline = math.max(1, target_topline)
	view.lnum = cursor[1]
	view.col = cursor[2]
	vim.fn.winrestview(view)
end

function M.enable(quiet)
	if is_enabled() then
		center_stage = true
		return
	end
	local cfg = config.get()
	clear_augroup()
	local ok, err = pcall(api.nvim_create_autocmd, cfg.center_on, {
		pattern = cfg.pattern or "*",
		callback = function()
			local callback_cfg = config.get()
			if should_ignore(callback_cfg) then
				return
			end
			M.center_cursor()
		end,
		group = augroup_id,
	})
	if not ok then
		center_stage = false
		vim.notify("center-stage: failed to create autocmds: " .. tostring(err), vim.log.levels.ERROR)
		return
	end
	center_stage = true
	if not quiet then
		print("Center stage enabled.")
	end
end

function M.disable()
	center_stage = false
	clear_augroup()
	print("Center stage disabled.")
end

function M.toggle()
	if center_stage or is_enabled() then
		M.disable()
	else
		M.enable()
	end
end

return M
