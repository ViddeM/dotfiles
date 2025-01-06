return {
  -- Tree-sitter integration (Syntax tree reader)
  { 
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",
    config = function ()
	local configs = require("nvim-treesitter.configs")

	configs.setup({
	    ensure_installed = { "lua", "vim", "vimdoc", "lua", "rust", "toml", "javascript", "html" },
	    auto_install = true,
	    highlight = { 
	        enable = true ,
		additional_vim_regex_highlighting = false,
	    },
	    indent = { enable = true },
	    rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	    },
	})
    end
  },
}
