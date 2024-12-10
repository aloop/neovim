return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.ai").setup()
    require("mini.icons").setup()
    require("mini.surround").setup()
    require("mini.splitjoin").setup()
    require("mini.move").setup()
    require("mini.sessions").setup({
      autoread = true,
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
