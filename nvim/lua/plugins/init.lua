
return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require("configs.conform"),
  },

  { 'wakatime/vim-wakatime', lazy = false},
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("configs.lspconfig")
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim"
    },
    opts = {},
  },

  {
    "MunifTanjim/nui.nvim",
    branch = "main",
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file tree" },
    },
    config = function()
      vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

      require("neo-tree").setup({
        enable_git_status = true,
        filesystem = {
          filtered_items = {
            hide_gitignored = false,
            hide_dotfiles = false,
          },
          use_libuv_file_watcher = true,
          renderers = {
            file = {
              { "icon" },
              {
                "name",
                use_git_status_colors = false,
                zindex = 10,
                highlight = function(_, node)
                  if node.git_status and node.git_status.ignored then
                    return "NeoTreeGitIgnored"
                  end
                end,
              },
            },
          },
        },
      })
    end,
  },

  -- Include rustaceanvim from separate file
  require("plugins.rustacenvim"),

  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" }
    },
    init = function()
      vim.o.undofile = true
      vim.o.undodir = vim.fn.stdpath("data") .. "/undo"
      vim.fn.mkdir(vim.o.undodir, "p")
    end
  },

  {
    "pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        enabled = true,
        execution_message = "autosaved...",
        events = { "InsertLeave", "TextChanged" },
        conditions = {
          exists = true,
          filename_is_not = {},
          filetype_is_not = {},
          modifiable = true
        },
        write_all_buffers = false,
      })
    end
  },

  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },

  -- Keep nvim-dap but remove Rust-specific configuration (handled by rustaceanvim)
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      -- Rust DAP configuration is now handled by rustaceanvim
      -- Add other language configurations here if needed
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      require("dapui").setup()
    end,
  },

  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true,
          },
        },
      }
      require("cmp").setup.buffer({
        sources = { { name = "crates" } }
      })
    end,
  },

  {
    "TimUntersberger/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim"
    },
    lazy = false,
    config = true,
  },

  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    cmd = "LazyGit",
    keys = {
      { "<leader>tt", "<cmd>LazyGit<CR>", desc = "Open LazyGit" },
    },
    config = function()
      vim.g.lazygit_floating_window_winblend = 0
      vim.g.lazygit_floating_window_scaling_factor = 1.0
      vim.g.lazygit_use_neovim_remote = true
    end,
  },

  {
    'brianhuster/live-preview.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "latex", "css", "rust", "toml"
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup {
        signs = {
          add          = { text = "│" },
          change       = { text = "│" },
          delete       = { text = "_" },
          topdelete    = { text = "‾" },
          changedelete = { text = "~" },
          untracked    = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
          ignore_whitespace = false,
        },
        update_debounce = 200,
        status_formatter = nil,
      }
    end,
  },
}
