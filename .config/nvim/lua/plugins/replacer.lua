return {
  "MagicDuck/grug-far.nvim",
  event = "BufReadPost",
  config = function()
    require("grug-far").setup({
      keymaps = {
        replace = { n = "<localleader>r" },
        qflist = { n = "<localleader>q" },
        syncLocations = { n = "<localleader>s" },
        syncLine = { n = "<localleader>l" },
        close = { n = "q" },
        historyOpen = { n = "<localleader>t" },
        historyAdd = { n = "<localleader>a" },
        refresh = { n = "<localleader>f" },
        gotoLocation = { n = "<enter>" },
        pickHistoryEntry = { n = "<enter>" },
      },
      icons = {
        enabled = true,
        actionEntryBullet = "󰐊 ",
        searchInput = " ",
        replaceInput = " ",
        filesFilterInput = " ",
        flagsInput = "󰮚 ",
        resultsStatusReady = "󱩾 ",
        resultsStatusError = " ",
        resultsStatusSuccess = "󰗡 ",
        resultsActionMessage = "  ",
        historyTitle = "  ",
      },
    })
    vim.keymap.set("n", "<leader>r", ":GrugFar<CR>", { remap = true })
  end,
}
