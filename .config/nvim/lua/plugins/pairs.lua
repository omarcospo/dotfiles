return {
  "echasnovski/mini.pairs",
  version = false,
  event = "InsertEnter",
  opts = {
    mappings = {
      ["<"] = { action = "open", pair = "<>", neigh_pattern = "\r.", register = { cr = false } },
      [">"] = { action = "close", pair = "<>", register = { cr = false } },
    },
  },
}
