return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
      -- local highlight = {
      --   "RainbowRed",
      --   "RainbowYellow",
      --   "RainbowBlue",
      --   "RainbowOrange",
      --   "RainbowGreen",
      --   "RainbowViolet",
      --   "RainbowCyan",
      -- }
      --
      -- local hooks = require("ibl.hooks")
      -- -- create the highlight groups in the highlight setup hook, so they are reset
      -- -- every time the colorscheme changes
      -- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      --   vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      --   vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      --   vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      --   vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      --   vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      --   vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      --   vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      -- end)
      --
      -- require("ibl").setup({ indent = { highlight = highlight } })
      require("ibl").setup()
    end,
  },
  {
    "dstein64/vim-startuptime",
  },
  -- color preview
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  -- color schema
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
      }
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1001,
    opts = {},
    config = function()
      require("tokyonight").setup({
        style = "moon",
        -- disable italic for functions
        styles = {
          functions = {},
        },
        on_highlights = function(highlights, colors)
          highlights.DiagnosticUnnecessary = { fg = colors.orange }
        end,
      })
    end,
  },
  -- notice ui
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
      })
    end,
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No infomation available",
        },
        opts = { skip = true }, -- no show "No infomation available"
      })
      opts.presets.lsp_doc_border = true
      opts.timeout = 10000 -- not works
    end,
  },
  -- update notify time
  -- {
  --   "rcarriga/nvim-notify",
  --   opts = {
  --     timeout = 3000,
  --   },
  --   config = function()
  --     require("notify").setup({
  --       timeout = 3000,
  --     })
  --   end,
  -- },
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      -- table.insert(opts.sections.lualine_x, 2, LazyVim.lualine.cmp_source("codeium"))

      opts.options.theme = "solarized_dark"
    end,
    -- opts = {
    --   options = {
    --     theme = "solarized_dark",
    --   },
    -- },
  },
  -- hightlight with lsp
  {
    "nvim-treesitter/nvim-treesitter-refactor",
    config = function()
      require("nvim-treesitter.configs").setup({
        refactor = {
          highlight_definitions = {
            enable = true,
            -- Set to false if you have an `updatetime` of ~100.
            clear_on_cursor_move = true,
          },
          highlight_current_scope = { enable = true },
        },
      })
    end,
  },
  -- filename
  -- use this when bufferline.mode = tabs
  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      local devicons = require("nvim-web-devicons")
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
            CursorLineNr = { guifg = colors.base4, guibg = colors.orange },
            LineNr = { guifg = colors.base1, guibg = colors.base04 },
            lCursor = { guifg = colors.blue500, guibg = colors.yellow300 },
            Search = { guifg = colors.blue500, guibg = colors.yellow300 },
            WinSeparator = { guifg = colors.green, guibg = colors.base04 },
            Folded = { guibg = colors.violet500 },
            CursorLineFolded = { guibg = colors.violet300 },
            DiagnosticSignError = { guifg = colors.magenta900 },
            TSCurrentScope = { guibg = colors.base02 },
            TSDefinitionUsage = { guibg = colors.orange },
            TSDefinition = { guibg = colors.magenta },
            LspInlayHint = { guifg = "#9DA9A0" },
            EndOfBuffer = { guifg = "#9DA9A0" },
            LineNrAbove = { guifg = colors.base1 },
            LineNrBelow = { guifg = colors.magenta700 },
            -- Normal = { guifg = colors.base2 },
            -- CursorLine = { guifg = colors.magenta },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        -- hide = {
        --   cursorline = true,
        -- },
        -- to avoid render not too often, see https://github.com/b0o/incline.nvim/issues/69
        debounce_threshold = {
          falling = 75,
          rising = 75,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)

          local function get_git_diff()
            local icons = { removed = "", changed = "", added = "" }
            local signs = vim.b[props.buf].gitsigns_status_dict
            local labels = {}
            if signs == nil then
              return labels
            end
            for name, icon in pairs(icons) do
              if tonumber(signs[name]) and signs[name] > 0 then
                table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
              end
            end
            if #labels > 0 then
              table.insert(labels, { "┊ " })
            end
            return labels
          end

          local function get_diagnostic_label()
            local icons = { error = "", warn = "", info = "", hint = "" }
            local label = {}

            for severity, icon in pairs(icons) do
              local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
              if n > 0 then
                table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
              end
            end
            if #label > 0 then
              table.insert(label, { "┊ " })
            end
            return label
          end

          return {
            { get_diagnostic_label() },
            { get_git_diff() },
            { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
            { filename .. " ", gui = vim.bo[props.buf].modified and "bold,italic" or "bold" },
            -- { "┊  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" }, no need to display the window num
          }
        end,
        --   render = function(props)
        --     local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        --     if vim.bo[props.buf].modified then
        --       filename = "[+]" .. filename
        --     end
        --
        --     local icon, color = require("nvim-web-devicons").get_icon_color(filename)
        --     return { { icon, guifg = color }, { " " }, { filename } }
        --   end,
      })
    end,
  },
  -- statusline
  -- {
  --   "beauwilliams/statusline.lua",
  --   config = function()
  --     vim.opt.hidden = true
  --     local statusline = require("statusline")
  --     statusline.statusline_init()
  --     statusline.tabline = true
  --     statusline.lsp_diagnostics = true
  --   end,
  -- },
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        mode = "tabs",
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
    lazy = true,
  },
  -- symbols outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    opts = {
      -- add your options that should be passed to the setup() function here
      position = "right",
    },
  },
  -- undo logs
  {
    "mbbill/undotree",
    config = function() -- This function runs when undotree is loaded
      -- vim.g.undotree_UndoDir = "~/.undoDir/" -- Set variable
      vim.opt.undodir = (os.getenv("HOME") or os.getenv("UserProfile")) .. "/.vim/undodir"
      vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle, { desc = "UndotreeToggle" })
      -- below is equal to the contents of the function is the equivelant of having this in  .vimrc
      -- let g:undotree_UndoDir = "~/.undoDir"
      -- noremap <leader>u :UndoTreeToggle
    end,
  },
  -- browser file system
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            ".git",
            ".gitignore",
            ".DS_Store",
            -- 'thumbs.db',
          },
          never_show = {},
        },
      },
    },
    -- config = function()
    --   require("neo-tree").setup({
    --     window = {
    --       mappings = {
    --         ["<leader>P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
    --       },
    --     },
    --   })
    -- end,
  },
  {
    "NStefan002/screenkey.nvim",
    cmd = "Screenkey",
    version = "*",
    config = true,
  },
}
