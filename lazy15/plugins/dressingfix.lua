return {
  {
    "stevearc/dressing.nvim",
    lazy = false,
    config = function()
      require("dressing").setup({
        input = { enabled = true },
        select = { enabled = true },
      })
    end,
  },
}
