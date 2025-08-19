return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        keywords = {
            SAFETY = {
                icon = "☢",
                color = "warning",
                alt = { "SOUNDNESS", "UNSAFE", "UNSOUND" },
            },
            INVARIANT = {
                icon = "🦑",
                color = "hint",
            },
        }    
    }
}
