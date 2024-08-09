local function telescope_project_files(opts)
  local opts = opts or {}
  local builtin = require("telescope.builtin")
  local custom_cwd = opts.cwd or nil

  -- Get the directory of the current buffer
  opts.cwd = vim.fn.expand("%:p:h")

  -- Determine if the current buffer is in a git repo, if so use git_files instead of find_files
  local ok = pcall(builtin.git_files, opts)
  if not ok then
    opts.cwd = custom_cwd
    builtin.find_files(opts)
  end
end

local function open_with_trouble(...)
  require("trouble.sources.telescope").open(...)
end

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = (function()
        if not vim.g.is_nix then
          return "make"
        end
      end)(),
    },
  },
  cmd = "Telescope",
  opts = {
    defaults = {
      layout_strategy = "flex",
      sorting_strategy = "ascending",
      layout_config = {
        width = 0.95,
        height = 0.95,
        prompt_position = "top",
        preview_cutoff = 120,
        horizontal = {
          preview_width = 0.6,
        },
        vertical = {
          preview_cutoff = 2,
          mirror = true,
        },
        flex = {
          flip_columns = 150,
        },
      },
      hidden = true,
      mappings = {
        i = {
          ["<esc>"] = require("telescope.actions").close,
          ["<c-t>"] = open_with_trouble,
        },
        n = {
          ["<c-t>"] = open_with_trouble,
        },
      },
      init = function()
        pcall(require("telescope").load_extension, "fzf")
      end,
    },
    pickers = {
      git_files = {
        show_untracked = true,
      },
      buffers = {
        mappings = {
          i = {
            ["<M-d>"] = require("telescope.actions").delete_buffer,
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader><leader>",
      function()
        telescope_project_files({ hidden = true })
      end,
      desc = "Fuzzy find files",
    },
    { "<leader>?", "<cmd>Telescope oldfiles<cr>", desc = "Search through recent files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep through files under cwd" },
    { "<leader>sg", "<cmd>Telescope grep_string<cr>", desc = "Search for word under cursor in cwd" },
    { "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Search Buffers" },
    { "<tab>", "<cmd>Telescope buffers<cr>", desc = "Search Buffers" },
    { "<leader>sp", "<cmd>Telescope spell_suggest<cr>", desc = "Spelling Suggestions" },
    { "<leader>ht", "<cmd>Telescope help_tags<cr>", desc = "Search Help Tags" },
    { "<leader>mp", "<cmd>Telescope man_pages<cr>", desc = "Search Man Pages" },
    { "<leader>km", "<cmd>Telescope keymaps<cr>", desc = "Search Key Maps" },
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Search Command History" },
    { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy search in current buffer" },
    { "<leader>td", "<cmd>Telescope diagnostics<cr>", desc = "Show diagnostics" },
    { "<leader>gd", "<cmd>Telescope lsp_definitions<cr>", desc = "LSP definitions list" },
    { "<leader>gr", "<cmd>Telescope lsp_references<cr>", desc = "LSP references list" },
    { "<leader>gi", "<cmd>Telescope lsp_implementations<cr>", desc = "LSP implementations list" },
    { "<leader>gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "LSP type definitions list" },
  },
}
