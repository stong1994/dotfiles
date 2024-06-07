return {
  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
      },
    },
    config = function()
      require("lspconfig").dartls.setup({
        cmd = { "dart", "language-server", "--protocol=lsp" },
      })
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local cmp_action = require("lsp-zero").cmp_action()
      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      local lspkind = require("lspkind")
      local has_words = require("stong.utils.hasword")

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
          cmp.scroll_docs,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-u>"] = cmp.mapping.select_prev_item(cmp_select),
          ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
          -- ["<C-f>"] = cmp_action.luasnip_jump_forward(),
          -- ["<C-b>"] = cmp_action.luasnip_jump_backward(),
          -- ["<Tab>"] = cmp_action.luasnip_supertab(),
          ["<Tab>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words.before() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end),
          ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
        }),
        sources = cmp.config.sources({
          { name = "codeium" },
          -- Copilot Source
          { name = "copilot", group_index = 2 },
          { name = "nvim_lsp" },
          -- { name = "vsnip" }, -- For vsnip users.
          { name = "luasnip" }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
          { name = "buffer", keyword_length = 3 },
          { name = "path" },
          -- }, {
          --   { name = "buffer" },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol",
            max_width = 50,
            ellipsis_char = "...",
            symbol_map = {
              Copilot = "",
              Codeium = "󰘦 ",
            },
          }),
        },
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
          { name = "buffer" },
        }),
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline({
          ["<CR>"] = {
            c = cmp.mapping.confirm({ select = false }),
          },
        }),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
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
      { "hrsh7th/nvim-cmp" }, -- Required
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "L3MON4D3/LuaSnip" }, -- Required
      { "rafamadriz/friendly-snippets" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
      { "saadparwaiz1/cmp_luasnip" },
      { "telescope.nvim" },
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
      -- lsp.setup_servers({ "dartls", force = true })

      lsp.on_attach(function(client, bufnr)
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
        -- vim.keymap.set("n", "<leader>vca", function()
        --   vim.lsp.buf.code_action()
        -- end, vim.tbl_deep_extend("force", opts, { desc = "LSP Code Action" }))
        -- vim.keymap.set("n", "<leader>vrr", function()
        --   vim.lsp.buf.references()
        -- end, vim.tbl_deep_extend("force", opts, { desc = "LSP References" }))
        vim.keymap.set("n", "<leader>vrn", function()
          vim.lsp.buf.rename()
        end, vim.tbl_deep_extend("force", opts, { desc = "LSP Rename" }))
        vim.keymap.set("i", "<C-h>", function()
          vim.lsp.buf.signature_help()
        end, vim.tbl_deep_extend("force", opts, { desc = "LSP Signature Help" }))
      end)

      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = {
          "tsserver",
          "eslint",
          -- "rust_analyzer",
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
}
