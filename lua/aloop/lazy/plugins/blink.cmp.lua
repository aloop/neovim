return {
  "saghen/blink.cmp",

  dependencies = {
    "rafamadriz/friendly-snippets",
    "echasnovski/mini.nvim",
  },

  version = "*",

  -- build = vim.g.is_nix and "nix run .#build-plugin",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    completion = {
      -- 'prefix' will fuzzy match on the text before the cursor
      -- 'full' will fuzzy match on the text before *and* after the cursor
      -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
      keyword = { range = "full" },

      trigger = {
        show_in_snippet = false,
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 100,
        window = {
          border = "rounded",
        },
      },

      menu = {
        border = "rounded",
        draw = {
          treesitter = { "lsp" },
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
        },
      },

      -- Display a preview of the selected item on the current line
      ghost_text = { enabled = false },
    },

    signature = { window = { border = "rounded" } },

    fuzzy = {
      sorts = { "exact", "score", "sort_text" },
    },

    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- see the "default configuration" section below for full documentation on how to define
    -- your own keymap.
    keymap = {
      preset = "super-tab",
    },

    sources = {
      -- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items lua
      default = function()
        local success, node = pcall(vim.treesitter.get_node)
        if vim.bo.filetype == "lua" then
          return { "lsp", "path" }
        elseif success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
          return { "buffer" }
        else
          return { "lsp", "path", "snippets", "buffer" }
        end
      end,
    },
  },

  opts_extend = { "sources.default" },
}
