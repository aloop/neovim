return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
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
  },
  keys = {
    {
      "<leader>dn",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss All Notifications",
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gb",
      function()
        Snacks.git.blame_line()
      end,
      desc = "Git Blame Line",
    },
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Git Browse",
    },
    {
      "<leader>gf",
      function()
        Snacks.lazygit.log_file()
      end,
      desc = "Lazygit Current File History",
    },
    {
      "<leader>gl",
      function()
        Snacks.lazygit.log()
      end,
      desc = "Lazygit Log (cwd)",
    },
    {
      "<leader>cR",
      function()
        Snacks.rename()
      end,
      desc = "Rename File",
    },
    {
      mode = { "n", "t" },
      "<c-/>",
      function()
        Snacks.terminal.toggle()
      end,
      desc = "Toggle Terminal",
    },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Next Reference",
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Prev Reference",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
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
        progress[client.id] = vim.tbl_filter(function(v)
          return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(table.concat(msg, "\n"), "info", {
          id = "lsp_progress",
          title = client.name,
          opts = function(notif)
            notif.icon = #progress[client.id] == 0 and " " or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          end,
        })
      end,
    })
  end,
}
