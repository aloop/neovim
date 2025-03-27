return {
  "lewis6991/gitsigns.nvim",
  name = "gitsigns",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  cmd = "Gitsigns",
  opts = {
    numhl = false,
    word_diff = true,
    current_line_blame = false,
    current_line_blame_opts = {
      delay = 300,
    },
  },
  keys = {
    { "<leader>gs", function() require("gitsigns").stage_hunk() end, desc = "[g]it [s]tage hunk" },
    {
      "<leader>gs",
      function() require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
      mode = "v",
      desc = "[g]it [s]tage hunk",
    },
    { "<leader>gS", function() require("gitsigns").stage_buffer() end, desc = "[g]it [s]tage buffer" },
    { "<leader>gr", function() require("gitsigns").reset_hunk() end, desc = "[g]it [r]eset hunk" },
    {
      "<leader>gr",
      function() require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
      mode = "v",
      desc = "[g]it [r]eset hunk",
    },
    { "<leader>gR", function() require("gitsigns").reset_buffer() end, desc = "git [r]eset buffer" },
    { "<leader>gp", function() require("gitsigns").preview_hunk() end, desc = "git [p]review hunk" },
    { "<leader>gb", function() require("gitsigns").blame_line({ full = true }) end, desc = "git [b]lame line" },
    { "<leader>gB", function() require("gitsigns").blame() end, desc = "git [b]lame" },
    { "<leader>gd", function() require("gitsigns").diffthis() end, desc = "git [d]iff against index" },
    { "<leader>gD", function() require("gitsigns").diffthis("@") end, desc = "git [d]iff against last commit" },

    { "]g", function() require("gitsigns").nav_hunk("next") end, desc = "go to next [g]it hunk" },
    { "[g", function() require("gitsigns").nav_hunk("prev") end, desc = "go to previous [g]it hunk" },

    { "ih", function() require("gitsigns").select_hunk() end, mode = { "o", "x" } },
  },
}
