local wk = require("which-key")
local ts = require('telescope.builtin')

local non_lsp_mappings = {
    { "<leader>e", vim.cmd.Ex, desc = "Open file explorer" },
    { "<leader>/", "<Plug>(comment_toggle_linewise_currencope.find_files)", desc = "Toggle comment" },
    { "<leader>p", '"_dP', desc = "Paste without overwrite" },
    { "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", desc = "Search and replace word under cursor" },
    { "<leader>ff", ts.find_files, desc = "Find files" },
    { "<leader>fg", ts.live_grep, desc = "Find in files" },
    { "<leader>fs", ts.treesitter, desc = "Find symbols" },
    { "<leader>fu", ":TodoTelescope<Enter>", desc = "Find TODOs" },
    { "<leader>p", ":b#<Enter>", desc = "Goto previous buffer" },

    { "s", function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "Flash" },
    { "S", function() require("flash").treesitter() end, mode = { "n", "x", "o" }, desc = "Flash Treesitter" },
    { "r", function() require("flash").remote() end, mode = "o", desc = "Remote Flash" },
    { "R", function() require("flash").treesitter_search() end, mode = { "o", "x" }, desc = "Treesitter Search" },
    { "<c-s>", function() require("flash").toggle() end, mode = { "c" }, desc = "Toggle Flash Search" },
}

wk.add(non_lsp_mappings)

-- Add LSP keybinds only after the lsp attaches to the current buffer.
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x>,c-o>
        -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local lsp_mappings = {
            { "<leader>ld", ts.lsp_definitions, desc = "Show definitions" },
            { "<leader>lr", ts.lsp_references, desc = "Show references" },
            { "<leader>li", ts.lsp_implementation, desc = "Show implementations" },
            { "<leader>lt", ts.lsp_type_definitions, desc = "Show type definitions" },
            { "<leader>le", ts.diagnostics, desc = "Show diagnostics" },
            { "<leader>ls", ts.lsp_workspace_symbols, desc = "Show workspace symbols" },
            { "K", vim.lsp.buf.hover, desc = "Show on hover" },
            { "<C-k>", vim.lsp.buf.signature_help, desc = "Show help for signature" },
            { "<leader>wa", vim.lsp.buf.add_workspace_folder, desc = "Add workspace folder" },
            { "<leader>wr", vim.lsp.buf.remove_workspace_folder, desc = "Remove workspace folder" },
            { "<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, 
                desc = "List workspace folders"
            },
            { "<leader>r", vim.lsp.buf.rename, desc = "Rename symbol" },
            { "<leader>a", vim.lsp.buf.code_action, desc = "Code Action" },
            { "<leader>l", desc = "Language server stuff" },
            { "<leader>w", desc = "Workspace stuff" },
        }
    
        wk.add(lsp_mappings, { buffer = ev.buf })
    end
})

