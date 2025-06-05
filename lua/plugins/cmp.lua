-- ~/.config/nvim/lua/plugins/cmp.lua
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    -- Remove cmp-nvim-lsp from here, it will be a top-level plugin
    -- "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer", -- Often useful for buffer completion
    "hrsh7th/cmp-path", -- Often useful for file path completion
    -- Add a snippet engine if you want snippets
    -- "L3MON4D3/LuaSnip",
    -- "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      sources = {
        { name = "nvim_lsp" }, -- This still works as cmp-nvim-lsp makes itself available to cmp
        { name = "buffer" },
        { name = "path" },
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      snippet = {
        expand = function(args)
          -- You need a snippet engine like `luasnip` for this
          -- if require('luasnip').in_snippet() then
          --   return require('luasnip').jumpable(1)
          -- else
          --   require('luasnip').expand_or_jump()
          -- end
          -- For basic expansion without jumpable checks:
          -- require('luasnip').lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })
  end,
}
