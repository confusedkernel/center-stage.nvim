if vim.g.loaded_center_stage then
	return
end
vim.g.loaded_center_stage = true

require("center-stage").create_commands()
