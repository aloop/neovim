return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.ai").setup()
    require("mini.surround").setup()
    require("mini.splitjoin").setup()
    require("mini.sessions").setup({
      autoread = true,
    })

    local starter = require("mini.starter")
    starter.setup({
      header = table.concat({
        " █████╗ ██╗      ██████╗  ██████╗ ██████╗",
        "██╔══██╗██║     ██╔═══██╗██╔═══██╗██╔══██╗",
        "███████║██║     ██║   ██║██║   ██║██████╔╝",
        "██╔══██║██║     ██║   ██║██║   ██║██╔═══╝",
        "██║  ██║███████╗╚██████╔╝╚██████╔╝██║",
        "╚═╝  ╚═╝╚══════╝ ╚═════╝  ╚═════╝ ╚═╝",
      }, "\n"),
      items = {
        starter.sections.builtin_actions(),
        starter.sections.recent_files(10, true),
        starter.sections.recent_files(10, false),
      },
      content_hooks = {
        starter.gen_hook.adding_bullet(),
        starter.gen_hook.indexing("all", { "Builtin actions" }),
        starter.gen_hook.padding(3, 2),
      },
    })
  end,
}
