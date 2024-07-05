return {
  "folke/todo-comments.nvim",
  ft = { "go", "typescript", "python", "lua" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    keywords = {
      DONE = { icon = "", color = "test" },
      TODO = { icon = " " },
      WARN = { icon = "", color = "warning" },
      NOTE = { icon = "" },
      FIX = { icon = "" },
    },
  },
}
