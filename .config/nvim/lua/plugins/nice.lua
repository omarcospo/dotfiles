return {
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "Normal",
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = "",
      },
      minimum_width = 30,
      render = "wrapped-compact",
      stages = "static",
    },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = notify
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      presets = { inc_rename = true },
      background_color = "#161616",
      messages = { enabled = true },
      lsp = {
        hover = { enabled = false },
        signature = { enabled = false },
        progress = { enabled = false },
        message = { enabled = false },
        smart_move = { enabled = false },
      },
    },
    config = function(_, opts)
      require("noice").setup(opts)
    end,
  },
}
