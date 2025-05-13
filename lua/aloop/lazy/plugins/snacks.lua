return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  dependencies = {
    {
      "folke/todo-comments.nvim",
      optional = true,
      keys = {
        {
          "<leader>tc",
          function() Snacks.picker.todo_comments() end,
          desc = "View [t]odo [c]omments",
        },
      },
    },
    {
      "folke/trouble.nvim",
      optional = true,
      specs = {
        "folke/snacks.nvim",
        opts = function(_, opts)
          return vim.tbl_deep_extend("force", opts or {}, {
            picker = {
              actions = require("trouble.sources.snacks").actions,
              win = {
                input = {
                  keys = {
                    ["<c-t>"] = {
                      "trouble_open",
                      mode = { "n", "i" },
                    },
                  },
                },
              },
            },
          })
        end,
      },
    },
  },
  ---@type snacks.Config
  opts = {
    styles = {
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },

    bigfile = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    terminal = { enabled = true },
    image = { enabled = true },

    notifier = {
      enabled = true,
      timeout = 3000,
    },

    dashboard = {
      preset = {
        header = table.concat({
          " █████╗ ██╗      ██████╗  ██████╗ ██████╗ ",
          "██╔══██╗██║     ██╔═══██╗██╔═══██╗██╔══██╗",
          "███████║██║     ██║   ██║██║   ██║██████╔╝",
          "██╔══██║██║     ██║   ██║██║   ██║██╔═══╝ ",
          "██║  ██║███████╗╚██████╔╝╚██████╔╝██║     ",
          "╚═╝  ╚═╝╚══════╝ ╚═════╝  ╚═════╝ ╚═╝     ",
        }, "\n"),
      },
      sections = {
        { section = "header" },
        { icon = " ", title = "Recent Files", section = "recent_files", cwd = true, limit = 8, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", padding = 1 },
        { section = "keys" },
        { section = "startup" },
      },
    },

    picker = {
      db = {
        sqlite3_path = vim.g.nix_sqlite3_path or nil,
      },
      matcher = {
        sort_empty = true,
      },
      previewers = {
        git = {
          native = true,
        },
      },
      formatters = {
        file = {
          truncate = 80,
        },
      },
    },
  },
  keys = {
    { "<leader>dn", function() Snacks.notifier.hide() end, desc = "[D]ismiss All [N]otifications" },
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer (preserve layout)" },
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>bg", function() Snacks.gitbrowse() end, desc = "[G]it [B]rowse" },
    { mode = { "n", "t" }, "<c-/>", function() Snacks.terminal.toggle() end, desc = "Toggle Terminal" },
    { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference" },
    { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference" },

    ---- Picker keymaps

    -- find files
    {
      "<leader><leader>",
      function()
        Snacks.picker.smart({
          hidden = true,
          filter = {
            cwd = true,
          },
          matcher = {
            cwd_bonus = false, -- We're filtering to only show stuff under cwd anyways
          },
        })
      end,
      desc = "Fuzzy find files",
    },
    { "<leader>?", function() Snacks.picker.recent({ filter = { cwd = true } }) end, desc = "Search through recent files under cwd" },

    -- grep
    { "<leader>/", function() Snacks.picker.lines() end, desc = "Fuzzy search in current buffer" },
    { "<leader>sg", function() Snacks.picker.grep() end, desc = "[S]earch ([G]rep) file contents" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, mode = { "n", "v" }, desc = "[S]earch [W]ord under cursor/selection" },
    { "<leader>sb", function() Snacks.picker.grep_buffers() end, desc = "[S]earch [B]uffers" },

    -- search
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Search Command History" },
    {
      "<tab>",
      function()
        Snacks.picker.buffers({
          current = false,
          nofile = false,
        })
      end,
      desc = "Search Buffers",
    },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "[S]earch [H]elp Tags" },
    { "<leader>sm", function() Snacks.picker.man() end, desc = "[S]earch [M]an Pages" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "[S]earch [K]ey Maps" },

    -- diagnostics
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "[S]how [D]iagnostics" },
    { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "[S]how [D]iagnostics (current buffer)" },

    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "[G]oto [D]efinition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "[G]oto [D]eclaration" },
    { "grr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "[G]oto [R]eference" },
    { "gri", function() Snacks.picker.lsp_implementations() end, desc = "[G]oto [I]mplementation" },
    { "grt", function() Snacks.picker.lsp_type_definitions() end, desc = "[G]oto [T]ype Definition" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "[S]how LSP [S]ymbols" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "[S]how LSP Workspace [S]ymbols" },

    -- misc
    { "<leader>sr", function() Snacks.picker.resume() end, desc = "[R]esume last picker" },
    { "<leader>sp", function() Snacks.picker.projects() end, desc = "[S]earch [P]rojects" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "[S]earch [Q]uickfix List" },
    { "<leader>sl", function() Snacks.picker.loclist() end, desc = "[S]earch [L]oclist" },
    { "<leader>n", function() Snacks.picker.notifications() end, desc = "[N]otifications" },
  },

  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...) Snacks.debug.inspect(...) end
        _G.bt = function() Snacks.debug.backtrace() end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
        Snacks.toggle.inlay_hints():map("<leader>th")
      end,
    })
  end,
}
