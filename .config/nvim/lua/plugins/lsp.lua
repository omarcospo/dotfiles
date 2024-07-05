return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "LukasPietzschmann/boo.nvim",
      { "pmizio/typescript-tools.nvim", ft = { "typescript" } },
      "nvim-lua/plenary.nvim",
      "MysticalDevil/inlay-hints.nvim",
      "felpafel/inlay-hint.nvim",
      {
        "smjonas/inc-rename.nvim",
        config = function()
          require("inc_rename").setup({})
        end,
      },
      {
        "zeioth/garbage-day.nvim",
        event = "User BaseFile",
        opts = {
          aggressive_mode = false,
          grace_period = (60 * 15),
          wakeup_delay = 3000,
          notifications = false,
          retries = 3,
          timeout = 1000,
        },
      },
    },
    ft = { "python", "go", "typescript", "lua" },
    keys = {
      { "gd", [[<cmd>lua require('boo').boo()<CR>]] },
      { "gr", ":IncRename " },
    },
    init = function()
      local lsp = vim.lsp
      lsp.handlers["$/progress"] = function() end
      lsp.handlers["window/logMessage"] = function() end
      lsp.handlers["window/showMessage"] = function() end
    end,
    config = function()
      local lsp = require("lspconfig")
      require("boo").setup()
      require("inlay-hint").setup()
      require("inlay-hints").setup()
      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_installation = true,
      })
      vim.keymap.set("n", "<leader>lh", ":InlayHintsToggle<CR>")
      vim.keymap.set("i", "<c-s>", function()
        vim.lsp.buf.signature_help()
      end, { buffer = true })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers["signature_help"], {
        border = "rounded",
        close_events = { "CursorMoved", "BufHidden", "InsertCharPre" },
      })
      --- Python
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function()
          vim.opt_local.expandtab = true
          vim.opt_local.shiftwidth = 4
          vim.opt_local.tabstop = 4
          vim.opt_local.softtabstop = 4
          vim.opt_local.foldmethod = "indent"
        end,
      })
      lsp.html.setup({})
      lsp.jedi_language_server.setup({})
      --- GO
      lsp.gopls.setup({
        settings = {
          gopls = {
            gofumpt = true,
            usePlaceholders = true,
            analyses = {
              fieldalignment = false, -- find structs that would use less memory if their fields were sorted
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              rangeVariableTypes = true,
              parameterNames = false,
              constantValues = true,
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              functionTypeParameters = true,
            },
          },
        },
      })
      --- TypeScript
      require("typescript-tools").setup({
        settings = {
          complete_function_calls = false,
          include_completions_with_insert_text = false,
          code_lens = "off",
          disable_member_code_lens = false,
          jsx_close_tag = { enable = false },
          --- Inlay Hints
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      })
      --- Typst
      lsp.typst_lsp.setup({
        settings = {
          exportPdf = "onType",
          format = {
            formatting_options = nil,
            timeout_ms = nil,
          },
        },
      })
      --- LUA
      lsp.lua_ls.setup({})
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = { library = { "luvit-meta/library" } },
    dependencies = "neovim/nvim-lspconfig",
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0,
      })
    end,
  },
  {
    "luckasRanarison/clear-action.nvim",
    event = "LspAttach",
    opts = {
      signs = {
        icons = {
          quickfix = "󰒓 ",
          refactor = " ",
          source = " ",
          combined = " ",
        },
      },
      popup = {
        enable = true,
        border = "rounded",
        hide_cursor = true,
        hide_client = true,
      },
      mappings = {
        code_action = "ga",
        apply_first = "gf",
        quickfix = "gq",
      },
    },
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "gt", "<CMD>Trouble diagnostics toggle filter.buf=0 focus=true<CR>" },
      { "gs", "<CMD>Trouble lsp_references toggle focus=true<CR>" },
      { "<leader>ts", "<CMD>Trouble lsp_document_symbols toggle focus=false win.position=left filter.buf=0<CR>" },
    },
    opts = {
      auto_close = true,
      auto_preview = true,
      auto_refresh = true,
      auto_jump = true,
      focus = true,
      restore = true,
      follow = true,
      indent_guides = false,
      max_items = 200,
      multiline = false,
      warn_no_results = false,
      open_no_results = false,
      icons = {
        indent = { middle = "", last = "", top = "", ws = "" },
      },
    },
    init = function()
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
        },
      })
    end,
  },
}
