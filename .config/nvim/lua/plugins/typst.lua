return {
  "chomosuke/typst-preview.nvim",
  ft = "typst", -- or ft = 'typst'
  version = false,
  build = function()
    require("typst-preview").update()
  end,
}
