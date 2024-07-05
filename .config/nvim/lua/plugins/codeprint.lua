return {
  "TobinPalmer/rayso.nvim",
  cmd = { "Rayso" },
  opts = {
    base_url = "https://ray.so/",
    open_cmd = "org.mozilla.firefox",
    options = {
      background = false,
      dark_mode = true,
      logging_path = "",
      logging_file = "rayso",
      logging_enabled = false,
      padding = 16,
      theme = "sunset",
      title = "Untitled",
    },
  },
  init = function()
    vim.keymap.set("v", "<leader>l", "<CMD>Rayso<CR>")
  end,
}
