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
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = {
            col_offset = -3,
          },
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            menu = {
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            },
            before = function(entry, vim_item)
              if vim_item.kind == "Color" then
                local doc = entry:get_completion_item().documentation
                if doc and type(doc) == "string" then
                  local color = doc:match("^#%x%x%x%x%x%x$")
                  if not color then
                    -- try rgb(...) format as fallback
                    local r, g, b = doc:match("^rgb%((%d+), (%d+), (%d+)")
                    if r then
                      color = string.format("#%02x%02x%02x", r, g, b)
                    end
                  end
                  if color then
                    local hl = "Tw_" .. color:sub(2)
                    if #vim.api.nvim_get_hl(0, { name = hl }) == 0 then
                      vim.api.nvim_set_hl(0, hl, { fg = color })
                    end
                    vim_item.kind = "■"
                    vim_item.kind_hl_group = hl
                    return vim_item
                  end
                end
              end
              vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
              return vim_item
            end,
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },
}
