return {
  {
    "Zeioth/compiler.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
    opts = {},
    init = function()
      vim.keymap.set("n", "<leader>cc", "<CMD>CompilerOpen<CR>")
      vim.keymap.set("n", "<leader>cr", "<CMD>CompilerRedo<CR>")
      vim.keymap.set("n", "<leader>co", "<CMD>CompilerToggleResults<CR>")
    end,
    config = function()
      require("compiler").setup()
    end,
  },
  {
    "stevearc/overseer.nvim",
    cmd = {
      "OverseerOpen",
      "OverseerClose",
      "OverseerToggle",
      "OverseerSaveBundle",
      "OverseerLoadBundle",
      "OverseerDeleteBundle",
      "OverseerRunCmd",
      "OverseerRun",
      "OverseerInfo",
      "OverseerBuild",
      "OverseerQuickAction",
      "OverseerTaskAction",
      "OverseerClearCache",
    },
    opts = {
      task_list = {
        direction = "bottom",
        max_width = 0.2,
        min_width = 0.2,
        max_height = 0.6,
        min_height = 0.4,
        default_detail = 1,
      },
      bindings = {
        ["<CR>"] = "RunAction",
        ["<C-v>"] = "OpenVsplit",
        ["<C-l>"] = "IncreaseDetail",
        ["<C-h>"] = "DecreaseDetail",
        ["<C-k>"] = "ScrollOutputUp",
        ["<C-j>"] = "ScrollOutputDown",
        ["q"] = "Close",
      },
    },
    config = function(_, opts)
      require("overseer").setup(opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "OverseerList",
        callback = function()
          vim.opt_local.cursorline = nocursorline
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.opt_local.scrolloff = 0
          vim.keymap.set("n", "j", "<Plug>OverseerTask:NextTask", { buffer = true, silent = true })
          vim.keymap.set("n", "k", "<Plug>OverseerTask:PrevTask", { buffer = true, silent = true })
          vim.keymap.set("n", "l", "<Plug>OverseerTask:IncreaseWidth", { buffer = true, silent = true })
          vim.keymap.set("n", "h", "<Plug>OverseerTask:DecreaseWidth", { buffer = true, silent = true })
        end,
      })
    end,
  },
}
