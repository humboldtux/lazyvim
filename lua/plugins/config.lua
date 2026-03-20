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
      {
        "<leader>-",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open Yazi",
      },
      {
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Yazi (cwd)",
      },
    },
    opts = {
      open_for_directories = false,
    },
  },

  -- ========================
  -- Treesitter (langages utiles)
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
  -- Mason (tools système)
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
      },
    },
  },
}
