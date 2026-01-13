return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate", -- FIXED (uppercase)
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = "all",
      sync_install = false,
      ignore_install = {},

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enable = true,
        disable = { "yaml" },
      },
    })
  end,
}

