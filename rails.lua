return {
  {
    "Shopify/ruby-lsp",
    ft = { "ruby", "erb" },
    config = function()
      require("lspconfig").ruby_lsp.setup({})
    end,
  },

  {
    "mfussenegger/nvim-lint",
    ft = { "ruby" },
    config = function()
      require("lint").linters_by_ft = {
        ruby = { "rubocop" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        pattern = "*.rb",
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
  --{
  --"stevearc/conform.nvim",
  --ft = { "ruby" },
  --config = function()
  --require("conform").setup({
  --formatters_by_ft = {
  --ruby = { "rubocop" },
  --},
  --})
  --vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  --pattern = "*.rb",
  --callback = function()
  --require("conform").format({ async = false })
  --end,
  --})
  --end,
  --},

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "olimorris/neotest-rspec",
      "nvim-neotest/nvim-nio",
    },
    ft = { "ruby" },
    config = function()
      require("neotest").setup({
        adapters = { require("neotest-rspec") },
      })
    end,
  },

  { "tpope/vim-rails", ft = { "ruby" } },
  { "tpope/vim-bundler", ft = { "ruby" } },
  { "tpope/vim-rake", ft = { "ruby" } },
  { "tpope/vim-endwise", ft = { "ruby" } },

  {
    "stevearc/oil.nvim",
    config = function()
      local oil = require("oil")
      oil.setup()
      vim.keymap.set("n", "-", oil.toggle_float, {})
    end,
  },
  {
    "mfussenegger/nvim-dap",
    ft = { "ruby" },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ruby",
        callback = function()
          local ok, dap = pcall(require, "dap")
          if not ok then
            return
          end

          dap.adapters.ruby = {
            type = "executable",
            command = "bundle",
            args = { "exec", "readapt", "stdio" },
          }

          dap.configurations.ruby = {
            {
              type = "ruby",
              request = "launch",
              name = "Debug current file",
              program = "${file}",
            },
          }
        end,
      })
    end,
  },
}
