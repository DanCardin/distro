local function get_position()
  local cursor = vim.api.nvim_win_get_cursor(0)

  local cur = vim.fn.line('.')
  local total = vim.fn.line('$')

  local progress = ""
  if cur == 1 then
    progress = 'Top'
  elseif cur == total then
    progress = 'Bot'
  else
    progress = string.format('%2d%%', math.floor(cur / total * 100))
  end

  return cursor[1] .. ':' .. cursor[2] .. ' @ ' .. progress
end

local function get_mode()
  local raw_mode = vim.api.nvim_get_mode().mode
  local modes = {
    n = { text = " NORMAL ", bg = '#5e71a0' },
    i = { text = " INSERT ", bg = '#78ccc5' },
    c = { text = ' COMMAND ', bg = '#f5c359' },
    v = { text = ' VISUAL ', bg = '#9745be' },
    V = { text = ' V-LINE ', bg = '#9745be' },
    ["\22"] = { text = ' V-BLOCK ', bg = '#9745be' },
    default = { text = raw_mode, bg = '' },
  }
  return modes[raw_mode] or modes['default']
end

return {
  "nvim-lua/popup.nvim",
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzy-native.nvim",
      "debugloop/telescope-undo.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      telescope.setup({
        extensions = {
          fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
          },
        },
        undo = {},
      })
      telescope.load_extension("fzy_native")
      telescope.load_extension("undo")
      telescope.load_extension("notify")
      -- vim.keymap.set("n", "<leader>o", builtin.git_files)
      vim.keymap.set("n", "gt", builtin.treesitter)
      vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
    end,
  },
  {
    "dmtrKovalenko/fff.nvim",
    build = function()
      require("fff.download").download_or_build_binary()
    end,
    keys = {
      {
        "<leader>o",
        function()
          require("fff").find_in_git_root()
        end,
        desc = "Open git file picker",
      },
      {
        "<leader>l",
        function()
          require("fff").find_files()
        end,
        desc = "Open file picker",
      },
    },
  },
  {
    "luukvbaal/statuscol.nvim",
    event = "VeryLazy",
    opts = function()
      local builtin = require("statuscol.builtin")
      return {
        setopt = true,
        segments = {
          {
            sign = { namespace = { "diagnostic/signs" }, maxwidth = 1, auto = false },
            click = "v:lua.ScSa",
          },
          { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
          {
            sign = {
              name = {
                "Dap",
                "neotest",
              },
              maxwidth = 1,
              colwidth = 1,
              auto = false,
            },
            click = "v:lua.ScSa",
          },
          {
            text = { "│" },
            sign = {
              name = { "GitSigns" },
              maxwidth = 1,
              colwidth = 1,
              auto = true,
            },
            click = "v:lua.ScSa",
          },
        },
        ft_ignore = { "help", "vim", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "toggleterm" },
      }
    end,
  },
  {
    [1] = "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      routes = {
        {
          filter = { find = "Pattern not found" },
          opts = { skip = true },
        },
        {
          filter = { kind = { "search_count", "echo" } },
          opts = { skip = true },
        },
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      presets = {
        bottom_search = true,
        long_message_to_split = false,
        inc_rename = true,
        lsp_doc_border = true,
      },
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
      }
    },
  },
  {
    [1] = "rebelot/kanagawa.nvim",
    opts = {
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { bold = true },
      statementStyle = { bold = true },
      typeStyle = {},
      variablebuiltinStyle = { italic = true },
      specialReturn = true,
      specialException = true,
      transparent = false,
    },
  },
  {
    "akinsho/nvim-bufferline.lua",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
        },
      })

      vim.keymap.set("n", "<leader>b", ":BufferLinePick<CR>", { silent = true })
      vim.keymap.set("n", "<leader>,", ":BufferLineCyclePrev<CR>",
        { silent = true })
      vim.keymap.set("n", "<leader>.", ":BufferLineCycleNext<CR>",
        { silent = true })
      vim.keymap.set("n", "<leader><leader>,", ":BufferLineMovePrev<CR>",
        { silent = true })
      vim.keymap.set("n", "<leader><leader>.", ":BufferLineMoveNext<CR>",
        { silent = true })
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "#1e1e1e",
        fps = 30,
        render = "minimal",
        stages = "fade_in_slide_out",
        timeout = 3000,
        top_down = false,
        max_width = 60,
      })
    end,
  },
  {
    "lukas-reineke/virt-column.nvim",
    config = function()
      require("virt-column").setup()
    end,
  },
  { "VidocqH/lsp-lens.nvim" },
  { "brenoprata10/nvim-highlight-colors", opts = {} },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    opts = {
      options = {
        multilines = true,
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    'b0o/incline.nvim',
    dependencies = { "folke/noice.nvim" },
    config = function()
      local noice = require("noice")

      local function get_diagnostic_label(props)
        local icons = {
          Error = "",
          Warn = "",
          Info = "",
          Hint = "",
        }

        local label = {}
        for severity, icon in pairs(icons) do
          local n = #vim.diagnostic.get(props.buf,
            {
              severity = vim
                  .diagnostic.severity
                  [string.upper(severity)]
            })
          if n > 0 then
            local fg = "#" ..
                string.format("%06x",
                  vim.api
                  .nvim_get_hl_by_name(
                    "DiagnosticSign" ..
                    severity,
                    true)
                  ["foreground"])
            table.insert(label,
              {
                icon ..
                " " ..
                n .. " ",
                guifg =
                    fg
              })
          end
        end
        return label
      end
      require('incline').setup({
        hide = {
          cursorline = false,
          focused_win = false,
          only_win = false
        },
        highlight = {
          groups = {
            InclineNormal = {
              default = true,
              group =
              "NormalFloat"
            },
            InclineNormalNC = {
              default = true,
              group =
              "NormalFloat"
            }
          }
        },
        ignore = {
          buftypes = "special",
          filetypes = {},
          floating_wins = true,
          unlisted_buffers = true,
          wintypes = "special"
        },
        render = function(props)
          local bufname = vim.api
              .nvim_buf_get_name(props.buf)
          local filename = vim.fn.fnamemodify(
            bufname, ":t")
          local diagnostics = get_diagnostic_label(
            props)
          local modified = vim.api
              .nvim_get_option_value("modified", {}) and
              "bold,italic" or
              "None"
          local filetype_icon, color = require(
            "nvim-web-devicons").get_icon_color(
            filename)

          local mode = get_mode()

          local buffer = {
            { filetype_icon,                             guifg = color },
            { " " },
            { filename .. '(' .. vim.bo.filetype .. ')', gui = modified },
            { " |" },
            { mode.text,                                 guibg = mode.bg, guifg = 'black' },
            { " | " },
            { get_position(),                            guifg = mode.bg },
          }

          if #diagnostics > 0 then
            table.insert(diagnostics,
              {
                "| ",
                guifg =
                "grey"
              })
          end
          for _, buffer_ in ipairs(buffer) do
            table.insert(diagnostics,
              buffer_)
          end
          return diagnostics
        end,
        window = {
          options = {
            signcolumn = "no",
            wrap = false
          },
          padding = 1,
          placement = {
            horizontal = "right",
            vertical = "bottom"
          },
          overlap = {
            borders = true,
            statusline = true,
          },
        }
      })
    end,
    event = 'VeryLazy',
  },
  {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
      require('blame').setup {}
    end,
    keys = {
      { "<leader>gb", "<cmd>BlameToggle virtual<cr>", desc = "BlameToggle" },
    }
  },
  {
    "bngarren/checkmate.nvim",
    ft = "markdown",
    opts = {
      show_todo_count = true,
      metadata = {
        started = {
          key = "<leader>ts",
          aliases = { "init" },
          style = { fg = "#9fd6d5" },
          get_value = function()
            return tostring(os.date("%m/%d/%y %H:%M"))
          end,
          sort_order = 20,
        },
        priority = {
          style = function(context)
            local value = context.value:lower()
            if value == "high" then
              return { fg = "#ff5555", bold = true }
            elseif value == "medium" then
              return { fg = "#ffb86c" }
            elseif value == "low" then
              return { fg = "#8be9fd" }
            else -- fallback
              return { fg = "#8be9fd" }
            end
          end,
          get_value = function()
            return "medium" -- Default priority
          end,
          choices = function()
            return { "low", "medium", "high" }
          end,
          key = "<leader>tp",
          sort_order = 10,
          jump_to_on_insert = "value",
          select_on_insert = true,
        },
      },
      keys = {
        ["<leader>tt"] = {
          rhs = "<cmd>Checkmate toggle<CR>",
          desc = "Toggle todo item",
          modes = { "n", "v" },
        },
        ["<leader>tc"] = {
          rhs = "<cmd>Checkmate check<CR>",
          desc = "Set todo item as checked (done)",
          modes = { "n", "v" },
        },
        ["<leader>tu"] = {
          rhs = "<cmd>Checkmate uncheck<CR>",
          desc = "Set todo item as unchecked (not done)",
          modes = { "n", "v" },
        },
        ["<leader>t="] = {
          rhs = "<cmd>Checkmate cycle_next<CR>",
          desc = "Cycle todo item(s) to the next state",
          modes = { "n", "v" },
        },
        ["<leader>t-"] = {
          rhs = "<cmd>Checkmate cycle_previous<CR>",
          desc = "Cycle todo item(s) to the previous state",
          modes = { "n", "v" },
        },
        ["<leader>tn"] = {
          rhs = "<cmd>Checkmate create<CR>",
          desc = "Create todo item",
          modes = { "n", "v" },
        },
        ["<leader>td"] = {
          rhs = "<cmd>Checkmate remove<CR>",
          desc = "Remove todo marker (convert to text)",
          modes = { "n", "v" },
        },
        ["<leader>tD"] = {
          rhs = "<cmd>Checkmate remove_all_metadata<CR>",
          desc = "Remove all metadata from a todo item",
          modes = { "n", "v" },
        },
        ["<leader>ta"] = {
          rhs = "<cmd>Checkmate archive<CR>",
          desc = "Archive checked/completed todo items (move to bottom section)",
          modes = { "n" },
        },
        ["<leader>tv"] = {
          rhs = "<cmd>Checkmate metadata select_value<CR>",
          desc = "Update the value of a metadata tag under the cursor",
          modes = { "n" },
        },
        ["<leader>t."] = {
          rhs = "<cmd>Checkmate metadata jump_next<CR>",
          desc = "Move cursor to next metadata tag",
          modes = { "n" },
        },
        ["<leader>t,"] = {
          rhs = "<cmd>Checkmate metadata jump_previous<CR>",
          desc = "Move cursor to previous metadata tag",
          modes = { "n" },
        },
      },
    },
    {
      "Piotr1215/presenterm.nvim",
      build = false, -- Disable rockspec/luarocks build
      opts = {
        on_attach = function(bufnr)
          vim.keymap.set("n", ",", require("presenterm").next_slide, { buffer = bufnr, desc = "Next slide" })
          vim.keymap.set("n", ".", require("presenterm").previous_slide, { buffer = bufnr, desc = "Previous slide" })
        end,
      }, -- Uses all defaults, auto-detects picker
    },
  }
}
