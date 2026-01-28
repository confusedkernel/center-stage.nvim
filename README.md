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
- `offset` (number): Adjusts the window offset from center (positive moves cursor up).
- `pattern` (string|table): Autocmd pattern(s) to match buffers.
- `ignore_buftypes` (table): Buffer types to skip (e.g. `help`, `terminal`).
- `ignore_filetypes` (table): Filetypes to skip.

## Commands and Keymaps

`center-stage.nvim` can be used with function such as
- `CSEnable`: Enable center-stage.nvim
- `CSDisable`: Disable center-stage.nvim
- `CSToggle`: Toggle center-stage.nvim on and off

You can add a keymap to toggle the plugin more easily, example:
```Lua
vim.keymap.set({ "n", "v" }, "<leader>cs", require("center-stage").cs_toggle, { desc = "CSToggle" })
```
