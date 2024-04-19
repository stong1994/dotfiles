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
}
