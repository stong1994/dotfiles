-- consider another later: https://github.com/echasnovski/mini.nvim/blob/11920227ff26fb047d3f39bb666e9cdec523a190/lua/mini/move.lua
require("stong.move").setup({
  mappings = {
    left = "<A-left>",
    right = "<A-right>",
    down = "<A-down>",
    up = "<A-up>",

    line_left = "<A-left>",
    line_right = "<A-rigt>",
    line_up = "<A-up>",
    line_down = "<A-down>",
  },
})
-- {
return {
  {
    "terryma/vim-expand-region",
  },
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    keys = {
      {
        "E",
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "W",
        "<cmd>lua require('spider').motion('w')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "B",
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { "n", "o", "x" },
      },
    },
  },
  {
    "tpope/vim-eunuch",
    lazy = true,
  },
  {
    "folke/flash.nvim",
    keys = {
      -- disable the default flash keymap
      { "s", mode = { "n", "x", "o" }, false },
    },
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
  },
}
