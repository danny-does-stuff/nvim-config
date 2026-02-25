local map = vim.keymap.set

-- escape insert mode
map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")

-- save & quit
map("n", "<leader>w", "<cmd>w<cr>")
map("n", "<leader>q", "<cmd>q<cr>")

-- buffer navigation
map("n", "<Tab>", "<cmd>bnext<cr>")
map("n", "<S-Tab>", "<cmd>bprev<cr>")

-- telescope buffers (MRU sort)
local BUFFERS_DESC = "Find buffers (MRU)"
local function findBuffers()
	require("telescope.builtin").buffers({
		sort_mru = true,
		ignore_current_buffer = true,
	})
end

map("n", "<leader>b", findBuffers, { desc = BUFFERS_DESC })
map("n", "<leader>fb", findBuffers, { desc = BUFFERS_DESC })

-- telescope oldfiles
map("n", "<leader>fo", function()
	require("telescope.builtin").oldfiles()
end, { desc = "Find oldfiles" })

-- window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- turn off highlights
map("n", "<leader>noh", "<cmd>noh<cr>")

-- quickfix navigation
map("n", "<leader>cn", "<cmd>cn<cr>", { desc = "Next quickfix" })
map("n", "<leader>cp", "<cmd>cp<cr>", { desc = "Previous quickfix" })

-- jump to definition in new buffer
map("n", "gv", ":rightbelow vsplit | lua vim.lsp.buf.definition()<CR>")
map("n", "gb", ":belowright split | lua vim.lsp.buf.definition()<CR>")

-- transfer.nvim shortcuts
map("n", "<leader>fu", "<cmd>TransferUpload<cr>", { desc = "Upload file to remote" })
map("n", "<leader>fd", "<cmd>TransferDownload<cr>", { desc = "Download file from remote" })
