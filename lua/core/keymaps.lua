local map = vim.keymap.set

-- escape insert mode
map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")

-- save & quit
map("n", "<leader>w", "<cmd>w<cr>")
map("n", "<leader>q", "<cmd>q<cr>")

-- window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- turn off highlights
map("n", "<leader>noh", "<cmd>noh<cr>")

-- jump to definition in new buffer
map("n", "gv", ":rightbelow vsplit | lua vim.lsp.buf.definition()<CR>")
map("n", "gb", ":belowright split | lua vim.lsp.buf.definition()<CR>")
