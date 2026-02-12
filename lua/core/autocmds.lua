vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- When nvim is opened with a directory argument, set the working directory to it.
-- This ensures Telescope and other tools search from the intended directory
-- rather than the shell's cwd at launch time.
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local arg = vim.fn.argv(0)
    if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
      vim.cmd.cd(vim.fn.fnamemodify(arg, ":p"))
    end
  end,
})
