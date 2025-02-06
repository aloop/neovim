local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.colorcolumn = "121"
opt.linespace = 5
opt.scrolloff = 10
opt.sidescrolloff = 7
opt.title = true
opt.hidden = true
opt.inccommand = "split"
opt.breakindent = true
opt.wrap = false

opt.termguicolors = true

-- Must go faster
opt.updatetime = 100

-- Use the system clipboard
opt.clipboard = "unnamedplus"

-- Prefer a unix file-type
opt.ffs = "unix,dos,mac"

-- Set encoding type
opt.fileencoding = "utf-8"

-- Configure and enable listchars/fillchars
opt.list = true
opt.listchars = "tab:»-,trail:·,extends:»,precedes:«,nbsp:␣"
opt.fillchars = "eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:⏵"

-- Session Options
opt.sessionoptions = "blank,buffers,curdir,folds,skiprtp,winsize"

-- Disable swap files
opt.writebackup = false
opt.swapfile = false
opt.backup = false

-- Statuscolumn options
opt.numberwidth = 3
opt.signcolumn = "yes:1"

-- Split configuration
opt.splitbelow = true
opt.splitright = true

-- Fold settings
opt.foldmethod = "syntax"
opt.foldlevelstart = 99

-- Indentation Settings

opt.autoindent = true
opt.copyindent = true
opt.smartindent = true
opt.smarttab = true

---- Tab characters will be 2 spaces wide by default
opt.softtabstop = 2
opt.shiftwidth = 2
opt.tabstop = 2
opt.shiftround = true

---- Use spaces instead of tabs
opt.expandtab = true

-- Search settings

---- Disable case-sensitivity in searches if there isn't
---- an uppercase letter in the pattern
opt.ignorecase = true
opt.smartcase = true

---- Search and highlight as you type
opt.incsearch = true
opt.showmatch = true
opt.hlsearch = true
opt.magic = true

-- Statusline settings

---- Always show the statusline
opt.laststatus = 2

---- Show the current row and column coordinates of the cursor in the statusline
opt.ruler = true

-- Show which-key faster
opt.timeout = true
opt.timeoutlen = 300

-- Enable mouse for lazy resizing mainly
opt.mouse = "a"
opt.mousemoveevent = true

-- Our statusline already shows the current mode
opt.showmode = false
