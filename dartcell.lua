return {
  -- Configuração do Language Server do Dart (para Termux)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        dartls = {
          -- O comando padrão não funciona no Termux.
          -- Precisamos especificar o caminho exato para o snapshot do servidor.
          cmd = {
            "dart",
            vim.fn.expand("$PREFIX") .. "/libexec/dart/bin/snapshots/analysis_server.dart.snapshot",
            "--lsp",
          },
          settings = {
            dart = {
              completeFunctionCalls = true,
              showTodos = true,
            },
          },
        },
      },
    },
  },

  -- Syntax highlighting
  { "dart-lang/dart-vim-plugin" },

  -- Configuração do Debugger (DAP) para Dart (para Termux)
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      -- Também precisamos apontar para o snapshot do debug adapter
      dap.adapters.dart = {
        type = "executable",
        command = "dart",
        args = { vim.fn.expand("$PREFIX") .. "/libexec/dart/bin/snapshots/debug_adapter.dart.snapshot" },
      }
      dap.configurations.dart = {
        {
          name = "Launch current file",
          type = "dart",
          request = "launch",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
      }
    end,
  },
}
