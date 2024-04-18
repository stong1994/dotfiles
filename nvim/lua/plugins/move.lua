-- consider another later: https://github.com/echasnovski/mini.nvim/blob/11920227ff26fb047d3f39bb666e9cdec523a190/lua/mini/move.lua
require("stong.move").setup({
  mappings = {
    left = "<A-left>",
    right = "<A-right>",
    down = "<A-down>",
    up = "<A-up>",

    line_left = "<A-left>",
    line_right = "<A-right>",
    line_up = "<A-up>",
    line_down = "<A-down>",
  },
})
-- {
return {
  --   "fedepujol/move.nvim",
  --   config = function()
  --     require("move").setup({
  --       line = {
  --         enable = true, -- Enables line movement
  --         indent = true, -- Toggles indentation
  --       },
  --       block = {
  --         enable = true, -- Enables block movement
  --         indent = true, -- Toggles indentation
  --       },
  --       word = {
  --         enable = true, -- Enables word movement
  --       },
  --       char = {
  --         enable = false, -- Enables char movement
  --       },
  --     })
  --     vim.keymap.set("n", "<A-j>", ":MoveLine(1)<CR>", opts)
  --     vim.keymap.set("n", "<A-k>", ":MoveLine(-1)<CR>", opts)
  --     vim.keymap.set("n", "<A-h>", ":MoveHChar(-1)<CR>", opts)
  --     vim.keymap.set("n", "<A-l>", ":MoveHChar(1)<CR>", opts)
  --     vim.keymap.set("n", "<leader>wf", ":MoveWord(1)<CR>", opts)
  --     vim.keymap.set("n", "<leader>wb", ":MoveWord(-1)<CR>", opts)
  --
  --     -- Visual-mode commands
  --     vim.keymap.set("v", "<A-j>", ":MoveBlock(1)<CR>", opts)
  --     vim.keymap.set("v", "<A-k>", ":MoveBlock(-1)<CR>", opts)
  --     vim.keymap.set("v", "<A-h>", ":MoveHBlock(-1)<CR>", opts)
  --     vim.keymap.set("v", "<A-l>", ":MoveHBlock(1)<CR>", opts)
  --   end,
  -- },
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
}
