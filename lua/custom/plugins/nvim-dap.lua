return {
  { 'nvim-neotest/nvim-nio' },
  {
    'mfussenegger/nvim-dap',
    config = function()
      vim.keymap.set('n', '<leader>d<space>', ':DapContinue<CR>')
      vim.keymap.set('n', '<leader>dl', ':DapStepInto<CR>')
      vim.keymap.set('n', '<leader>dj', ':DapStepOver<CR>')
      vim.keymap.set('n', '<leader>dh', ':DapStepOut<CR>')
      vim.keymap.set('n', '<leader>dz', ':ZoomWinTabToggle<CR>')
      vim.keymap.set(
        'n',
        '<leader>dgt', -- dg as in debu[g] [t]race
        ":lua require('dap').set_log_level('TRACE')<CR>"
      )
      vim.keymap.set(
        'n',
        '<leader>dge', -- dg as in debu[g] [e]dit
        function()
          vim.cmd(':edit ' .. vim.fn.stdpath 'cache' .. '/dap.log')
        end
      )
      vim.keymap.set('n', '<F1>', ':DapStepOut<CR>')
      vim.keymap.set('n', '<F2>', ':DapStepOver<CR>')
      vim.keymap.set('n', '<F3>', ':DapStepInto<CR>')
      vim.keymap.set('n', '<leader>d-', function()
        require('dap').restart()
      end)
      vim.keymap.set('n', '<leader>d_', function()
        require('dap').terminate()
        require('dapui').close()
      end)
    end,
    lazy = true,
  },

  -- A default "GUI" front-end for nvim-dap
  {
    'rcarriga/nvim-dap-ui',
    config = function()
      require('dapui').setup()

      -- Note: Added this <leader>dd duplicate of <F5> because somehow the <F5>
      -- mapping keeps getting reset each time I restart nvim-dap. Annoying but whatever.
      --
      vim.keymap.set('n', '<leader>dd', function()
        require('dapui').open() -- Requires nvim-dap-ui

        vim.cmd [[DapContinue]] -- Important: This will lazy-load nvim-dap
      end)
    end,
    dependencies = {
      'mfussenegger/nvim-dap',
      'mfussenegger/nvim-dap-python', -- Optional adapter for Python
      'nvim-neotest/nvim-nio',
    },
  },

  -- TODO: Make sure that debugpy is installed. Otherwise, disable
  -- Reference: https://github.com/mfussenegger/nvim-dap-python#installation
  --
  {
    'mfussenegger/nvim-dap-python',
    config = function()
      require('dap-python').setup '/path/to/python/here' -- XXX: Replace this with your preferred Python, if wanted
      -- An example configuration to launch any Python file, via Houdini
      -- table.insert(
      --     require("dap").configurations.python,
      --     {
      --         type = "python",
      --         request = "launch",
      --         name = "Launch Via hython",
      --         program = "${file}",
      --         python = "/opt/hfs19.5.569/bin/hython"
      --         -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
      --     }
      -- )
    end,
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-treesitter/nvim-treesitter',
    },
  },

  -- Remember nvim-dap breakpoints between sessions, ``:PBToggleBreakpoint``
  {
    'Weissle/persistent-breakpoints.nvim',
    config = function()
      require('persistent-breakpoints').setup {
        load_breakpoints_event = { 'BufReadPost' },
      }

      vim.keymap.set('n', '<leader>db', ':PBToggleBreakpoint<CR>')
    end,
  },
}
