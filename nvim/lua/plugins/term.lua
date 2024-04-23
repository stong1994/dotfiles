return {
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    version = "*",
    config = function()
      require("toggleterm").setup({})
    end,
  },
}
