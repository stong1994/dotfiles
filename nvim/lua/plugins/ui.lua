return {
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
  },
  -- notice ui
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No infomation available",
        },
        opts = { skip = true },
      })
      opts.presets.lsp_doc_border = true
    end,
  },
  -- update notify time
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 10000,
    },
  },
  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "solarized_dark",
      },
    },
  },
  -- filename
  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modifiable then
            filename = "[+]" .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    keys = {
      {
        "<Tab>",
        "<Cmd>BufferLineCycleNext<CR>",
        desc = "Next tab",
      },
      {
        "<S-Tab>",
        "<Cmd>VufferLineCyclePrev<CR>",
        desc = "Prv tab",
      },
    },
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },
  -- animations
  -- {
  --   "echasnovski/mini.animate",
  --   event = "VeryLazy",
  --   opts = function(_, opts)
  --     opts.scroll = {
  --       enable = false,
  --     }
  --   end,
  -- },
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
}
