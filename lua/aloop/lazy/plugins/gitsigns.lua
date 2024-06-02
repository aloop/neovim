return {
  "lewis6991/gitsigns.nvim",
  name = "gitsigns",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  cmd = "Gitsigns",
  opts = {},
  keys = {
    -- Normal Mode Bindings
    {
      "<leader>hs",
      function()
        require("gitsigns").stage_hunk()
      end,
      desc = "git [s]tage hunk",
    },
    {
      "<leader>hS",
      function()
        require("gitsigns").stage_buffer()
      end,
      desc = "git [s]tage buffer",
    },
    {
      "<leader>hu",
      function()
        require("gitsigns").undo_stage_hunk()
      end,
      desc = "git [u]ndo stage hunk",
    },
    {
      "<leader>hr",
      function()
        require("gitsigns").reset_hunk()
      end,
      desc = "git reset hunk",
    },
    {
      "<leader>hR",
      function()
        require("gitsigns").reset_buffer()
      end,
      desc = "git [r]eset buffer",
    },
    {
      "<leader>hp",
      function()
        require("gitsigns").preview_hunk()
      end,
      desc = "git [p]review hunk",
    },
    {
      "<leader>hb",
      function()
        require("gitsigns").blame_line()
      end,
      desc = "git [b]lame line",
    },
    {
      "<leader>hd",
      function()
        require("gitsigns").diffthis()
      end,
      desc = "git [d]iff against index",
    },
    {
      "<leader>hD",
      function()
        require("gitsigns").diffthis("@")
      end,
      desc = "git [d][iff against last commit",
    },
  },
  init = function()
    vim.keymap.set("v", "<leader>hs", function()
      require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "git [s]tage hunk" })
    vim.keymap.set("v", "<leader>hr", function()
      require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "git [r]eset hunk" })
  end,
}
