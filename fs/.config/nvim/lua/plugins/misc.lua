return {
  -- Closes brackets on 'Enter'
  { "rstacruz/vim-closer" },

  -- Matches language-specific words (highlight) e.g. if/endif
  { "andymass/vim-matchup" },

  -- Completions? TODO: (Ask tux?)
  -- { "haorenW1025/completion-nvim" },
 
  -- Show cursor jump (highlight target row)
  { "danilamihailov/beacon.nvim" },

  -- nvim-lua/plenary? (Lua libs)
  { "nvim-lua/plenary.nvim" },

  -- Hightlight TODO: comments
  { 
    "folke/todo-comments.nvim", 
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
    }
  },
}
