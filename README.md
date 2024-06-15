# center-stage.nvim

A Neovim plugin that keeps your cursor at the center stage 24/7 (if you enable it, of course.)

## Installation

Using Lazy:
```Lua
{ "nottyl/center-stage.nvim" }
```

Using Packer:
```Lua
use "nottyl/center-stage.nvim"
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
