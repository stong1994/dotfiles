local keymap = require("stong.utils.keymap")

return {
  {
    enabled = false,
    "folke/flash.nvim",
    ---@type Flash.Config
    opts = {
      search = {
        forward = true,
        multi_window = false,
        wrap = false,
        incremental = true,
      },
    },
  },
  -- {
  --   "nvim-telescope/telescope-file-browser.nvim",
  --   dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  -- },
  {
    "echasnovski/mini.hipatterns",
    event = "BufReadPre",
    opts = {
      highlighters = {
        hsl_color = {
          pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
          group = function(_, match)
            local utils = require("solarized-osaka.hsl")
            --- @type string, string, string
            local nh, ns, nl = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
            --- @type number?, number?, number?
            local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
            --- @type string
            local hex_color = utils.hslToHex(h, s, l)
            return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
          end,
        },
      },
    },
  },

  {
    "dinhhuy258/git.nvim",
    event = "BufReadPre",
    opts = {
      keymaps = {
        -- Open blame window
        blame = "<Leader>gb",
        -- Open file/folder in git repository
        browse = "<Leader>go",
      },
    },
  },

  {
    "telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-file-browser.nvim",
    },
    keys = {
      {
        "<leader>fP",
        function()
          require("telescope.builtin").find_files({
            cwd = require("lazy.core.config").options.root,
          })
        end,
        desc = "Find Plugin File",
      },
      -- {
      --   ";f",
      --   function()
      --     local builtin = require("telescope.builtin")
      --     builtin.find_files({
      --       no_ignore = false,
      --       hidden = true,
      --     })
      --   end,
      --   desc = "Lists files in your current working directory, respects .gitignore",
      -- },
      -- {
      --   ";w",
      --   function()
      --     local builtin = require("telescope.builtin")
      --     builtin.grep_string({
      --       use_regex = true,
      --     })
      --   end,
      --   desc = "Search for a string in current file",
      -- },
      -- {
      --   ";r",
      --   function()
      --     local builtin = require("telescope.builtin")
      --     builtin.live_grep({
      --       additional_args = { "--hidden" },
      --       use_regex = true,
      --     })
      --   end,
      --   desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
      -- },
      -- {
      --   ";b",
      --   function()
      --     local builtin = require("telescope.builtin")
      --     builtin.buffers()
      --   end,
      --   desc = "Lists open buffers",
      -- },
      {
        ";t",
        function()
          local builtin = require("telescope.builtin")
          builtin.help_tags()
        end,
        desc = "Lists available help tags and opens a new window with the relevant help info on <cr>",
      },
      {
        ";;",
        function()
          local builtin = require("telescope.builtin")
          builtin.resume()
        end,
        desc = "Resume the previous telescope picker",
      },
      -- {
      --   ";e",
      --   function()
      --     local builtin = require("telescope.builtin")
      --     builtin.diagnostics()
      --   end,
      --   desc = "Lists Diagnostics for all open buffers or a specific buffer",
      -- },
      {
        ";s",
        function()
          local builtin = require("telescope.builtin")
          builtin.treesitter()
        end,
        desc = "Lists Function names, variables, from Treesitter",
      },
      -- {
      --   "gd",
      --   function()
      --     local builtin = require("telescope.builtin")
      --     builtin.lsp_definitions({})
      --   end,
      --   desc = "LSP Goto Defination by telescope",
      -- },
      -- {
      --   "gi",
      --   function()
      --     local builtin = require("telescope.builtin")
      --     builtin.lsp_implementations({})
      --   end,
      --   desc = "LSP Goto Implementations by telescope",
      -- },
      -- {
      --   "gr",
      --   function()
      --     local builtin = require("telescope.builtin")
      --     builtin.lsp_references({
      --       include_declaration = false, -- TODO: not work
      --     })
      --   end,
      --   desc = "Lsp Goto Reference by telescope",
      -- },
      {
        "sf",
        function()
          local telescope = require("telescope")

          local function telescope_buffer_dir()
            return vim.fn.expand("%:p:h")
          end

          telescope.extensions.file_browser.file_browser({
            path = "%:p:h",
            cwd = telescope_buffer_dir(),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = "normal",
            layout_config = { height = 40 },
          })
        end,
        desc = "Open File Browser with the path of the current buffer",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions

      opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          n = {},
        },
      })
      opts.pickers = {
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = {
            preview_cutoff = 9999,
          },
        },
      }
      opts.extensions = {
        file_browser = {
          theme = "dropdown",
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          mappings = {
            -- your custom insert mode mappings
            ["n"] = {
              -- your custom normal mode mappings
              ["N"] = fb_actions.create,
              ["h"] = fb_actions.goto_parent_dir,
              ["/"] = function()
                vim.cmd("startinsert")
              end,
              ["<C-u>"] = function(prompt_bufnr)
                for i = 1, 10 do
                  actions.move_selection_previous(prompt_bufnr)
                end
              end,
              ["<C-d>"] = function(prompt_bufnr)
                for i = 1, 10 do
                  actions.move_selection_next(prompt_bufnr)
                end
              end,
              ["<PageUp>"] = actions.preview_scrolling_up,
              ["<PageDown>"] = actions.preview_scrolling_down,
            },
          },
        },
      }
      telescope.setup(opts)
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")
    end,
  },
  {
    "gnikdroy/projections.nvim",
    version = "pre_release",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    lazy = true,
    config = function()
      require("projections").setup({
        workspaces = { -- Default workspaces to search for
          { "~/Project/Company", { ".git" } }, --        Documents/dev is a workspace. patterns = { ".git" }
          { "~/Project/Personal", { ".git" } }, --        Documents/dev is a workspace. patterns = { ".git" }
          { "~/Project/Github", { ".git" } }, --        Documents/dev is a workspace. patterns = { ".git" }
          "~/.config", --  config project, An empty pattern list indicates that all subdirectories are considered projects
        },
        -- patterns = { ".git", ".svn", ".hg" },      -- Default patterns to use if none were specified. These are NOT regexps.
        -- store_hooks = { pre = nil, post = nil },   -- pre and post hooks for store_session, callable | nil
        -- restore_hooks = { pre = nil, post = nil }, -- pre and post hooks for restore_session, callable | nil
        -- workspaces_file = "path/to/file",          -- Path to workspaces json file
        sessions_directory = "~/cache/nvim/projects", -- Directory where sessions are stored
        ---- Bind <leader>fp to Telescope projections
      })
      require("telescope").load_extension("projections")
      vim.keymap.set("n", ";p", function()
        vim.cmd("Telescope projections")
      end, { desc = "Find Projects" })

      -- Autostore session on VimExit
      local Session = require("projections.session")
      vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
        callback = function()
          Session.store(vim.loop.cwd())
        end,
      })

      -- Switch to project if vim was started in a project dir
      local switcher = require("projections.switcher")
      vim.api.nvim_create_autocmd({ "VimEnter" }, {
        callback = function()
          if vim.fn.argc() == 0 then
            switcher.switch(vim.loop.cwd())
          end
        end,
      })
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
    },
    keys = function()
      local keys = {
        {
          "<leader>H",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Harpoon File",
        },
        {
          "<leader>h",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Quick Menu",
        },
      }

      for i = 1, 5 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon to File " .. i,
        })
      end
      return keys
    end,
  },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      },
    },
  },
  {
    "echasnovski/mini.move",
    opts = {
      mappings = {
        left = "<A-h>",
        right = "<A-l>",
        down = "<A-j>",
        up = "<A-k>",

        line_left = "<A-h>",
        line_right = "<A-l>",
        line_up = "<A-j>",
        line_down = "<A-k>",
      },
    },
  },
  {
    -- optional for icons
    { "nvim-tree/nvim-web-devicons" },

    -- optional for the 'fzf' command
    {
      "junegunn/fzf",
      build = function()
        vim.fn["fzf#install"]()
      end,
    },

    {
      "linrongbin16/fzfx.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons", "junegunn/fzf" },

      -- specify version to avoid break changes
      version = "v5.*",

      config = function()
        require("fzfx").setup({
          users = {
            ls = {
              command = {
                name = "FzfxLs",
                desc = "File Explorer (ls -1)",
              },
              variants = {
                {
                  name = "args",
                  feed = "args",
                  default_provider = "filter_hiddens",
                },
                {
                  name = "hidden_args",
                  feed = "args",
                  default_provider = "include_hiddens",
                },
              },
              providers = {
                filter_hiddens = {
                  key = "ctrl-h",
                  provider = { "ls", "--color=always", "-1" },
                },
                include_hiddens = {
                  key = "ctrl-u",
                  provider = { "ls", "--color=always", "-1a" },
                },
              },
              previewers = {
                filter_hiddens = {
                  previewer = function(line)
                    -- each line is either a folder or a file
                    return vim.fn.isdirectory(line) > 0 and { "ls", "--color=always", "-lha", line } or { "cat", line }
                  end,
                  previewer_type = "command_list",
                },
                include_hiddens = {
                  previewer = function(line)
                    return vim.fn.isdirectory(line) > 0 and { "ls", "--color=always", "-lha", line } or { "cat", line }
                  end,
                  previewer_type = "command_list",
                },
              },
              actions = {
                ["esc"] = function(lines)
                  -- do nothing
                end,
                ["enter"] = function(lines)
                  for _, line in ipairs(lines) do
                    vim.cmd(string.format([[edit %s]], line))
                  end
                end,
              },
              fzf_opts = {
                "--multi",
                { "--prompt", "Ls > " },
              },
            },
          },
        })
        -- files
        keymap.default_map_n(";f", "<cmd>FzfxFiles<cr>", { desc = "Find files" })
        keymap.default_map_x(";f", "<cmd>FzfxFiles visual<cr>", { desc = "Find files" })
        keymap.default_map_n(";wf", "<cmd>FzfxFiles cword<cr>", { desc = "Find files by cursor word" })
        keymap.default_map_n(";yf", "<cmd>FzfxFiles put<cr>", { desc = "Find files by yank text" })
        keymap.default_map_n(";lf", "<cmd>FzfxFiles resume<cr>", { desc = "Find files by resume last" })
        -- buffers
        keymap.default_map_n(";b", "<cmd>FzfxBuffers<cr>", { desc = "Find buffers" })
        -- live grep
        keymap.default_map_n(";r", "<cmd>FzfxLiveGrep<cr>", { desc = "Live grep" })
        keymap.default_map_x(";r", "<cmd>FzfxLiveGrep visual<cr>", { desc = "Live grep" })
        keymap.default_map_n(";wr", "<cmd>FzfxLiveGrep cword<cr>", { desc = "Live grep by cursor word" })
        keymap.default_map_n(";yr", "<cmd>FzfxLiveGrep put<cr>", { desc = "Live grep by yank text" })
        keymap.default_map_n(";lr", "<cmd>FzfxLiveGrep resume<cr>", { desc = "Live grep by resume last" })
        keymap.default_map_n(";br", "<cmd>FzfxBufLiveGrep<cr>", { desc = "Live grep buffers" })
        -- git
        keymap.default_map_n(";gs", "<cmd>FzfxGStatus<cr>", { desc = "Find git changed fields" })
        keymap.default_map_n(";gb", "<cmd>FzfxGBranches<cr>", { desc = "Search git branches" })
        keymap.default_map_n(";gc", "<cmd>FzfxGCommits<cr>", { desc = "Search git commmits" })
        keymap.default_map_n(";gm", "<cmd>FzfxGBlame<cr>", { desc = "Search git blame" })
        -- lsp
        keymap.default_map_n(";e", "<cmd>FzfxLspDiagnostics<cr>", { desc = "Search lsp diagnostics" })
        keymap.default_map_n("gd", "<cmd>FzfxLspDefinitions<cr>", { desc = "Goto lsp definition" })
        keymap.default_map_n("gr", "<cmd>FzfxLspReferences<cr>", { desc = "Goto lsp reference" })
        keymap.default_map_n("gi", "<cmd>FzfxLspImplementations<cr>", { desc = "Goto lsp Implementations" })
        keymap.default_map_n("gt", "<cmd>FzfxLspTypeDefinitions<cr>", { desc = "Goto lsp type definition" })
        keymap.default_map_n("gci", "<cmd>FzfxLspIncomingCalls<cr>", { desc = "Goto lsp incoming calls" })
        keymap.default_map_n("gco", "<cmd>FzfxLspOutgoingCalls<cr>", { desc = "Goto lsp outgoing calls" })
        -- vim command
        keymap.default_map_n(";c", "<cmd>FzfxCommands<cr>", { desc = "Search vim commands" })
        -- key maps
        keymap.default_map_n(";km", "<cmd>FzfxKeyMaps<cr>", { desc = "Search vim keymaps" })
        -- vim marks
        keymap.default_map_n(";mk", "<cmd>FzfxMarks<cr>", { desc = "Search vim marks" })
        -- file explorer
        keymap.default_map_n(";p", "<cmd>FzfxFileExplorer<cr>", { desc = "File explorer" })
      end,
    },
  },
}
