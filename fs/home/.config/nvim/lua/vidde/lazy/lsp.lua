return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
    	"williamboman/mason-lspconfig.nvim",

        -- Completion sources
    	"hrsh7th/cmp-nvim-lsp",
    	"hrsh7th/cmp-buffer",
    	"hrsh7th/cmp-path",
    	"hrsh7th/cmp-cmdline",
    	"hrsh7th/nvim-cmp",

        -- Status line
        "linrongbin16/lsp-progress.nvim",

    	-- "L3MON4D3/LuaSnip",
    	-- "saadparwaiz1/cmp_luasnip",
    	-- "j-hui/fidget.nvim",
    },
    config = function()
        
    end
}
