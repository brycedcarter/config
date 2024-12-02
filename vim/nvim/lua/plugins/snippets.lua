return {
	{
		-- Snippet tool
		"L3MON4D3/LuaSnip",
		config = function()
			local snippets_paths = { vim.g.snippet_path, vim.g.work_snippet_path }
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_vscode").lazy_load({ paths = snippets_paths })
			require("luasnip.loaders.from_lua").lazy_load({ paths = snippets_paths })

			-- Add custom commands
			vim.api.nvim_create_user_command("EditSnippetFiles", function()
				require("luasnip.loaders").edit_snippet_files()
			end, {})
		end,
	},
	-- snippet collection
	"rafamadriz/friendly-snippets",
	{
		-- Snippet generation tool to work in consort with luasnip
		"ziontee113/SnippetGenie",
		config = function()
			require("SnippetGenie").setup({
				regex = [[-\+ SNIPPET GENIE LOC]],
				snippets_directory = vim.g.snippet_path,
				file_name = "luasnip_snippets",
				snippet_skeleton = [[
s(
    "{trigger}",
    fmt([=[
{body}
]=], {{
        {nodes}
    }})
),
]],
			})

			-- I could not figure out how to get this working with normal vim keybindings so
			-- i guess this is what we have for now
			vim.keymap.set("x", "<CR>", function()
				require("SnippetGenie").create_new_snippet_or_add_placeholder()
				vim.cmd("norm! ") -- exit Visual Mode, go back to Normal Mode
			end, {})
			vim.keymap.set("n", "<CR>", function()
				require("SnippetGenie").finalize_snippet()
			end, {})


			-- Add custom commands
			vim.api.nvim_create_user_command("SaveSnippetsToPersonal", function()
                                require('SnippetGenie').setup({snippets_directory = vim.g.snippet_path})
			end, {})
			vim.api.nvim_create_user_command("SaveSnippetsToWork", function()
                                require('SnippetGenie').setup({snippets_directory = vim.g.work_snippet_path})
			end, {})
		end,
	},
}
