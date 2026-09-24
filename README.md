# center-stage.nvim

A Neovim plugin that keeps your cursor at the center stage 24/7 (if you enable it, of course.)

## Installation

Using Lazy:
```Lua
{
    "confusedkernel/center-stage.nvim",
    branch = "master",
    opts = {
        enabled = true,
    },
}
```

Using Packer:
```Lua
use "confusedkernel/center-stage.nvim"
```

## Options

### Setup

```Lua
require("center-stage").setup({
    enabled = false,
    center_on = { "CursorMoved", "CursorMovedI" },
    offset = 0,
    pattern = "*",
    ignore_buftypes = { "nofile", "quickfix", "help", "terminal", "prompt" },
    ignore_filetypes = {},
})
```

```Lua
{
    "confusedkernel/center-stage.nvim",
    branch = "master",
    opts = {
        enabled = false,
        center_on = { "CursorMoved", "CursorMovedI" },
        offset = 0,
        pattern = "*",
        ignore_buftypes = { "nofile", "quickfix", "help", "terminal", "prompt" },
        ignore_filetypes = {},
    },
}
```

### Config Reference

- `enabled` (boolean): Enable center stage on startup.
- `center_on` (string|table): Autocommands that trigger centering.
- `offset` (number): Moves the cursor away from the center (positive moves it up). Whole numbers are rows; values between -1 and 1 are a fraction of the window height (e.g. `0.25` puts the cursor a quarter of the window above center).
- `pattern` (string|table): Autocmd pattern(s) to match buffers.
- `ignore_buftypes` (table): Buffer types to skip (e.g. `help`, `terminal`).
- `ignore_filetypes` (table): Filetypes to skip.

To turn centering off for a single buffer or window, set `vim.b.center_stage_disable = true` or `vim.w.center_stage_disable = true`. Floating windows are always skipped.

## Commands and Keymaps

- `:CenterStage [enable|disable|toggle|status]`: Control center-stage.nvim (no argument toggles)
- `:CSEnable`, `:CSDisable`, `:CSToggle`: Shorthands for the above

You can add a keymap to toggle the plugin more easily, example:
```Lua
vim.keymap.set({ "n", "v" }, "<leader>cs", require("center-stage").toggle, { desc = "Toggle center stage" })
```

## Lua API

```Lua
local cs = require("center-stage")
cs.enable(quiet)  -- `quiet` suppresses the message
cs.disable(quiet)
cs.toggle(quiet)
cs.is_enabled()   -- boolean
cs.center()       -- center the cursor once
```

## Statusline

Show whether centering is on, e.g. with lualine:
```Lua
require("lualine").setup({
    sections = {
        lualine_x = {
            {
                function()
                    return "centered"
                end,
                cond = function()
                    return require("center-stage").is_enabled()
                end,
            },
        },
    },
})
```
