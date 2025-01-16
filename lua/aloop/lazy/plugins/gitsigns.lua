return {
  "lewis6991/gitsigns.nvim",
  name = "gitsigns",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  cmd = "Gitsigns",
  opts = {
    numhl = true,
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 300,
    },
  },
  keys = {
    -- Normal Mode Bindings
    { "<leader>hs", function() require("gitsigns").stage_hunk() end, desc = "git [s]tage hunk" },
    {
      "<leader>hs",
      function() require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
      mode = "v",
      desc = "git [s]tage hunk",
    },
    { "<leader>hS", function() require("gitsigns").stage_buffer() end, desc = "git [s]tage buffer" },
    { "<leader>hu", function() require("gitsigns").undo_stage_hunk() end, desc = "git [u]ndo stage hunk" },
    { "<leader>hr", function() require("gitsigns").reset_hunk() end, desc = "git [r]eset hunk" },
    {
      "<leader>hr",
      function() require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
      mode = "v",
      desc = "git [r]eset hunk",
    },
    { "<leader>hR", function() require("gitsigns").reset_buffer() end, desc = "git [r]eset buffer" },
    { "<leader>hp", function() require("gitsigns").preview_hunk() end, desc = "git [p]review hunk" },
    { "<leader>hb", function() require("gitsigns").blame_line({ full = true }) end, desc = "git [b]lame line" },
    { "<leader>hd", function() require("gitsigns").diffthis() end, desc = "git [d]iff against index" },
    { "<leader>hD", function() require("gitsigns").diffthis("@") end, desc = "git [d][iff against last commit" },
    { "]g", function() require("gitsigns").next_hunk() end, desc = "go to next [g]it hunk" },
    { "[g", function() require("gitsigns").prev_hunk() end, desc = "go to previous [g]it hunk" },
  },
}
