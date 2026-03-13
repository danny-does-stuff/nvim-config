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
			-- Add foldingRange capabilities for nvim-ufo
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true
			}

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

			-- Server configs (Neovim 0.11+) with folding capabilities
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
						format = { enable = false },
					},
				},
			})

			vim.lsp.config("ts_ls", { capabilities = capabilities })
			vim.lsp.config("eslint", { capabilities = capabilities })
			vim.lsp.config("jsonls", { capabilities = capabilities })
			vim.lsp.config("yamlls", { capabilities = capabilities })
			vim.lsp.config("bashls", { capabilities = capabilities })
			vim.lsp.config("intelephense", {
				capabilities = capabilities,
				settings = {
					intelephense = {
						format = {
							braces = "k&r",
						},
					},
				},
			})

			vim.lsp.config("tailwindcss", {
				capabilities = capabilities,
				settings = {
					tailwindCSS = {
						classAttributes = { "class", "className", "ngClass", "class:list" },
						experimental = {
							classRegex = {
								-- className: '...'  className: "..."  className: `...`
								{ "className\\s*:\\s*['\"`]([^'\"`]*)['\"`]", "" },
								-- className={...} or className="..."
								{ "className\\s*=\\s*['\"`{]([^'\"`}]*)['\"`}]", "" },
								-- any key named className in objects: { className: '...' }
								{ "['\"]className['\"]\\s*:\\s*['\"`]([^'\"`]*)['\"`]", "" },
							},
						},
					},
				},
			})

			-- Enable servers
			vim.lsp.enable({ "lua_ls", "ts_ls", "eslint", "jsonls", "yamlls", "bashls", "intelephense", "tailwindcss" })
		end,
	},
}
