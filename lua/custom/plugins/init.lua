-- You can add your own plugins here or in other files in this directory!
--
-- See the kickstart.nvim README for more information

return {
  {
    'leoluz/nvim-dap-go',
    config = function()
      local dap_go = require 'dap-go'
      dap_go.setup {
        -- Additional dap configurations can be added.
        -- dap_configurations accepts a list of tables where each entry
        -- represents a dap configuration. For more details do:
        -- :help dap-configuration
        dap_configurations = {
          {
            -- Must be "go" or it will be ignored by the plugin
            type = 'go',
            name = 'Attach remote',
            mode = 'remote',
            request = 'attach',
          },
        },
        -- delve configurations
        delve = {
          -- the path to the executable dlv which will be used for debugging.
          -- by default, this is the "dlv" executable on your PATH.
          path = 'dlv',
          -- time to wait for delve to initialize the debug session.
          -- default to 20 seconds
          initialize_timeout_sec = 20,
          -- a string that defines the port to start delve debugger.
          -- default to string "${port}" which instructs nvim-dap
          -- to start the process in a random available port.
          -- if you set a port in your debug configuration, its value will be
          -- assigned dynamically.
          port = '${port}',
          -- additional args to pass to dlv
          args = {},
          -- the build flags that are passed to delve.
          -- defaults to empty string, but can be used to provide flags
          -- such as "-tags=unit" to make sure the test suite is
          -- compiled during debugging, for example.
          -- passing build flags using args is ineffective, as those are
          -- ignored by delve in dap mode.
          -- avaliable ui interactive function to prompt for arguments get_arguments
          build_flags = {},
          -- whether the dlv process to be created detached or not. there is
          -- an issue on delve versions < 1.24.0 for Windows where this needs to be
          -- set to false, otherwise the dlv server creation will fail.
          -- avaliable ui interactive function to prompt for build flags: get_build_flags
          detached = vim.fn.has 'win32' == 0,
          -- the current working directory to run dlv from, if other than
          -- the current working directory.
          cwd = nil,
        },
        -- options related to running closest test
        tests = {
          -- enables verbosity when running the test.
          verbose = false,
        },
      }
    end,
  },
  {
    'rest-nvim/rest.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, 'http')
      end,
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      scope = { enabled = true },
      indent = {
        char = '┊',
        highlight = { 'IblIndent' },
      },
    },
    config = function(_, opts)
      require('ibl').setup(opts)
      vim.api.nvim_set_hl(0, 'IblIndent', { fg = '#3b3b3b', nocombine = true })
    end,
  },
  {
    'SmiteshP/nvim-navic',
    config = function()
      local navic = require 'nvim-navic'
      navic.setup {
        lsp = { auto_attach = true },
      }
    end,
  },
  { 'LunarVim/breadcrumbs.nvim', dependencies = { 'SmiteshP/nvim-navic' } },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    options = {
      theme = 'auto',
      globalstatus = true,
    },
    config = function()
      local lualine_time = require 'acf.lualine_time'
      local lualine = require 'lualine'
      local configs = lualine.get_config()
      configs.sections.lualine_y = { lualine_time }
      lualine.setup(configs)
    end,
  },
  { 'nvim-neotest/nvim-nio' },
  {
    'mfussenegger/nvim-dap',
  },
  {
    'rcarriga/nvim-dap-ui',
    event = 'VeryLazy',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      dapui.setup {
        layouts = {
          { -- RIGHT SIZE : variables, watches, breakpoints, stacks
            elements = {
              { id = 'scopes', size = 0.35 },
              { id = 'watches', size = 0.25 },
              { id = 'breakpoints', size = 0.2 },
              { id = 'stacks', size = 0.2 },
            },
            size = 60,
            position = 'right',
          },
          { -- BOTTOM: REPL and console/log
            elements = {
              { id = 'repl', size = 0.5 },
              { id = 'console', size = 0.5 },
            },
            size = 15, -- height in lines
            position = 'bottom',
          },
        },
        controls = {
          enabled = true,
          element = 'repl',
        },
      }

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end

      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      dap.listeners.before.attach['dapui_config'] = function()
        dapui.open()
      end

      dap.listeners.before.launch['dapui_config'] = function()
        dapui.open()
      end
    end,
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    event = 'VeryLazy',
    dependencies = {
      'mason-org/mason.nvim',
      'mfussenegger/nvim-dap',
    },
    opts = {
      handler = {},
    },
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      local neogit = require 'neogit'
      neogit.setup {
        kind = 'floating',
      }
    end,
  },
}
