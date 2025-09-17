return {
  -- Configuração do Language Server do Dart
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        -- O nome do servidor para Dart no mason-lspconfig é 'dartls'
        dartls = {
          -- As configurações são aninhadas dentro de um objeto 'dart'
          -- Referência: documentação do Dart SDK [cite: 4885, 4890, 4891]
          settings = {
            dart = {
              completeFunctionCalls = true, -- Completa chamadas de função com parênteses [cite: 4890]
              showTodos = true, -- Mostra TODOs como diagnósticos [cite: 4891]
            },
          },
        },
      },
    },
  },

  -- Ferramentas do Flutter
  {
    "akinsho/flutter-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
    opts = {
      -- As configurações do LSP para colorir o código podem ser mantidas aqui
      lsp = {
        color = {
          enabled = true,
          background = true,
          virtual_text = true,
          virtual_text_str = "■",
        },
      },
      debugger = {
        enabled = true,
        run_via_dap = true,
      },
      widget_guides = {
        enabled = true,
      },
    },
  },

  -- Syntax highlighting (opcional, mas recomendado)
  { "dart-lang/dart-vim-plugin" },

  -- Configuração do Debugger (DAP) para Dart/Flutter
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      -- Garante que o executável 'dart' esteja no seu $PATH
      -- Em vez de um caminho fixo, o sistema irá encontrá-lo
      dap.adapters.dart = {
        type = "executable",
        command = "dart", -- Presume que 'dart' está no $PATH
        args = { "debug_adapter" },
      }
      dap.configurations.dart = {
        {
          name = "Launch Flutter",
          type = "dart",
          request = "launch",
          program = "lib/main.dart",
          cwd = "${workspaceFolder}",
        },
        {
          name = "Flutter Attach",
          type = "dart",
          request = "attach",
          cwd = "${workspaceFolder}",
        },
      }
    end,
  },
}
