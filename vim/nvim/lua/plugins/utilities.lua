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
				callbacks = {
					["github.com"] = hosts.get_github_type_url,
					["git.zooxlabs.com"] = hosts.get_github_type_url,
				},
				mappings = "<leader>Gl",
			})
		end,
	},
        {
          -- Git blame window
          'FabijanZulj/blame.nvim',
          opts = {date_format = "%m-%d-%Y"}
        },
}
