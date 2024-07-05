-- Function to unmap all key mappings starting with the given prefix in specified modes
local function unmap_prefix(prefix)
  local keys = "abcdefghijklmnopqrstuvwxyz1234567890[]ACDEFGHLMNORWX"
  local modes = string.len(prefix) == 1 and { "n", "v" } or { "n", "i", "v" }
  for i = 1, #keys do
    local key = keys:sub(i, i)
    vim.keymap.set(modes, prefix, "<Nop>", { nowait = true })
    vim.keymap.set(modes, prefix .. key, "<Nop>", { nowait = true })
    vim.keymap.set(modes, prefix:upper(), "<Nop>", { nowait = true })
    vim.keymap.set(modes, prefix:upper() .. key, "<Nop>", { nowait = true })
  end
end

unmap_prefix("<C-w>")
unmap_prefix("n")
unmap_prefix("<C-g>")
unmap_prefix("t")
