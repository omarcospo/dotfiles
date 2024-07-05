return {
  {
    "echasnovski/mini.diff",
    opts = {
      view = { style = "number" },
      mappings = {
        apply = "gh", -- Apply hunks
        reset = "gH", -- Reset hunks
      },
    },
  },
  {
    "NeogitOrg/neogit",
    keys = {
      { "<leader>gg", ":Neogit<CR>" },
      { "<leader>gb", "<cmd>Telescope git_bcommits<cr>" },
      { "<leader>gl", "<cmd>Telescope git_commits<cr>" },
      { "<leader>fg", "<cmd>Telescope git_files<cr>" },
    },
    config = function()
      require("neogit").setup({
        disable_hint = true,
        disable_context_highlighting = true,
        auto_refresh = true,
        kind = "vsplit",
        auto_show_console = false,
        auto_close_console = true,
        commit_editor = { kind = "split", show_staged_diff = false },
        signs = {
          hunk = { "", "" },
          item = { " ", " " },
          section = { " ", " " },
        },
        commit_select_view = { kind = "split" },
        commit_view = { kind = "split", verify_commit = false },
        rebase_editor = { kind = "split" },
        reflog_view = { kind = "split" },
        merge_editor = { kind = "split" },
        tag_editor = { kind = "split" },
        log_view = { kind = "split" },
        popup = { kind = "split" }, -- keymaps
        mappings = {
          popup = {
            ["p"] = "PushPopup",
            ["P"] = "PullPopup",
          },
        },
      })
    end,
  },
}
