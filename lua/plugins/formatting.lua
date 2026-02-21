return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = {
			format_on_save = { lsp_fallback = true },
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
			},
		},
	},
}
