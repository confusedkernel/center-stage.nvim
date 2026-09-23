local M = {}
local api = vim.api

local config = require("center-stage.config")

local augroup_name = "CenterStage"
local augroup_id = api.nvim_create_augroup(augroup_name, { clear = false })

local function clear_augroup()
	local ok = pcall(api.nvim_clear_autocmds, { group = augroup_id })
	if not ok then
		augroup_id = api.nvim_create_augroup(augroup_name, { clear = true })
	end
end

local function notify(msg, quiet)
	if not quiet then
		vim.notify(msg, vim.log.levels.INFO)
	end
end

function M.is_enabled()
	local ok, autocmds = pcall(api.nvim_get_autocmds, { group = augroup_id })
	if not ok then
		return false
	end
	return #autocmds > 0
end

local function should_ignore(cfg)
	if api.nvim_win_get_config(0).relative ~= "" then
		return true
	end
	if vim.b.center_stage_disable or vim.w.center_stage_disable then
		return true
	end
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
	local cfg = config.get()
	-- `zz` counts screen rows, so wrapped lines and folds are handled
	vim.cmd("normal! zz")
	if cfg.offset == 0 then
		return
	end
	local view = vim.fn.winsaveview()
	-- Keep the cursor line in view: topline can't pass it or go above line 1
	view.topline = math.min(math.max(1, view.topline + cfg.offset), view.lnum)
	view.topfill = 0
	vim.fn.winrestview(view)
end

-- Last centered state per window, used to skip moves that stay on the same line
local function state_key()
	return {
		buf = api.nvim_get_current_buf(),
		line = api.nvim_win_get_cursor(0)[1],
		height = api.nvim_win_get_height(0),
		row = vim.fn.winline(),
	}
end

local function unchanged(last, now)
	return last ~= nil
		and last.buf == now.buf
		and last.line == now.line
		and last.height == now.height
		and last.row == now.row
end

local function on_move()
	if should_ignore(config.get()) then
		return
	end
	if unchanged(vim.w.center_stage_last, state_key()) then
		return
	end
	M.center_cursor()
	vim.w.center_stage_last = state_key()
end

function M.enable(quiet)
	if M.is_enabled() then
		return
	end
	local cfg = config.get()
	clear_augroup()
	local ok, err = pcall(api.nvim_create_autocmd, cfg.center_on, {
		pattern = cfg.pattern or "*",
		callback = on_move,
		group = augroup_id,
	})
	if not ok then
		vim.notify("center-stage: failed to create autocmds: " .. tostring(err), vim.log.levels.ERROR)
		return
	end
	notify("Center stage enabled.", quiet)
end

function M.disable(quiet)
	clear_augroup()
	notify("Center stage disabled.", quiet)
end

function M.toggle(quiet)
	if M.is_enabled() then
		M.disable(quiet)
	else
		M.enable(quiet)
	end
end

return M
