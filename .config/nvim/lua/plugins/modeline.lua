return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "BufReadPost",
    config = function()
      local lualine = require("lualine")

      local colors = {
        bg = "#18191A",
        fg = "#bbc2cf",
        yellow = "#ECBE7B",
        cyan = "#008080",
        green = "#42be65",
        orange = "#FF6F00",
        violet = "#be95ff",
      }

      -- Config
      local config = {
        options = {
          -- Disable sections and component separators
          component_separators = "",
          section_separators = "",
          theme = {
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg } },
          },
        },
        sections = {},
        inactive_sections = {},
        winbar = {
          -- these are to remove the defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
        inactive_winbar = {
          -- these are to remove the defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
      }

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand("%:p:h")
          local gitdir = vim.fn.finddir(".git", filepath .. ";")
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }

      -- Inserts a component in lualine_c at left section
      local function ins_left(component)
        table.insert(config.winbar.lualine_c, component)
        table.insert(config.inactive_winbar.lualine_c, component)
      end

      -- Inserts a component in lualine_x at right section
      local function ins_right(component)
        table.insert(config.winbar.lualine_x, component)
        table.insert(config.inactive_winbar.lualine_x, component)
      end

      ins_left({
        function()
          return " "
        end,
        padding = { left = 0, right = 0 },
      })

      ins_left({
        "filename",
        cond = conditions.buffer_not_empty,
        color = { fg = colors.violet },
        symbols = {
          modified = "",
          readonly = "-",
          unnamed = "[No Name]",
          newfile = "[New]",
        },
      })

      -- Insert mid section.
      ins_left({
        function()
          return "%="
        end,
      })

      ins_right({
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " " },
        diagnostics_color = {
          color_error = { fg = colors.violet },
          color_warn = { fg = colors.yellow },
          color_info = { fg = colors.cyan },
        },
      })

      ins_right({
        "diff",
        -- Is it me or the symbol for modified us really weird
        symbols = { added = " ", modified = "󰝤 ", removed = " " },
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.orange },
          removed = { fg = colors.violet },
        },
        cond = conditions.hide_in_width,
      })

      lualine.setup(config)
    end,
  },
}
