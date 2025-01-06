return {
    {
        "williamboman/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "",
                    package_pending = "",
                    package_uninstalled = "",
                }
            },
            ensure_installed = { "pylsp", "rust_analyzer", "eslint", "gopls", "wgsl_analyzer", "lua_ls", "kotlin_language_server" },
        }
    },
    {
        "neovim/nvim-lspconfig",
    },
    {
        "simrat39/rust-tools.nvim",
        config = function()
            local rust_tools = require("rust-tools")
            rust_tools.setup({
                server = {
                    on_attach = function(_, bufnr)
                        -- Hover actions
                        vim.keymap.set("n", "<C-space>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })

                        -- Code action groups
                        vim.keymap.set("n", "<Leader>a", rust_tools.code_action_group.code_action_group,
                            { buffer = bufnr })
                    end,
                    settings = {
                        ["rust-analyzer"] = {},
                    }
                }
            })
        end,
    },
    {
        "WhoIsSethDaniel/lualine-lsp-progress.nvim"
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup()
            local lspconfig = require("lspconfig")

            lspconfig.pylsp.setup {}
            lspconfig.rust_analyzer.setup {}
            lspconfig.eslint.setup {}
            lspconfig.gopls.setup {}
            lspconfig.wgsl_analyzer.setup {}
            lspconfig.lua_ls.setup {}
            lspconfig.kotlin_language_server.setup {}
        end,
    },
}
