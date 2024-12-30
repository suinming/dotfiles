return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
      }
    },
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            theme = 'ivy'
          },
          live_grep = {
            theme = 'ivy'
          },
        },
        extensions = {
          fzf = {}
        }
      }
      require('telescope').load_extension('fzf')
      vim.keymap.set('n', '<space>ff', require('telescope.builtin').find_files)
      vim.keymap.set('n', '<space>fw', function()
        require "config.telescope.multigrep".setup()
      end
      )
    end
  }
}
