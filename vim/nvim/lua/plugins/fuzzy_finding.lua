return {
	-- Dependency for telescope
	"nvim-lua/plenary.nvim",
	{
		"nvim-telescope/telescope.nvim", -- Fuzzy finder window
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
                  require('telescope').setup({

			defaults = {
				sorting_strategy = "ascending",
				layout_strategy = "vertical",
				layout_config = {
					anchor = "top",
					height = 0.8,
					width = 0.8,
					mirror = false,
					prompt_position = "top",
				},
			},
			pickers = {
				buffers = {
					sort_lastused = true,
				},
			},
			extensions = {
				file_browser = {
					layout_strategy = "horizontal",
					hijack_netrw = true,
				},
			},
		})

                        -- Add custom commands
                        vim.api.nvim_create_user_command("TelescopeGrepOpenFiles", function()
                          require('telescope.builtin').live_grep({grep_open_files=true})
                        end, {})

              end
	},
        {
	-- File browser
        "nvim-telescope/telescope-file-browser.nvim",
        conig = function()
          require("telescope").load_extension("file_browser")
        end
      },
      {-- Snippet browser for telescope
	"benfowler/telescope-luasnip.nvim",
        conig = function()
          require("telescope").load_extension("luasnip")
        end
      },
}
