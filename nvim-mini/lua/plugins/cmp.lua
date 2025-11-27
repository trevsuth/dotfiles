return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      -- Optional snippets collection:
      { "rafamadriz/friendly-snippets", lazy = true },
    },
    config = function()
      local cmp = require("cmp")
      local ls  = require("luasnip")
      -- Load VSCode-format snippets when the loader is available
      local ok, vscode_loader = pcall(require, "luasnip.loaders.from_vscode")
      if ok then
        vscode_loader.lazy_load()
      end

      cmp.setup({
        snippet = { expand = function(args) ls.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        },
      })
    end,
  },
}
