return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false, -- always latest
  dependencies = {
    "nvim-lua/plenary.nvim",

    -- media files extension
    {
      "nvim-telescope/telescope-media-files.nvim",
      dependencies = {
        "nvim-lua/popup.nvim", -- required
      },
    },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        prompt_prefix = " ",
        selection_caret = "❯ ",
        path_display = { "smart" },

        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_selected_to_qflist,
            ["<Esc>"] = actions.close,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },

      pickers = {
        find_files = {
          hidden = true,
        },
      },

      extensions = {
        media_files = {
          filetypes = { "png", "jpg", "jpeg", "gif", "webp", "mp4", "pdf" },
          find_cmd = "rg", -- requires ripgrep
        },
      },
    })

    -- Load extensions
    telescope.load_extension("media_files")
  end,
}
