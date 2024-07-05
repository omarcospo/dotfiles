function Big_file(bufnr)
  if bufnr == nil then
    bufnr = 0
  end
  local filesize = vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr))
  local nlines = vim.api.nvim_buf_line_count(bufnr)
  local is_big_file = (filesize > vim.g.big_file.size) or (nlines > vim.g.big_file.lines)
  return is_big_file
end
