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
    vim.notify("gofmt + goimports")
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
}
