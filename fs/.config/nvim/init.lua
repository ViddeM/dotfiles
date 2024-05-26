local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- First arg is 'plugins', second arg is 'options' (optional)
require("lazy").setup("plugins")

require("vars")
require("fns")
require("opts")

-- Format on save
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]


