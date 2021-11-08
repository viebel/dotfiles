local M = {}

function M.edit_neovim()
  require('telescope.builtin').find_files {
      cwd = "~/.config/nvim/",
      hidden = true,
      prompt_title = "nvim dot files"
}
end

function M.grep_neovim_files()
  require('telescope.builtin').live_grep {
      cwd = "~/.config/nvim/",
      prompt_title = "grep nvim files"
}
end

function M.find_configs()
  require("telescope.builtin").find_files {
    prompt_title = " NVim & Term Config Find",
    results_title = "Config Files Results",
    path_display = { "smart" },
    hidden = true,
    cwd = "~/dotfiles/",
  }
end

function M.grep_configs()
  require("telescope.builtin").live_grep {
    prompt_title = " Configs Grep",
    results_title = "Config Results",
    cwd = "~/dotfiles",
  }
end


return M
