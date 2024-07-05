return {
  "MeanderingProgrammer/markdown.nvim",
  name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
  ft = "markdown",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("render-markdown").setup({
      file_types = { "markdown" },
      headings = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
      highlights = {
        heading = { backgrounds = "Normal" },
        bullet = "Normal",
        table = { head = "Normal" },
      },
    })
  end,
}
