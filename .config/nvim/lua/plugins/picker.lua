return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({
      winopts = {
        on_create = function()
          vim.keymap.set("t", "<C-q>", "<C-c>", { silent = true, buffer = true })
        end,
      },
      keymap = {
        builtin = {
          ["<C-i>"] = "toggle-preview",
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
        },
      },
    })
    vim.keymap.set("n", "<leader>bb", "<cmd>FzfLua buffers<CR>", { silent = true })
    vim.keymap.set("n", "<leader>a", "<cmd>FzfLua lgrep_curbuf<CR>", { silent = true })
    vim.keymap.set("n", "<leader>s", "<cmd>FzfLua live_grep<CR>", { silent = true })
    vim.keymap.set("n", "<leader>h", "<cmd>FzfLua files<CR>", { silent = true })
    vim.keymap.set("n", "<leader>fr", function()
      local actions = require("fzf-lua.actions")
      local files = vim.tbl_filter(function(file)
        return not (string.match(file, "term") or string.match(file, "undo")) and vim.fn.filereadable(file) == 1
      end, vim.v.oldfiles)
      require("fzf-lua").fzf_exec(files, {
        actions = {
          ["default"] = actions.file_edit,
        },
        previewer = "builtin",
        prompt = "Recent - ",
      })
    end, { silent = true })
  end,
}
