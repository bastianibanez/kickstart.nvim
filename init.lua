-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("java").setup()
require("lspconfig").jdtls.setup({})
