local command = function(command_name, opts)
  return function()
    require("fzf-lua")[command_name](opts or {})
  end
end

local bufferOpts = {
  ignore_current_buffer = true,
  no_term_buffers = true,
}

return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = {
    "echasnovski/mini.nvim",
    "folke/trouble.nvim",
  },
  opts = function()
    local actions = require("fzf-lua.actions")
    local troubleActions = require("trouble.sources.fzf").actions

    local open_or_send_to_trouble = function(selected, opts)
      if #selected > 1 then
        return troubleActions.open_selected.fn(selected, opts, {
          focus = true,
        })
      else
        return actions.file_edit(selected, opts)
      end
    end

    return {
      "default",
      winopts = {
        preview = {
          delay = 20,
        },
      },
      actions = {
        files = {
          default = open_or_send_to_trouble,
          ["ctrl-q"] = open_or_send_to_trouble,
        },
        buffers = {
          default = open_or_send_to_trouble,
          ["ctrl-q"] = open_or_send_to_trouble,
        },
        search = {
          default = open_or_send_to_trouble,
          ["ctrl-q"] = open_or_send_to_trouble,
        },
      },
    }
  end,
  keys = {
    { "<leader><leader>", command("files", {}), desc = "Fuzzy find files" },
    { "<leader>?", command("oldfiles"), desc = "Search through recent files" },
    { "<leader>/", command("lgrep_curbuf"), desc = "Fuzzy search in current buffer" },
    { "<leader>:", command("command_history"), desc = "Search Command History" },
    { "<leader>sg", command("live_grep_native"), desc = "Grep through files under cwd" },
    { "<leader>sg", command("grep_visual"), mode = "v", desc = "Grep through files under cwd" },
    { "<leader>sw", command("grep_cword"), desc = "Search for word under cursor in cwd" },
    { "<leader>sb", command("buffers", bufferOpts), desc = "Search Buffers" },
    { "<tab>", command("buffers", bufferOpts), desc = "Search Buffers" },
    { "<leader>sp", command("spell_suggest"), desc = "Spelling Suggestions" },
    { "<leader>ht", command("helptags"), desc = "Search Help Tags" },
    { "<leader>mp", command("manpages"), desc = "Search Man Pages" },
    { "<leader>km", command("keymaps"), desc = "Search Key Maps" },
    { "<leader>td", command("diagnostics_workspace"), desc = "Show diagnostics" },
    { "<leader>gd", command("lsp_definitions"), desc = "LSP definitions list" },
    { "<leader>gr", command("lsp_references"), desc = "LSP references list" },
    { "<leader>gi", command("lsp_implementations"), desc = "LSP implementations list" },
    { "<leader>gt", command("lsp_typedefs"), desc = "LSP type definitions list" },
    { "<leader>ca", command("lsp_code_actions", { previewer = "codeaction_native" }), desc = "LSP [c]ode [a]ctions" },
  },
}
