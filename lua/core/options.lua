local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2

opt.wrap = false
opt.scrolloff = 5
opt.sidescrolloff = 5

opt.termguicolors = true
opt.signcolumn = "yes"
opt.updatetime = 200

opt.clipboard = "unnamedplus"

opt.ignorecase = true
opt.smartcase = true

opt.list = true
opt.listchars = { tab = "│ ", trail = "·", nbsp = "␣" }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

