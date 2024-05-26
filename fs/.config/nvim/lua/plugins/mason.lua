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
        ensure_installed = { "pylsp", "rust_analyzer", "eslint", "gopls", "wgsl_analyzer" },
    }
  },
  {
    "neovim/nvim-lspconfig"
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    
  }, 
  {
    "simrat39/rust-tools.nvim"
  },
  {
    "WhoIsSethDaniel/lualine-lsp-progress.nvim"
  }
}

