local M = {}

function M.edit_neovim()
  require('telescope.builtin').find_files {
      cwd = "~/.config/nvim/",
      hidden = false,
      prompt_title = "nvim dot files"
}
end

return M
