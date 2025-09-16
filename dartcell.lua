return {
	-- Configuração do Language Server do Dart
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		opts = {
			servers = {
				dartls = {
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

	-- Syntax highlighting (opcional, mas recomendado)
	{ "dart-lang/dart-vim-plugin" },

	-- Configuração do Debugger (DAP) para Dart
	{
		"mfussenegger/nvim-dap",
		opts = function()
			local dap = require("dap")
			dap.adapters.dart = {
				type = "executable",
				command = "dart", -- 'dart' já está no $PATH do Termux
				args = { "debug_adapter" },
			}
			-- Configuração de debug para um script Dart genérico
			dap.configurations.dart = {
				{
					name = "Launch current file", -- Inicia o debug para o arquivo atual
					type = "dart",
					request = "launch",
					program = "${file}", -- Variável que representa o arquivo atual
					cwd = "${workspaceFolder}",
				},
			}
		end,
	},
}
