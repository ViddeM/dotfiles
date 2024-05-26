-- change rust-analyzer target
set_rust_target = function(target)
  print("rust-analyzer.cargo.target = " .. target)
  require("rust-tools").setup({
    server = { settings = { ["rust-analyzer"] = { cargo = { target = target } } } },
  })
end

-- A custome telescope picker for changing rust-analyzer target
pick_rust_target = function(opts)
  opts = opts or {}
  require("telescope.pickers").new(opts, {
    prompt_title = "rustup target list --installed",
    finder = require("telescope.finders").new_oneshot_job({ "rustup", "target", "list", "--installed" }, opts ),
    sorter = require("telescope.config").values.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      local actions = require("telescope.actions")
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = require("telescope.actions.state").get_selected_entry()
        set_rust_target(selection[1])
      end)
      return true
    end,
  }):find()
end
