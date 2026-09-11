return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          border = "single",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          html = { "prettier" },
          css = { "prettier" },
          ruby = { "rubocop" },
          javascript = { "prettier" },
          yaml = { "prettier" },
          c = { "clang-format" },
          cpp = { "clang-format" },
          cs = { "clang-format" },
          python = { "black" },
          rust = { "rustfmt" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
        notify_on_error = true,

        vim.keymap.set("n", "<leader>fm", function()
          require("conform").format()
        end, { silent = true, desc = "Format current document" }),
      })
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "clangd",
          "eslint",
          "cssls",
          "emmet_language_server",
          "tailwindcss",
          "pylsp",
          "rust_analyzer",
          "html",
          "gopls",
          "ts_ls",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("ols")
      vim.lsp.enable("eslint")
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("cssls")
      vim.lsp.config["emmet_language_server"] = {
        filetypes = { "html", "css", "php", "blade", "jsx", "javascript", "typescript" },
        init_options = {
          html = {
            options = {
              ["bem.enabled"] = true,
            },
          },
        },
      }

      vim.lsp.enable("emmet_language_server")
      vim.lsp.config["html"] = {
        filetypes = { "html", "php", "blade", "htm" },
        init_options = {
          configurationSection = { "html", "css", "typescript", "javascript", "tsx" },
          embeddedLanguages = {
            css = true,
            javascript = true,
          },
          provideFormatter = true,
        },
      }
      vim.lsp.config["arduino_language_server"] = {
        cmd = {
          "arduino-language-server",
          "-cli", "arduino-cli",
          "-cli-config", "/home/wetar/.arduino15/arduino-cli.yaml",
          "-fqbn", "arduino:avr:uno"
        }
      }
      vim.lsp.enable("arduino_language_server")
      vim.lsp.enable("html")
      vim.lsp.enable("clangd")
      vim.lsp.enable("jsonls")
      vim.lsp.enable("pylsp")
      vim.lsp.enable("rust_analyzer")
      vim.lsp.config["qmlls"] = {
        cmd = { "qmlls" },
        filetypes = { "qml" },
      }
      vim.lsp.enable("qmlls")
      vim.lsp.enable("gopls")
      vim.lsp.enable("tailwindcss")
      vim.keymap.set(
        { "n", "v" },
        "<leader>ca",
        vim.lsp.buf.code_action,
        { silent = true, desc = "Show code action from configured LSP" }
      )
    end,
  },
}
