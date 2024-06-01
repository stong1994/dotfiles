local M = {}

M.convert = function(mapping)
  if not (vim.g.neovide or vim.g.neovim_gui) then
    -- subsitute <D-letter> with <M-s>letter
    mapping = string.gsub(mapping, "<D%-(.)>", "<M-s>%1")
  end
  return mapping
end

M.map = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, M.convert(lhs), rhs, opts)
end

M.default_map = function(mode, lhs, rhs, opts)
  M.map(mode, lhs, rhs, vim.tbl_deep_extend("force", { noremap = true, silent = true }, opts or {}))
end

M.default_map_n = function(lhs, rhs, opts)
  M.default_map("n", lhs, rhs, opts)
end

M.default_map_x = function(lhs, rhs, opts)
  M.default_map("x", lhs, rhs, opts)
end

M.default_map_nx = function(lhs, rhs, opts)
  M.default_map({ "n", "x" }, lhs, rhs, opts)
end

return M
