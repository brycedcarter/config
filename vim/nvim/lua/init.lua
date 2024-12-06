-- Bootstrap lazy and load plugins from plugins.lua
require("config.lazy")

-- max popup height
vim.o.pumheight = 10

-- ====================== COPY/YANK CONFIG =================================
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		require('vim.ui.clipboard.osc52').copy("+")(vim.split(vim.fn.getreg(""), "\n"))
	end,
})
