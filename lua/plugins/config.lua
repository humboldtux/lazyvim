return {

  -- ========================
  -- Core LazyVim
  -- ========================
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },

  -- ========================
  -- Infra avancée (niveau 2)
  -- ========================

  -- Kubernetes / Helm
  {
    "h4ckm1n-dev/kube-utils-nvim",
    config = true,
  },

  -- Docker
  {
    "ekalinin/Dockerfile.vim",
  },

  -- SSH remote editing
  {
    "inhesrom/remote-ssh.nvim",
    config = true,
  },

  -- ========================
  -- Git amélioré
  -- ========================
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
    },
  },

  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>-", mode = { "n", "v" }, "<cmd>Yazi<cr>", desc = "Open Yazi" },
      { "<leader>cw", "<cmd>Yazi cwd<cr>", desc = "Yazi (cwd)" },
    },
    opts = {
      open_for_directories = false,
    },
  },

  -- ========================
  -- Treesitter
  -- ========================
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "go",
        "python",
        "lua",
        "yaml",
        "json",
        "dockerfile",
        "terraform",
        "hcl",
      })
    end,
  },

  -- ========================
  -- Mason (LSP + DAP)
  -- ========================
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP
        "bash-language-server",
        "gopls",
        "pyright",
        "ansible-language-server",

        -- format / lint
        "stylua",
        "shfmt",
        "shellcheck",
        "yamllint",
        "ansible-lint",

        -- DAP
        "debugpy",
        "bash-debug-adapter",
        "js-debug-adapter",
      },
    },
  },

  -- ========================
  -- DAP Core
  -- ========================
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "DAP Continue",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "DAP Step Over",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "DAP Step Into",
      },
      {
        "<F12>",
        function()
          require("dap").step_out()
        end,
        desc = "DAP Step Out",
      },
      {
        "<leader>b",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Breakpoint",
      },
      {
        "<leader>B",
        function()
          require("dap").set_breakpoint(vim.fn.input("Condition: "))
        end,
        desc = "Conditional Breakpoint",
      },
    },
  },

  -- ========================
  -- DAP UI
  -- ========================
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -- ========================
  -- Python Debug
  -- ========================
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    config = function()
      require("dap-python").setup("python")
    end,
  },

  -- ========================
  -- Go Debug (Delve)
  -- ========================
  {
    "mfussenegger/nvim-dap",
    ft = "go",
    config = function()
      local dap = require("dap")

      dap.adapters.go = {
        type = "server",
        port = "${port}",
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
        },
      }

      dap.configurations.go = {
        {
          type = "go",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
        {
          type = "go",
          name = "Debug test",
          request = "launch",
          mode = "test",
          program = "${file}",
        },
      }
    end,
  },

  -- ========================
  -- Bash Debug
  -- ========================
  {
    "mfussenegger/nvim-dap",
    ft = "sh",
    config = function()
      local dap = require("dap")

      dap.adapters.sh = {
        type = "executable",
        command = "bash-debug-adapter",
      }

      dap.configurations.sh = {
        {
          type = "sh",
          request = "launch",
          name = "Launch Bash script",
          program = "${file}",
        },
      }
    end,
  },
}
