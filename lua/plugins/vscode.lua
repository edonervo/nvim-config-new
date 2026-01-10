return {
  "Mofiqul/vscode.nvim",
  priority = 1000, -- load before other UI plugins
  config = function()
    require("vscode").setup({
      transparent = false,
      italic_comments = true,
      underline_links = true,
      disable_nvimtree_bg = true,
    })

    vim.cmd.colorscheme("vscode")
  end,
}

