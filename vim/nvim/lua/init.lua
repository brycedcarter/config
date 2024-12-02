-- Bootstrap lazy and load plugins from plugins.lua
require("config.lazy")

-- max popup height
vim.o.pumheight = 10

-- ====================== COPY/YANK CONFIG =================================
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		local status, osc52 = pcall(require, "vim.ui.clipboard.osc52")
		if not status then
			print(
				"WARNING: This version of nvim is too old to support OSC52. The contents of the copy yank was not added to the system clipboard.. Please install nvim 10.0 or newer"
			)
		else
			-- we are running on a new enough version of nvim to support
			-- osc52
			osc52.copy("+")(vim.split(vim.fn.getreg(vim.v.event.regname), "\n"))
		end
	end,
})
