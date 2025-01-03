local mylsp = function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  -- vim.keymap.set("n", "gr", function()
  --   vim.lsp.buf.references()
  -- end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Reference" }))
  vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
  end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Definition" }))
  vim.keymap.set("n", "gk", function()
    vim.lsp.buf.hover()
  end, vim.tbl_deep_extend("force", opts, { desc = "LSP Hover" }))
  -- vim.keymap.set("n", "<leader>vws", function()
  --   vim.lsp.buf.workspace_symbol()
  -- end, vim.tbl_deep_extend("force", opts, { desc = "LSP Workspace Symbol" }))
  -- vim.keymap.set("n", "<leader>vd", function()
  --   vim.diagnostic.setloclist()
  -- end, vim.tbl_deep_extend("force", opts, { desc = "LSP Show Diagnostics" }))
  -- vim.keymap.set("n", "[d", function()
  --   vim.diagnostic.goto_next()
  -- end, vim.tbl_deep_extend("force", opts, { desc = "Next Diagnostic" }))
  -- vim.keymap.set("n", "]d", function()
  --   vim.diagnostic.goto_prev()
  -- end, vim.tbl_deep_extend("force", opts, { desc = "Previous Diagnostic" }))
  vim.keymap.set("n", "vca", function()
    vim.lsp.buf.code_action()
  end, vim.tbl_deep_extend("force", opts, { desc = "LSP Code Action" }))
  -- vim.keymap.set("n", "<leader>vrr", function()
  --   vim.lsp.buf.references()
  -- end, vim.tbl_deep_extend("force", opts, { desc = "LSP References" }))
  vim.keymap.set("n", "vrn", function()
    vim.lsp.buf.rename()
  end, vim.tbl_deep_extend("force", opts, { desc = "LSP Rename" }))
  vim.keymap.set("i", "<C-h>", function()
    vim.lsp.buf.signature_help()
  end, vim.tbl_deep_extend("force", opts, { desc = "LSP Signature Help" }))
end
return {
  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  -- {
  --   "L3MON4D3/LuaSnip",
  --   keys = function()
  --     return {}
  --   end,
  -- },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    opts = function(_, opts)
      table.insert(opts.servers.vtsls.filetypes, "vue")
      LazyVim.extend(opts.servers.vtsls, "settings.vtsls.tsserver.globalPlugins", {
        {
          name = "@vue/typescript-plugin",
          location = LazyVim.get_pkg_path("vue-language-server", "/node_modules/@vue/language-server"),
          languages = { "vue" },
          configNamespace = "typescript",
          enableForWorkspaceTypeScriptVersions = true,
        },
      })

      opts.capabilities.workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      }
      opts.servers.volar = {
        init_options = {
          vue = {
            hybridMode = true,
          },
        },
        vtsls = {},
      }
    end,
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        -- config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        -- lspconfig[server].setup(config or {})
      end
    end,
  },
  -- then: setup supertab in cmp
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     "hrsh7th/cmp-emoji",
  --     "onsails/lspkind.nvim",
  --   },
  --   config = function()
  --     local cmp = require("cmp")
  --     local cmp_action = require("lsp-zero").cmp_action()
  --     local cmp_select = { behavior = cmp.SelectBehavior.Select }
  --     local lspkind = require("lspkind")
  --     local has_words = require("stong.utils.hasword")
  --
  --     cmp.setup({
  --       snippet = {
  --         -- REQUIRED - you must specify a snippet engine
  --         expand = function(args)
  --           -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
  --           require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
  --           -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
  --           -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
  --           -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
  --         end,
  --       },
  --       window = {
  --         completion = cmp.config.window.bordered(),
  --         documentation = cmp.config.window.bordered(),
  --         cmp.scroll_docs,
  --       },
  --       mapping = cmp.mapping.preset.insert({
  --         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  --         ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --         ["<C-Space>"] = cmp.mapping.complete(),
  --         ["<C-e>"] = cmp.mapping.abort(),
  --         ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --         ["<C-u>"] = cmp.mapping.select_prev_item(cmp_select),
  --         ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
  --         -- ["<C-f>"] = cmp_action.luasnip_jump_forward(),
  --         -- ["<C-b>"] = cmp_action.luasnip_jump_backward(),
  --         -- ["<Tab>"] = cmp_action.luasnip_supertab(),
  --         ["<Tab>"] = vim.schedule_wrap(function(fallback)
  --           if cmp.visible() and has_words.before() then
  --             cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
  --           else
  --             fallback()
  --           end
  --         end),
  --         ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
  --       }),
  --       sources = cmp.config.sources({
  --         -- { name = "codeium" },
  --         -- Copilot Source
  --         { name = "copilot", group_index = 2 },
  --         { name = "nvim_lsp" },
  --         -- { name = "vsnip" }, -- For vsnip users.
  --         { name = "luasnip" }, -- For luasnip users.
  --         -- { name = 'ultisnips' }, -- For ultisnips users.
  --         -- { name = 'snippy' }, -- For snippy users.
  --         { name = "buffer", keyword_length = 3 },
  --         { name = "path" },
  --         -- }, {
  --         --   { name = "buffer" },
  --       }),
  --       formatting = {
  --         format = lspkind.cmp_format({
  --           mode = "symbol",
  --           max_width = 50,
  --           ellipsis_char = "...",
  --           symbol_map = {
  --             Copilot = "",
  --             Codeium = "󰘦 ",
  --           },
  --         }),
  --       },
  --     })
  --
  --     -- Set configuration for specific filetype.
  --     cmp.setup.filetype("gitcommit", {
  --       sources = cmp.config.sources({
  --         { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  --       }, {
  --         { name = "buffer" },
  --       }),
  --     })
  --
  --     -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  --     -- cmp.setup.cmdline({ "/", "?" }, {
  --     --   mapping = cmp.mapping.preset.cmdline(),
  --     --   sources = {
  --     --     { name = "buffer" },
  --     --   },
  --     -- })
  --     --
  --     -- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  --     -- cmp.setup.cmdline(":", {
  --     --   mapping = cmp.mapping.preset.cmdline({
  --     --     ["<CR>"] = {
  --     --       c = cmp.mapping.confirm({ select = false }),
  --     --     },
  --     --   }),
  --     --   sources = cmp.config.sources({
  --     --     { name = "path" },
  --     --   }, {
  --     --     { name = "cmdline" },
  --     --   }),
  --     --   matching = { disallow_symbol_nonprefix_matching = false },
  --     -- })
  --   end,
  -- },
  {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = "rafamadriz/friendly-snippets",

    -- use a release tag to download pre-built binaries
    version = "*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = {
        preset = "enter",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-n>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
    opts_extend = { "sources.default" },
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      { -- Optional
        "williamboman/mason.nvim",
        build = function()
          pcall(vim.cmd, "MasonUpdate")
        end,
      },
      { "williamboman/mason-lspconfig.nvim" }, -- Optional

      -- Autocompletion
      -- { "hrshth/nvim-cmp" }, -- Required
      -- { "hrsh7th/cmp-nvim-lsp" }, -- Required
      -- { "L3MON4D3/LuaSnip" }, - Required
      { "rafamadriz/friendly-snippets" },
      -- { "hrsh7th/cmp-buffer" },
      -- { "hrsh7th/cmp-path" },
      -- { "hrsh7th/cmp-cmdline" },
      -- { "saadparwaiz1/cmp_luasnip" },
      -- { "telescope.nvim" },
    },

    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a keymap
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = { "gd", false }
      keys[#keys + 1] = { "gr", false }
    end,

    config = function()
      local lsp = require("lsp-zero")
      -- local telescope_builtin = require("telescope.builtin")
      -- vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { link = "DiagnosticUnnecessary" })
      lsp.on_attach(mylsp)

      require("mason").setup({})
      require("mason-lspconfig").setup({
        automatic_installation = false,
        ensure_installed = {
          "ts_ls",
          "eslint",
          -- "rust_analyzer", can't set rust_analyzer in mason-lspconfig as "mrcjkb/rustaceanvim" has did it
          -- "kotlin_language_server",
          "jdtls",
          "lua_ls",
          "jsonls",
          "html",
          "elixirls",
          "tailwindcss",
          "tflint",
          "pylsp",
          "dockerls",
          -- "bashls",
          "marksman",
          "solargraph",
          "golangci_lint_ls",
          "gopls",
          "vuels",
          -- "cucumber_language_server",
        },
        handlers = {
          lsp.default_setup,
          lua_ls = function()
            local lua_opts = lsp.nvim_lua_ls()
            lua_opts.on_init = function(client)
              local path = client.workspace_folders[1].name
              if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
                return
              end
              client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                runtime = {
                  version = "LuaJIT",
                },
                workspace = {
                  checkThirdParty = false,
                  library = {
                    vim.env.VIMRUNTIME,
                  },
                },
              })
            end
            lua_opts.settings = {
              Lua = {
                hint = {
                  enable = true,
                  arrayIndex = "Enable",
                  setType = true,
                },
              },
            }
            require("lspconfig").lua_ls.setup(lua_opts)
          end,
          gopls = function()
            require("lspconfig").gopls.setup({
              settings = {
                gopls = {
                  analyses = {
                    unusedparams = true,
                  },
                  staticcheck = true,
                  codelenses = {
                    generate = true, -- Enable/disable the `generate` codelens.
                    gc_details = true, -- Enable/disable the `gc_details` codelens.
                    regenerate_cgo = true, -- Enable/disable the `regenerate_cgo` codelens.
                    tidy = true, -- Enable/disable the `tidy` codelens.
                    upgrade_dependency = true, -- Enable/disable the `upgrade_dependency` codelens.
                    vendor = true, -- Enable/disable the `vendor` codelens.
                  },
                  ["ui.inlayhint.hints"] = {
                    compositeLiteralFields = true,
                    constantValues = true,
                    parameterNames = true,
                  },
                },
              },
            })
          end,
        },
      })
    end,
  },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true, -- or `opts = {}`
    lazy = true,
  },

  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = function()
      require("flutter-tools").setup({
        lsp = {
          color = {
            enabled = true,
            on_attach = mylsp,
          },
        },
      })
    end,
  },

  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        luasnip = true,
        verbose = true,
        gofmt = "golines",
        goimports = "golines",
        max_line_len = 128,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    lazy = false, -- This plugin is already lazy
    dependencies = {
      "VonHeikemen/lsp-zero.nvim",
    },
    config = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {
          hover_actions = {
            replace_builtin_hover = true,
          },
        },
        -- LSP configuration
        server = {
          on_attach = mylsp,
          default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
              check = {
                command = "clippy",
              },
            },
          },
        },
        -- DAP configuration
        dap = {},
      }
      vim.keymap.set("n", "K", "10k") -- reset 'K' , it can't remove keymap like lsp-zero
    end,
  },
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    keys = {
      {
        "vcf",
        function()
          require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    init = function()
      -- Install the conform formatter on VeryLazy
      LazyVim.on_very_lazy(function()
        LazyVim.format.register({
          name = "conform.nvim",
          priority = 100,
          primary = true,
          format = function(buf)
            local opts = LazyVim.opts("conform.nvim")
            require("conform").format(LazyVim.merge({}, opts.format, { bufnr = buf }))
          end,
          sources = function(buf)
            local ret = require("conform").list_formatters(buf)
            ---@param v conform.FormatterInfo
            return vim.tbl_map(function(v)
              return v.name
            end, ret)
          end,
        })
      end)
    end,
    opts = function()
      local plugin = require("lazy.core.config").plugins["conform.nvim"]
      local opts = {
        -- LazyVim will use these options when formatting with the conform.nvim formatter
        format = {
          timeout_ms = 3000,
          async = false, -- not recommended to change
          quiet = false, -- not recommended to change
          lsp_format = "fallback", -- not recommended to change
        },
        -- -@type table<string, conform.FormatterUnit[]>
        formatters_by_ft = {
          lua = { "stylua" },
          fish = { "fish_indent" },
          -- Conform will run multiple formatters sequentially
          go = { "golines", "gofmt" },
          -- Use a sub-list to run only the first available formatter
          javascript = { { "prettierd", "prettier" } },
          -- You can use a function here to determine the formatters dynamically
          -- python = { "ruff" },
          python = function(bufnr)
            if require("conform").get_formatter_info("ruff_format", bufnr).available then
              return { "ruff_format" }
            else
              return { "isort", "black" }
            end
          end,
          rust = { "rustfmt" },
          sql = { "sqlfmt" },
          -- Use the "*" filetype to run formatters on all filetypes.
          ["*"] = { "codespell" },
          -- Use the "_" filetype to run formatters on filetypes that don't
          -- have other formatters configured.
          ["_"] = { "trim_whitespace" },
          sh = { "shfmt" },
        },
        -- The options you set here will be merged with the builtin formatters.
        -- You can also define any custom formatters here.
        ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
        formatters = {
          injected = { options = { ignore_errors = true } },
          -- # Example of using dprint only when a dprint.json file is present
          -- dprint = {
          --   condition = function(ctx)
          --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
          --   end,
          -- },
          --
          -- # Example of using shfmt with extra args
          -- shfmt = {
          --   prepend_args = { "-i", "2", "-ci" },
          -- },
        },
      }
      return opts
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
}
