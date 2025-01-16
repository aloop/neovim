local map = vim.keymap.set
local function smap(mode, key, action, desc, opts)
  opts = opts or {}
  map(
    mode,
    key,
    action,
    vim.tbl_deep_extend("force", {
      desc = desc,
      silent = true,
    }, opts)
  )
end

smap("i", "jj", "<esc>", "Exit insert mode")

smap("n", "x", '"_x', "Don't copy single character deletions to the default buffer")
smap("v", "p", '"_dP', "Paste without clobbering the register")

smap("n", "<leader>z", "<cmd>undo<cr>", "Undo")
smap("n", "<leader>Z", "<cmd>redo<cr>", "Redo")

smap("n", "<leader>v", "<C-w>v<C-w>l", "Open a vertical split and focus it")
smap("n", "<leader>V", "<C-w>s<C-w>l", "Open a horizontal split and focus it")

-- Buffer navigation
smap("n", "<A-h>", "<cmd>bp<cr>", "Go to previous buffer")
smap("n", "<A-l>", "<cmd>bn<cr>", "Go to next buffer")

map("n", "/", '<cmd>let @/=""<cr>/', { desc = "Search (and clear last search)" })
smap("n", "<esc>", '<cmd>let @/=""<cr><esc>', "Clear the last search")

-- Skip past wrapped lines
map("n", "j", "v:count == 0 ? 'gj' : 'j'", {
  expr = true,
  silent = true,
})
map("n", "k", "v:count == 0 ? 'gk' : 'k'", {
  expr = true,
  silent = true,
})

-- Center search result when moving through results
smap("n", "n", "nzzzv")
smap("n", "N", "Nzzzv")

-- Keep selection intact after indent
smap("v", ">", ">gv")
smap("v", "<", "<gv")

-- loclist navigation
smap("n", "[l", "<cmd>lprev<cr>", "Previous loclist item")
smap("n", "]l", "<cmd>lnext<cr>", "Next loclist item")
smap("n", "[L", "<cmd>lolder<cr>", "Older loclist item")
smap("n", "]L", "<cmd>lnewer<cr>", "Newer loclist item")

-- quickfix navigation
smap("n", "[q", "<cmd>cprev<cr>", "Previous quickfix item")
smap("n", "]q", "<cmd>cnext<cr>", "Next quickfix item")
smap("n", "[Q", "<cmd>qolder<cr>", "Older quickfix item")
smap("n", "]Q", "<cmd>qnewer<cr>", "Newer quickfix item")

-- Copy line/block and comment out the original line/block
smap("n", "yc", "yygccp", "Duplicate line and comment out original line", { remap = true })
smap("v", "yc", "ygvgc`>p", "Duplicate selection and comment out original selection", { remap = true })

smap("n", "<C-c>", "ciw")

-- Handle common git merge conflicts
smap("n", "<leader>gcu", "dd/|||<CR>0v/>>><CR>$x", "[G]it [C]onflict Choose [U]pstream")
smap("n", "<leader>gcb", "0v/|||<CR>$x/====<CR>0v/>>><CR>$x", "[G]it [C]onflict Choose [B]ase")
smap("n", "<leader>gcs", "0v/====<CR>$x/>>><CR>dd", "[G]it [C]onflict Choose [S]tashed")

-- Block insert in line visual mode
smap("x", "I", function() return vim.fn.mode() == "V" and "^<C-v>I" or "I" end, "", { expr = true })
smap("x", "A", function() return vim.fn.mode() == "V" and "$<C-v>A" or "A" end, "", { expr = true })
