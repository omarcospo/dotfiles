return {
  "phaazon/hop.nvim",
  version = false,
  cmd = { "HopChar1" },
  opts = { keys = "etovxqpdygfblzhckisuran" },
  keys = {
    {
      "f",
      function()
        require("hop").hint_char1({ current_line_only = false })
      end,
    },
  },
}
