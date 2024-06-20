-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocms that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Trun off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- Fix conceallevel for json file
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.wo.spell = false
    vim.wo.conceallevel = 0
  end,
})

vim.api.nvim_create_autocmd({ "TermOpen", "WinEnter" }, {
  callback = function()
    if vim.opt.buftype:get() == "terminal" then
      vim.cmd("set nonu")
      vim.cmd("set norelativenumber")
      vim.cmd("startinsert")
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "copilot-*",
  callback = function()
    vim.opt_local.relativenumber = true

    -- ccl to print last response
    vim.keymap.set("n", "ccl", function()
      print(require("CopilotChat").response())
    end, { buffer = true, remap = true })
  end,
})

-- use confom to autoformat
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.dart",
--   callback = function(e)
--     vim.lsp.buf.format({ bufnr = e.buf })
--   end,
-- })
