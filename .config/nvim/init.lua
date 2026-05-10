-- ============================================================================
-- Core
-- ============================================================================

local Config = {}
_G.Config = Config

local add = vim.pack.add

add({ 'https://github.com/nvim-mini/mini.nvim' })
local misc = require('mini.misc')

Config.now = function(f) misc.safely('now', f) end
Config.later = function(f) misc.safely('later', f) end

-- Leader
vim.g.mapleader = ' '

-- Options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.clipboard = 'unnamedplus'

-- Highlight yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
})

-- Fix formatoptions
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    vim.opt_local.formatoptions:remove({ 'c', 'o' })
  end,
})

-- ============================================================================
-- UI (colorscheme, lualine, icons)
-- ============================================================================

Config.now(function()
  add({ 'https://github.com/rose-pine/neovim' })
  vim.cmd('colorscheme rose-pine')
end)

Config.now(function()
  add({
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/nvim-lualine/lualine.nvim',
  })

  local function lsp_detect()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then return '' end
    local names = {}
    for _, c in ipairs(clients) do table.insert(names, c.name) end
    return table.concat(names, ', ')
  end

  require('lualine').setup({
    options = { theme = 'rose-pine' },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { { 'filename', path = 1 } },
      lualine_x = { lsp_detect },
      lualine_y = { 'selectioncount' },
      lualine_z = { '%l/%L' },
    },
  })
end)

-- ============================================================================
-- Editing (treesitter, completion, files, icons)
-- ============================================================================

Config.now(function()
  add({
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  })

  require('nvim-treesitter').setup({
    ensure_installed = { 'lua', 'vimdoc', 'markdown', 'html' },
    auto_install = true,
    highlight = { enable = true },
  })
end)

Config.now(function()
  require('mini.completion').setup({})
end)

Config.now(function()
  require('mini.files').setup({ windows = { preview = true } })
end)

vim.keymap.set('n', '<leader>e', function()
  require('mini.files').open()
end, { desc = 'Explorer' })

Config.now(function()
  require('mini.icons').setup({})
end)

-- ============================================================================
-- LSP
-- ============================================================================

Config.now(function()
  add({ 'https://github.com/neovim/nvim-lspconfig' })

  -- https://github.com/vuejs/language-tools/wiki/Neovim
  -- NOTE: install @vue/language-server
  -- `npm install -g @vue/language-server`
  -- check the path of vue_language_server_path
  local vue_language_server_path =
  '/home/suinming/.local/share/mise/installs/node/24.6.0/lib/node_modules/@vue/language-server'
  local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }

  local vue_plugin = {
    name = '@vue/typescript-plugin',
    location = vue_language_server_path,
    languages = { 'vue' },
    configNamespace = 'typescript',
  }

  -- NOTE: install typescript and typescript-language-server
  -- `npm install -g typescript-language-server typescript`
  local ts_ls_config = {
    init_options = {
      plugins = {
        vue_plugin,
      },
    },
    filetypes = tsserver_filetypes,
  }

  vim.lsp.config('ts_ls', ts_ls_config)

  vim.lsp.enable({ 'lua_ls', 'ts_ls', 'vue_ls', 'ruff', 'sqls' })
end)

Config.now(function()
  vim.pack.add({
    {
      src = 'https://github.com/JavaHello/spring-boot.nvim',
      version = '218c0c26c14d99feca778e4d13f5ec3e8b1b60f0',
    },
    'https://github.com/MunifTanjim/nui.nvim',
    'https://github.com/mfussenegger/nvim-dap',

    'https://github.com/nvim-java/nvim-java',
  })

  require('java').setup()
  vim.lsp.enable('jdtls')
end)

-- Diagnostics
Config.later(function()
  vim.diagnostic.config({
    virtual_text = { current_line = true },
    underline = true,
    update_in_insert = false,
  })
end)

-- ============================================================================
-- Formatting
-- ============================================================================

Config.later(function()
  add({ 'https://github.com/stevearc/conform.nvim' })

  require('conform').setup({
    default_format_opts = { lsp_format = 'fallback' },
  })
end)

vim.keymap.set('n', '<leader>lf', function()
  require('conform').format({ async = true })
end, { desc = 'Format buffer' })

-- ============================================================================
-- Telescope
-- ============================================================================

Config.now(function()
  add({
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  })

  local telescope = require('telescope')
  local builtin = require('telescope.builtin')

  telescope.setup({
    defaults = {
      layout_strategy = 'horizontal',
      layout_config = { horizontal = { preview_cutoff = 0 } },
    },
  })

  vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
  vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'Live grep' })
  vim.keymap.set('n', '<leader>fc', builtin.grep_string, { desc = 'Grep word' })
  vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
end)

-- ============================================================================
-- Tools (todo, dbee, leetcode)
-- ============================================================================

Config.now(function()
  add({ 'https://github.com/folke/todo-comments.nvim' })
  require('todo-comments').setup({})
end)

Config.now(function()
  add({
    'https://github.com/kndndrj/nvim-dbee',
    'https://github.com/MunifTanjim/nui.nvim',
  })

  local dbee = require('dbee')

  dbee.setup({
    sources = {
      require('dbee.sources').MemorySource:new({
        {
          id = 'tw_db',
          name = 'tw_db',
          type = 'sqlite',
          url = vim.fn.expand('~/data/tw_db.sqlite'),
        },
      }),
    },
  })
end)

Config.now(function()
  add({ 'https://github.com/kawre/leetcode.nvim' })
  require('leetcode').setup({
    lang = 'java',
    cache = {
      dir = vim.fn.stdpath("cache") .. "/leetcode"
    }
  })
end)
