-- todo: whichkey
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})
vim.keymap.set('n', '<leader>fs', telescope.treesitter, {}) -- find symbols
vim.keymap.set('n', '<leader>fu', ":TodoTelescope<Enter>", {}) -- find todos
vim.keymap.set('n', '<leader>ft', pick_rust_target, {}) -- find rust targets
vim.keymap.set('n', 'U', ":redo<Enter>", {})
vim.keymap.set('n', '<leader>p', ":b#<Enter>", {}) -- goto previous buffer

--vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
--vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
--vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<leader>ld', telescope.lsp_definitions, opts)
    vim.keymap.set('n', '<leader>lr', telescope.lsp_references, opts)
    vim.keymap.set('n', '<leader>li', telescope.lsp_implementations, opts)
    vim.keymap.set('n', '<leader>lt', telescope.lsp_type_definitions, opts)
    vim.keymap.set('n', '<leader>le', telescope.diagnostics, opts)
    vim.keymap.set('n', '<leader>ls', telescope.lsp_workspace_symbols, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
  end,
})

