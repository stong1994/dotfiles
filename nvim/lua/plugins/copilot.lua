return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = "copilot.lua",
    opts = {},
    config = function(_, opts)
      local copilot_cmp = require("copilot_cmp")
      copilot_cmp.setup(opts)
      -- attach cmp source whenever copilot attaches
      -- fixes lazy-loading issues with the copilot cmp source
      LazyVim.lsp.on_attach(function(client)
        if client.name == "copilot" then
          copilot_cmp._on_insert_enter({})
        end
      end)
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      proxy = "http://127.0.0.1:7890",
      -- See Configuration section for rest
    },
    lazy = false,
    keys = {
      -- Quick chat with Copilot
      {
        "ccc",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "CopilotChat - Quick chat",
      },
      {
        "cch",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.help_actions())
        end,
        desc = "CopilotChat - Help actions",
      },
      -- Show prompts actions with telescope
      {
        "ccp",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "CopilotChat - Prompt actions",
      },
      {
        "ccp",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        mode = "x",
        desc = "CopilotChat - Prompt actions",
      },
    },
    config = function()
      local select = require("CopilotChat.select")
      local commitCliPrompt =
        -- "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. So, There will be multi messages: title and details. Wrap the tilte and details to a command like `git commit -m {title} -m '- {detail1}' -m '- {detail2}'`. For example: You got title is 'feat: user login' and details are 'Add user login component' and 'Add user register', So the commmand should be `git commit  -m 'feat: user login' -m '- Add user login component' -m '- Add user register'`. Notice: If there are multi details, use '-m' tag for each detail."
        [[Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. So, Your output will be executed directly, so make sure it is executable, and the command's formatter will be `git commit -m '{type}: {title}'`. If the input content is huge, you can add more details with another '-m' tag. The type should follow rules below:
            - docs: Documentation only changes,
            - style:Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc),
            - perf: A code change that improves performance,
            - test: Adding missing tests or correcting existing tests,
            - build: Changes that affect the build system or external dependencies,
            - ci: Changes to our CI configuration files and scripts,
            - chore: "Other changes that don't modify src or test files",
            - revert: Reverts a previous commit,
            - feat: A new feature,
            - fix: A bug fix, 
            - refactor: A code change that neither fixes a bug nor adds a feature,
     ]]

      require("CopilotChat").setup({
        question_header = "## Stong ", -- Header to use for user questions
        answer_header = "## Copilot ", -- Header to use for AI answers
        show_help = false,
        context = "buffers",
        history_path = vim.fn.stdpath("data") .. "/copilotchat_history", -- Default path to stored history
        prompts = {
          Explain = {
            prompt = "/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.",
          },
          Review = {
            prompt = "/COPILOT_REVIEW Review the selected code.",
            callback = function(response, source)
              -- see config.lua for implementation
            end,
          },
          Generate = {
            prompt = "/COPILOT_GENERATE Generate code based on the active selection comment.",
          },
          Fix = {
            prompt = "/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.",
          },
          Optimize = {
            prompt = "/COPILOT_GENERATE Optimize the selected code to improve performance and readablilty.",
          },
          OptimizeDoc = {
            prompt = "/COPILOT_GENERATE Optimize the doc to improve readablilty.",
            selection = select.buffer,
          },
          Docs = {
            prompt = "/COPILOT_GENERATE Please add documentation comment for the selection.",
          },
          Tests = {
            prompt = "/COPILOT_GENERATE Please generate tests for my code.",
          },
          FixDiagnostic = {
            prompt = "Please assist with the following diagnostic issue in file:",
            selection = select.diagnostics,
          },
          Commit = {
            prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
            selection = select.gitdiff,
          },
          CommitStaged = {
            prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
            selection = function(source)
              return select.gitdiff(source, true)
            end,
          },
          CommitCli = {
            prompt = commitCliPrompt,
            selection = select.gitdiff,
          },
          CommitStagedCli = {
            prompt = commitCliPrompt,
            selection = function(source)
              return select.gitdiff(source, true)
            end,
          },
          Translate = {
            prompt = "Translate the selected text to chinese.",
          },
        },
        mappings = {
          complete = {
            detail = "Use @<Tab> or /<Tab> for options.",
            insert = "<Tab>",
          },
          close = {
            normal = "q",
            insert = "<C-c>",
          },
          reset = {
            normal = "<C-r>r",
            insert = "<C-r>r",
          },
          submit_prompt = {
            normal = "<CR>",
            insert = "<C-m>",
          },
          accept_diff = {
            normal = "<C-y>",
            insert = "<C-y>",
          },
          yank_diff = {
            normal = "ccy",
          },
          show_diff = {
            normal = "ccd",
          },
          show_system_prompt = {
            normal = "ccp",
          },
          show_user_selection = {
            normal = "ccs",
          },
        },
      })
    end,
  },
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
      -- Refer to my configuration here https://github.com/jellydn/lazy-nvim-ide/blob/main/lua/plugins/extras/edgy.lua
      right = {
        {
          title = "CopilotChat.nvim", -- Title of the window
          ft = "copilot-chat", -- This is custom file type from CopilotChat.nvim
          size = { width = 0.4 }, -- Width of the window
        },
      },
    },
  },
  {
    "Exafunction/codeium.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
        detect_proxy = true,
        enable_chat = true,
      })
    end,
  },
}
