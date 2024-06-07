return {
  -- { "dart-lang/dart-vim-plugin" },
  -- { "natebosch/vim-lsc" },
  -- { "natebosch/vim-lsc-dart" },
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = true,
  },
}
