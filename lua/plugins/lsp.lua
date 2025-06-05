-- ~/.config/nvim/lua/plugins/lsp.lua (or whatever your main plugin file is called)

-- Create a table to hold all your plugins
local plugins = {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- No cmp dependencies here anymore
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp") -- This require will now work

      -- Mason setup (optional but recommended for managing language servers)
      mason.setup()
      mason_lspconfig.setup({
        ensure_installed = { "pyright" }, -- Ensure pyright is installed via Mason
      })

      -- Pyright specific configuration
      lspconfig.pyright.setup({
        settings = {
          python = {
            analysis = {
              -- ...
            },
          },
        },
        capabilities = cmp_nvim_lsp.default_capabilities(),
        root_dir = lspconfig.util.root_pattern("pyproject.toml", "pyrightconfig.json", ".git"),
      })

      -- General LSP setup for other servers (if you have them)
      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = cmp_nvim_lsp.default_capabilities(),
            -- Add other common configurations here
          })
        end,
      })

      -- Keymaps for LSP (example)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "[G]oto [R]eferences" })
      vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
      vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, { desc = "[F]ormat" })
    end,
  },

  -- nvim-cmp is already a top-level plugin in plugins/cmp.lua (as per previous step)

  -- Add cmp-nvim-lsp as a top-level plugin too
  {
    "hrsh7th/cmp-nvim-lsp",
    -- No config needed here, it automatically integrates with nvim-cmp
  },

  -- Other plugins from your initial list might go here as top-level entries too
  -- Example:
  -- { "williamboman/mason.nvim" }, -- If you don't list it as a dependency of lspconfig
  -- { "williamboman/mason-lspconfig.nvim" }, -- If you don't list it as a dependency of lspconfig
}

return plugins
