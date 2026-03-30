vim.opt.termguicolors = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.laststatus = 3  -- global statusline (Neovim 0.7+)
vim.opt.splitright = true

-- search with not case sensitivity unless uppercase letters are used
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.list = true
vim.opt.listchars = {
  tab = ">·",
  trail = "~",
  extends = "»",
  precedes = "«",
  nbsp = "␣",
  space = "·",
}

vim.opt.clipboard = 'unnamedplus'
vim.opt.confirm = true
