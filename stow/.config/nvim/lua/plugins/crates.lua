return {
  "saecki/crates.nvim",
  tag = "stable",
  event = { "BufRead Cargo.toml" },
  config = function(_, opts)
    require("crates").setup(opts)
  end,
}
