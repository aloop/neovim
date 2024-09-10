local map = vim.keymap.set
local function smap(mode, key, action, desc)
  map(mode, key, action, {
    desc = desc,
    silent = true,
  })
end

smap("i", "jj", "<esc>", "Exit insert mode")

smap("c", "w!!", "<cmd>w !sudo tee % >/dev/null", "Write buffer with sudo")

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
smap("n", "<esc>", '<cmd>let @/=""<cr>', "Clear the last search")

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
