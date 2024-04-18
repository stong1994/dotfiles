return {
  {
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      local hop = require("hop")
      local directions = require("hop.hint").HintDirection
      hop.setup({ keys = "etovxqpdygfblzhckisuran" })
      -- vim.keymap.set("n", "<leader>sfc", function()
      --   hop.hint_char1({ current_line_only = true, hint_offset = -1 })
      -- end, { remap = true, desc = "Tag chart in the current line" })
      vim.keymap.set("n", "<leader>sf", function()
        hop.hint_words({ multi_windows = true, current_line_only = false })
      end, { remap = true, desc = "Tag all words in all windows" })
    end,
  },
}
