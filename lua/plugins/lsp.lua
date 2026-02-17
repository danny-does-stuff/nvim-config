return {
	{ "williamboman/mason.nvim", opts = {} },

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"eslint",
				"jsonls",
				"yamlls",
				"bashls",
				"intelephense",
				"tailwindcss",
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			-- Diagnostic configuration to show source
			vim.diagnostic.config({
				virtual_text = {
					source = true,
				},
				float = {
					source = true,
				},
			})

			-- LSP keymaps applied per-buffer when a server attaches
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gh", function()
						vim.diagnostic.open_float(nil, { scope = "cursor" })
					end, opts)
				end,
			})

			-- Server configs (Neovim 0.11+)
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
					},
				},
			})

			vim.lsp.config("ts_ls", {})
			vim.lsp.config("eslint", {})
			vim.lsp.config("jsonls", {})
			vim.lsp.config("yamlls", {})
			vim.lsp.config("bashls", {})
			vim.lsp.config("intelephense", {
				settings = {
					intelephense = {
						format = {
							braces = "k&r",
						},
					},
				},
			})

			vim.lsp.config("tailwindcss", {})

			-- Enable servers
			vim.lsp.enable({ "lua_ls", "ts_ls", "eslint", "jsonls", "yamlls", "bashls", "intelephense", "tailwindcss" })
		end,
	},
}
