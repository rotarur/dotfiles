return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup({
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      manual_mode = true,
      show_hidden = true,
      silent_chdir = false,
      scope_chdir = "tab",
    })
  end,
}
