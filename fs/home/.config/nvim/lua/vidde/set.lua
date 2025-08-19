vim.cmd.colorscheme("gruvbox")

vim.opt.clipboard = 'unnamedplus' -- Use system clipboard for yank.

-- [[ Context ]]
vim.opt.colorcolumn = '100'
vim.opt.nu = true -- Set line numbers
vim.opt.relativenumber = true -- relative numbers
vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"

-- [[ Filetypes ]]
vim.opt.encoding = 'utf8'
vim.filetype.add({ extension = { wgsl = "wgsl" } })

-- [[ Theme ]]
vim.opt.syntax = "ON" -- Allow syntax highlighting
vim.opt.termguicolors = true


-- [[ Search ]]
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true  -- Override ignorecase if search contains capitals
vim.opt.incsearch = true  -- Use incremental search
vim.opt.hlsearch = false   -- Highlight search matches

-- [[ Whitespace ]]
vim.opt.shiftwidth = 4  
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.list = true -- Show some whitespace(?)
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option('updatetime', 300)

