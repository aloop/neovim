return {
  "echasnovski/mini.nvim",
  version = false,
  keys = {
    { "<leader>gcc", "<cmd>Git commit<cr>", desc = "[g]it [c]ommit" },
    { "<leader>gca", "<cmd>Git commit --amend --no-edit<cr>", desc = "[g]it [c]ommit [a]mend" },
  },
  config = function()
    local function macro_recording()
      local reg = vim.fn.reg_recording()
      if reg == "" then
        return ""
      else
        return ((MiniStatusline.is_truncated(120) and "" or "Recording ") .. "@" .. reg)
      end
    end

    local colors = require("catppuccin.palettes").get_palette(vim.g.nix_catppuccin_variant)

    require("mini.ai").setup()
    require("mini.icons").setup()
    require("mini.surround").setup()
    require("mini.splitjoin").setup()
    require("mini.move").setup()
    require("mini.git").setup()
    require("mini.sessions").setup({
      autoread = true,
    })

    require("mini.statusline").setup({
      content = {
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git = MiniStatusline.section_git({ trunc_width = 40 })
          local diff = MiniStatusline.section_diff({ trunc_width = 75 })
          local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
          local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
          local filename = MiniStatusline.section_filename({ trunc_width = 140 })
          local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
          -- local location = MiniStatusline.section_location({ trunc_width = 75 })
          -- local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
          local macro_status = macro_recording()

          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
            "%<", -- Mark general truncate point
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=", -- End left alignment
            { hl = "MiniStatuslineModeReplace", strings = { macro_status } },
            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
          })
        end,
      },
    })

    local hipatterns = require("mini.hipatterns")
    hipatterns.setup({
      highlighters = {
        hex_color = hipatterns.gen_highlighter.hex_color({ priority = 2000 }),
        shorthand = {
          pattern = "()#%x%x%x()%f[^%x%w]",
          group = function(_, _, data)
            ---@type string
            local match = data.full_match
            local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
            local hex_color = "#" .. r .. r .. g .. g .. b .. b

            return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
          end,
          extmark_opts = { priority = 2000 },
        },
      },
    })
  end,
}
