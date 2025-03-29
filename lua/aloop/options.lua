vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.colorcolumn = "121"
vim.o.linespace = 5
vim.o.scrolloff = 10
vim.o.sidescrolloff = 7
vim.o.title = true
vim.o.hidden = true
vim.o.inccommand = "split"
vim.o.breakindent = true
vim.o.wrap = false

vim.o.termguicolors = true

-- Must go faster
vim.o.updatetime = 100

-- Use the system clipboard
vim.o.clipboard = "unnamedplus"

-- Prefer a unix file-type
vim.o.ffs = "unix,dos,mac"

-- Set encoding type
vim.o.fileencoding = "utf-8"

-- Configure and enable listchars/fillchars
vim.o.list = true
vim.o.listchars = "tab:»-,trail:·,extends:»,precedes:«,nbsp:␣"
vim.o.fillchars = "eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:⏵"

-- Session Options
vim.o.sessionoptions = "buffers,curdir,folds,skiprtp,winsize"

-- Disable swap files
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.backup = false

-- Statuscolumn options
vim.o.numberwidth = 3
vim.o.signcolumn = "yes:1"

-- Split configuration
vim.o.splitbelow = true
vim.o.splitright = true

-- Fold settings
vim.o.foldlevelstart = 99

vim.o.foldmethod = "expr"
-- Default to treesitter folding
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Indentation Settings

vim.o.autoindent = true
vim.o.copyindent = true
vim.o.smartindent = true
vim.o.smarttab = true

---- Tab characters will be 2 spaces wide by default
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.shiftround = true

---- Use spaces instead of tabs
vim.o.expandtab = true

-- Search settings

---- Disable case-sensitivity in searches if there isn't
---- an uppercase letter in the pattern
vim.o.ignorecase = true
vim.o.smartcase = true

---- Search and highlight as you type
vim.o.incsearch = true
vim.o.showmatch = true
vim.o.hlsearch = true
vim.o.magic = true

-- Statusline settings

---- Always show the statusline
vim.o.laststatus = 2

---- Show the current row and column coordinates of the cursor in the statusline
vim.o.ruler = true

-- Show which-key faster
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Enable mouse for lazy resizing mainly
vim.o.mouse = "a"
vim.o.mousemoveevent = true

-- Our statusline already shows the current mode
vim.o.showmode = false
