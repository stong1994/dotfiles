-- return {
--   "fatih/vim-go",
--   config = function()
--     vim.g.go_term_mode = "split"
--     vim.g.go_term_enabled = 1
--   end,
-- }-- Run gofmt + goimports on save

local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require("go.format").goimports()
  end,
  group = format_sync_grp,
})
return {
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      vim.g.go_term_mode = "split"
      vim.g.go_term_enabled = 1
      require("go").setup({
        luasnip = true,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    opts = {
      verbose = true,
      gofmt = "golines",
      goimport = "golines",
      max_line_len = 128,
    },
  },
}
