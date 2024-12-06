return {
	{
		-- language server protocol client std configs
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig").clangd.setup({
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "hpp" },
			})
			require("lspconfig").pyright.setup({
				root_dir = require("lspconfig").util.root_pattern(".git", "WORKSPACE"),
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
			require("lspconfig").lua_ls.setup({
				settings = { Lua = { diagnostics = { globals = { "vim" } } } },
			})

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

			-- Turn on inlay hints by default
			vim.lsp.inlay_hint.enable(true)

			-- Add custom commands
			vim.api.nvim_create_user_command("ToggleInlayHints", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end, {})
			vim.api.nvim_create_user_command("ApplyCodeAction", function()
				vim.lsp.buf.code_action({ apply = true })
			end, {})
			vim.api.nvim_create_user_command("LspJumpDecl", function()
				vim.lsp.buf["declaration"]()
			end, {})
			vim.api.nvim_create_user_command("LspJumpDiagNext", function()
				vim.diagnostic.goto_next()
			end, {})
			vim.api.nvim_create_user_command("LspJumpDiagPrev", function()
				vim.diagnostic.goto_prev()
			end, {})
			vim.api.nvim_create_user_command("LspHover", function()
				vim.lsp.buf["hover"]()
			end, {})
			vim.api.nvim_create_user_command("LspShowDiag", function()
				vim.diagnostic.open_float(nil, { focus = false })
			end, {})
		end,
	},
	{
		-- Tool for managing things like external LSP tools
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		-- Tool to provide and easy way to install all of the mason tools
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
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
				"markdownlint",
			},
			auto_update = false,
			run_on_start = true,
		},
	},
	{
		-- Compatibility plugin for lspconfig and mason
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup()
			require("mason-lspconfig").setup_handlers({
				function(server)
					require("lspconfig")[server].setup({})
				end,
			})
		end,
	},

	-- LSP completion icons
	"onsails/lspkind.nvim",
	"p00f/clangd_extensions.nvim",
	{
		-- formatter tools, pairs with mason for actually installing the formatters
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black" },
					cpp = { "clang-format" },
					javascript = { "prettierd" },
					proto = { "buf" },
					json = { "jq" },
					markdown = { "markdownlint" },
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
		end,
	},
	{
		-- Linter manager that integrates its output into the nvim LSP diagnostics
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				markdown = { "markdownlint" },
				python = { "mypy" },
				cpp = { "cpplint" },
				sh = { "shellcheck" },
				proto = { "buf_lint" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					lint.try_lint()
				end,
			})

			-- Add custom commands
			vim.api.nvim_create_user_command("TryLint", function()
                          require('lint').try_lint()
			end, {})
		end,
	},
}
