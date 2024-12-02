return {
	{
		-- Status line
		"nvim-lualine/lualine.nvim",
		opts = {},
	},
	{
		-- Visual buffer tabs
		"akinsho/bufferline.nvim",
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				show_buffer_icons = true,
				color_icons = true,
				separator_style = "thick",
				show_buffer_close_icons = false,
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or ""
					return " " .. icon .. count
				end,
			},
		},
	},
	-- icons for bufferline
	"nvim-tree/nvim-web-devicons",
	{
		-- Outline viewer
		"stevearc/aerial.nvim",
		opts = {
			filter_kind = false,
			backends = { "lsp", "treesitter", "markdown", "man" },
			highlight_on_hover = true,
			nerd_font = "false",
		},
	},
	-- Better quick fix window
	"kevinhwang91/nvim-bqf",
	{
		-- Selectively enable 80 char line
		"m4xshen/smartcolumn.nvim",
		opts = {},
	},
	{
		-- Scrollbar
		"petertriho/nvim-scrollbar",
		opts = {
			handlers = {
				cursor = true,
				diagnostic = true,
				gitsigns = true, -- Requires gitsigns
				handle = true,
				search = false, -- Requires hlslens
				ale = false, -- Requires ALE
			},
		},
	},
	{
		-- show git status in gutter
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
	-- improved ui input and selection
	"stevearc/dressing.nvim",
	-- Highlight colors for ui development
	"brenoprata10/nvim-highlight-colors",
}
