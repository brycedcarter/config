return {
	{
		-- Commenting improvements
		"numToStr/Comment.nvim",
		opts = {
			mappings = {
				-- Disable default mappings
				basic = false,
				extra = false,
			},
		},
	},
	{
		-- Github link gen
		"ruifm/gitlinker.nvim",
		config = function()
			local hosts = require("gitlinker.hosts")
			require("gitlinker").setup({
				opts = {
					action_callback = function(url)
						vim.fn.setreg("", url)
                                                vim.api.nvim_exec_autocmds("TextYankPost", {})
					end,
				},
				callbacks = {
					["github.com"] = hosts.get_github_type_url,
					["git.zooxlabs.com"] = hosts.get_github_type_url,
				},
					mappings = '<leader>Gy',
			})

		end,
	},
	{
		-- Git blame window
		"FabijanZulj/blame.nvim",
		opts = { date_format = "%m-%d-%Y" },
	},
	{
		"akinsho/git-conflict.nvim",
		opts = { default_mappings = false },
	},
}
