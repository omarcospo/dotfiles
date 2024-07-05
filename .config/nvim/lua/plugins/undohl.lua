return {
  "tzachar/highlight-undo.nvim",
  event = "User BaseDefered",
  opts = {
    hlgroup = "CurSearch",
    duration = 150,
    keymaps = {
      { "n", "u", "undo", {} }, -- If you remap undo/redo, change this
      { "n", "<C-r>", "redo", {} },
    },
  },
  config = function(_, opts)
    require("highlight-undo").setup(opts)
    -- Also flash on yank.
    vim.api.nvim_create_autocmd("TextYankPost", {
      desc = "Highlight yanked text",
      pattern = "*",
      callback = function()
        vim.highlight.on_yank()
      end,
    })
  end,
}
