local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Theme
	{
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			require("onedark").setup({ style = "darker" })
			require("onedark").load()
		end,
	},

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = { theme = "onedark", globalstatus = true },
			sections = {
				lualine_c = { { "filename", path = 1 } },
			},
		},
	},

	-- Git signs
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			on_attach = function(buffer)
				local gs = require("gitsigns")
				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

				-- Navigation
				map("n", "]c", function()
					gs.nav_hunk("next")
				end, "Next hunk")
				map("n", "[c", function()
					gs.nav_hunk("prev")
				end, "Prev hunk")
				map("n", "<leader>hn", function()
					gs.nav_hunk("next")
				end, "Next hunk")

				-- Hunk actions
				map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
				map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
				map("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Stage hunk")
				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "Reset hunk")

				-- Buffer actions
				map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
				map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
				map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
				map("n", "<leader>hd", gs.diffthis, "Diff this")

				-- Text object
				map({ "o", "x" }, "ih", gs.select_hunk, "Select hunk")
			end,
		},
	},

	-- LazyGit
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},

	-- File icons
	{ "nvim-tree/nvim-web-devicons", opts = {} },

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"javascript",
					"typescript",
					"tsx",
					"json",
					"yaml",
					"html",
					"css",
					"bash",
					"markdown",
				},
				sync_install = false,
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

	-- Treesitter context
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
			opts = {
				enable = true,
				mode = "topline",
				multiline_threshold = 2,
			},
		config = function(_, opts)
			require("treesitter-context").setup(opts)
		end,
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files)
			vim.keymap.set("n", "<C-p>", builtin.find_files)
			vim.keymap.set("n", "<leader>fg", builtin.live_grep)
			vim.keymap.set("n", "<leader>fb", builtin.buffers)
			vim.keymap.set("n", "<leader>fs", builtin.grep_string)
		end,
	},

	-- Minimap
	{
		"Isrothy/neominimap.nvim",
		version = "v3.x.x",
		lazy = false,
		keys = {
			{ "<leader>nm", "<cmd>Neominimap Toggle<cr>", desc = "Toggle minimap" },
			{ "<leader>nf", "<cmd>Neominimap Focus<cr>", desc = "Focus minimap" },
			{ "<leader>nu", "<cmd>Neominimap Unfocus<cr>", desc = "Unfocus minimap" },
		},
		init = function()
			vim.opt.wrap = false
			vim.opt.sidescrolloff = 36
			vim.g.neominimap = {
				auto_enable = true,
			}
		end,
	},

	-- auto-session
	{
		"rmagatti/auto-session",
		lazy = false,

		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { "~/", "~/Downloads", "/" },
			-- log_level = 'debug',
		},
	},

	-- 99 - AI Agent
	{
		"ThePrimeagen/99",
		config = function()
			local _99 = require("99")
			local cwd = vim.uv.cwd()
			local basename = vim.fs.basename(cwd)
			_99.setup({
				logger = {
					level = _99.DEBUG,
					path = "/tmp/" .. basename .. ".99.debug",
					print_on_error = true,
				},
				completion = {
					custom_rules = {},
					files = {
						max_file_size = 102400,
						max_files = 5000,
					},
					source = "cmp",
				},
				md_files = {
					"AGENT.md",
				},
			})

			vim.keymap.set("v", "<leader>9v", function()
				_99.visual()
			end, { desc = "99 visual selection" })

			vim.keymap.set("v", "<leader>9s", function()
				_99.stop_all_requests()
			end, { desc = "99 stop all requests" })
		end,
	},

	-- LSP
	{ import = "plugins.lsp" },

	-- Completion
	{ import = "plugins.completion" },

	-- Formatting
	{ import = "plugins.formatting" },

	-- Fugitive (Git wrapper)
	{ "tpope/vim-fugitive" },
})
