-- Configure language servers for autocompletion and error checking
local on_attach = function(client, bufnr)
	-- Setup the omnifunc that is can be used by completion tools
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- Helper function that checks for a connected server before issuing an lsp
-- command
function TryLsp(lsp_command)
	-- NOTE: server_ready() was deprecated in nvim 10.0
	-- if vim.lsp.buf.server_ready() then
	vim.lsp.buf[lsp_command]()
	-- else
	-- print("No lsp server currently ready to process this command... Try :LspInfo for more information")
	-- end
end

-- hackey workaround for slow pyright on 20.04... maybe a newer build will fix
-- it?
-- https://github.com/neovim/neovim/issues/23725#issuecomment-1561364086
local ok, wf = pcall(require, "vim.lsp._watchfiles")
if ok then
	-- disable lsp watcher. Too slow on linux
	wf._watchfunc = function()
		return function() end
	end
end

-- New management
local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
require("mason").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"lua-language-server",
		"vim-language-server",
		"stylua",
		"editorconfig-checker",
		"luacheck",
		"shellcheck",
		"shfmt",
		"clangd",
		"pyright", -- pyright is trouble, if having issues with high cpu, try disabling
		"jedi-language-server",
		"cpplint",
		"black",
		"bzl",
		"mypy",
		"clang-format",
		"typescript-language-server",
		"buf",
		"marksman",
		"prettierd",
	},
	auto_update = false,
	run_on_start = false,
})

require("lint").linters_by_ft = {
	markdown = { "vale" },
	python = { "mypy" },
	cpp = { "cpplint" },
	sh = { "shellcheck" },
	proto = { "buf_lint" },
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
	function(server)
		lspconfig[server].setup({})
	end,
})

require("lspconfig").clangd.setup({
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "hpp" },
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		cpp = { "clang-format" },
		javascript = { "prettier" },
		proto = { "buf" },
		json = { "jq" },
		markdown = { "mdformat" },
		swift = { "swiftformat" },
	},
})

vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

-- -- init.lua or a similar file
-- local lspconfig = require('lspconfig')
--
lspconfig.pyright.setup({
	root_dir = lspconfig.util.root_pattern(".git", "WORKSPACE"),
	settings = {
		python = {
			analysis = {
				extraPaths = { "bazel-out" },
				logLevel = "Trace",
				log = {
					directory = "/tmp/pyright_logs",
					level = "trace",
				},
			},
		},
	},
})
--   on_attach = function(client, bufnr)
--     -- Add bazel-out to the workspace folders if not already added
--     local workspace_folders = client.workspace_folders
--     local bazel_out_path = vim.fn.fnamemodify("bazel-out", ":p")
--     local found = false
--
--     for _, folder in ipairs(workspace_folders) do
--       if folder.name == bazel_out_path then
--         found = true
--         break
--     end
--
--     if not found then
--       client.workspace_folders[#client.workspace_folders + 1] = {
--         uri = vim.uri_from_fname(bazel_out_path),
--         name = bazel_out_path,
--       }
--       client.notify("workspace/didChangeWorkspaceFolders", {
--         event = {
--           added = { { uri = vim.uri_from_fname(bazel_out_path) } },
--           removed = {},
--         }
--       })
--     end
--   end
-- end
-- }
--
-- General nvim settings

-- Status line setup
require("lualine").setup()
require("bufferline").setup({
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
})

-- max popup height
vim.o.pumheight = 10

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

-- show pretty symbols in the gutter for diagnostics
local signs = { Error = "ⓧ", Warn = "⚠", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- hide inline diagnostic
vim.diagnostic.config({
	virtual_text = false,
})

-- Set up nvim-cmp.
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = {
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 0,
		},
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<tab>"] = cmp.mapping.select_next_item(),
		["<s-tab>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<esc>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" }, -- LSP
		{ name = "luasnip" }, -- For luasnip users.
	}, {
		{ name = "buffer" },
	}, {
		{ name = "path" },
	}),
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. strings[1] .. " "
			kind.menu = "    (" .. strings[2] .. ")"

			return kind
		end,
	},
	--matching.disallow_fuzzy_matching = false,
	--matching.disallow_partial_matching = false
})

-- Use buffer source for `/` and `?` (completion for vim search)
-- NOTE currently this does not work because we use magic search:
-- https://github.com/hrsh7th/cmp-cmdline/issues/14
--cmp.setup.cmdline({ '/', '?' }, {
--mapping = cmp.mapping.preset.cmdline(),
--sources = {
--{ name = 'buffer' }
--},
--view = {
--entries = {name = 'wildmenu', separator = '|' }
--},
--})

-- Use cmdline & path source for ':'  (completion for in the vim command line)
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- Syntax parser
require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp", "python", "markdown" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	-- List of parsers to ignore installing (or "all")
	ignore_install = { "javascript" },

	highlight = {
		enable = true,
		disable = {},
		-- Don't highlight for huge files
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
})

require("nvim-treesitter.configs").setup({
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-Up>",
			scope_incremental = "<C-Right>",
			node_incremental = "<C-Up>",
			node_decremental = "<C-Down>",
		},
	},
})

require("telescope").setup({

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

require("smartcolumn").setup()
require("Comment").setup({
	mappings = {
		-- Disable default mappings
		basic = false,
		extra = false,
	},
})
require("gitlinker").setup({
	callbacks = {
		["github.com"] = require("gitlinker.hosts").get_github_type_url,
		["git.zooxlabs.com"] = require("gitlinker.hosts").get_github_type_url,
	},
	mappings = "<leader>Gl",
})

require("scrollbar").setup({
	handlers = {
		cursor = true,
		diagnostic = true,
		gitsigns = true, -- Requires gitsigns
		handle = true,
		search = false, -- Requires hlslens
		ale = false, -- Requires ALE
	},
})
require("gitsigns").setup()

local snippets_paths = { vim.g.snippet_path, vim.g.work_snippet_path }
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = snippets_paths })
require("luasnip.loaders.from_lua").lazy_load({ paths = snippets_paths })

require("telescope").load_extension("file_browser")
require("telescope").load_extension("luasnip")
require("aerial").setup({
	filter_kind = false,
	backends = { "lsp", "treesitter", "markdown", "man" },

	--{
	--"Class",
	--"Constructor",
	--"Enum",
	--"Function",
	--"Interface",
	--"Module",
	--"Method",
	--"Struct",
	--"Variable",
	--"Property",
	--"Field",
	--"Object",
	--"String",
	--"Number",
	--}
	highlight_on_hover = true,
	nerd_font = "false",
})

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
