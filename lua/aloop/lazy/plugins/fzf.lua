local bufferOpts = {
  ignore_current_buffer = true,
  no_term_buffers = true,
}

return {
  "ibhagwan/fzf-lua",
  enabled = false,
  event = "VeryLazy",
  dependencies = {
    "echasnovski/mini.nvim",
    "folke/trouble.nvim",
    {
      "folke/todo-comments.nvim",
      optional = true,
      keys = {
        {
          "<leader>tc",
          function() require("todo-comments.fzf").todo() end,
          desc = "Show [T]odo [C]omments",
        },
      },
    },
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
          ["ctrl-q"] = troubleActions.open,
        },
        buffers = {
          default = open_or_send_to_trouble,
          ["ctrl-q"] = troubleActions.open,
        },
        search = {
          default = open_or_send_to_trouble,
          ["ctrl-q"] = troubleActions.open,
        },
      },
      oldfiles = {
        cwd_only = true,
        include_current_session = true,
      },
      grep = {
        rg_glob = true,
      },
    }
  end,
  keys = {
    { "<leader><leader>", function() require("fzf-lua").files() end, desc = "Fuzzy find files" },
    { "<leader>?", function() require("fzf-lua").oldfiles() end, desc = "Search through recent files" },
    { "<leader>/", function() require("fzf-lua").lgrep_curbuf() end, desc = "Fuzzy search in current buffer" },
    { "<leader>:", function() require("fzf-lua").command_history() end, desc = "Search Command History" },
    { "<leader>sg", function() require("fzf-lua").live_grep_native() end, desc = "Search file contents" },
    { "<leader>sG", function() require("fzf-lua").live_grep_resume() end, desc = "Search file contents (reuse last search)" },
    { "<leader>sg", function() require("fzf-lua").grep_visual() end, mode = "v", desc = "Grep through files under cwd" },
    { "<leader>sw", function() require("fzf-lua").grep_cword() end, desc = "Search for word under cursor in cwd" },
    { "<leader>sb", function() require("fzf-lua").buffers(bufferOpts) end, desc = "Search Buffers" },
    { "<tab>", function() require("fzf-lua").buffers(bufferOpts) end, desc = "Search Buffers" },
    { "<leader>sp", function() require("fzf-lua").spell_suggest() end, desc = "Spelling Suggestions" },
    { "<leader>ht", function() require("fzf-lua").helptags() end, desc = "Search Help Tags" },
    { "<leader>mp", function() require("fzf-lua").manpages() end, desc = "Search Man Pages" },
    { "<leader>km", function() require("fzf-lua").keymaps() end, desc = "Search Key Maps" },
    { "<leader>td", function() require("fzf-lua").diagnostics_workspace() end, desc = "Show diagnostics" },
    { "<leader>gd", function() require("fzf-lua").lsp_definitions() end, desc = "LSP definitions list" },
    { "<leader>gr", function() require("fzf-lua").lsp_references() end, desc = "LSP references list" },
    { "<leader>gi", function() require("fzf-lua").lsp_implementations() end, desc = "LSP implementations list" },
    { "<leader>gt", function() require("fzf-lua").lsp_typedefs() end, desc = "LSP type definitions list" },
    { "<leader>ca", function() require("fzf-lua").lsp_code_actions({ previewer = "codeaction_native" }) end, desc = "LSP [c]ode [a]ctions" },
  },
  setup = function(_, opts)
    local fzf = require("fzf-lua")

    fzf.setup(opts)
    fzf.register_ui_select()
  end,
}
