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
    { "<leader>gb", function() Snacks.git.blame_line() end, desc = "[G]it [B]lame Line" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "[G]it [B]rowse" },
    { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
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
    -- git
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "[G]it [L]og" },
    { "<leader>gL", function() Snacks.picker.git_log_file() end, desc = "[G]it [L]og (current file)" },
    { "<leader>gh", function() Snacks.picker.git_log_line() end, desc = "[G]it Log for current line" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "[G]it [S]tatus" },
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
    { "<leader>gd", function() Snacks.picker.lsp_definitions() end, desc = "[G]oto [D]efinition" },
    { "<leader>gr", function() Snacks.picker.lsp_references() end, desc = "[G]oto [R]eference" },
    { "<leader>gi", function() Snacks.picker.lsp_implementations() end, desc = "[G]oto [I]mplementation" },
    { "<leader>gt", function() Snacks.picker.lsp_type_definitions() end, desc = "[G]oto [T]ype Definition" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "[S]how LSP [S]ymbols" },
    -- misc
    { "<leader>sr", function() Snacks.picker.resume() end, desc = "[R]esume last picker" },
    { "<leader>sp", function() Snacks.picker.projects() end, desc = "[S]earch [P]rojects" },
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

    ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
    local progress = vim.defaulttable()
    vim.api.nvim_create_autocmd("LspProgress", {
      ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= "table" then
          return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
          if i == #p + 1 or p[i].token == ev.data.params.token then
            p[i] = {
              token = ev.data.params.token,
              msg = ("[%3d%%] %s%s"):format(
                value.kind == "end" and 100 or value.percentage or 100,
                value.title or "",
                value.message and (" **%s**"):format(value.message) or ""
              ),
              done = value.kind == "end",
            }
            break
          end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v) return table.insert(msg, v.msg) or not v.done end, p)

        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(table.concat(msg, "\n"), "info", {
          id = "lsp_progress",
          title = client.name,
          opts = function(notif) notif.icon = #progress[client.id] == 0 and " " or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1] end,
        })
      end,
    })
  end,
}
