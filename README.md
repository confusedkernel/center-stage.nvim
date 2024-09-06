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

Coming soon!

## Enabling Keymap

`center-stage.nvim` can be used with function such as
- `CCEnable`: Enable center-stage.nvim
- `CCDisable`: Disable center-stage.nvim
- `CCToggle`: Toggle center-stage.nvim on and off

You can add a keymap to toggle the plugin more easily, example:
```Lua
vim.keymap.set({'n', 'v'}, '<leader>cc', require("center-stage").cc_toggle, { desc = "CCToggle" })
```
