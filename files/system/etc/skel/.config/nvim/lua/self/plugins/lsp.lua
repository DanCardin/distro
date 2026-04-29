return {
  {
    'neovim/nvim-lspconfig',
    config = function(_, opts)
      require('self.lsp').setup()
    end
  },
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    name = "lsp_lines",
    config = function()
      vim.diagnostic.config({ virtual_lines = true })
      require("lsp_lines").setup()
    end,
  },
  {
    "RishabhRD/nvim-lsputils",
    dependencies = { "RishabhRD/popfix" },
  },
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    event = "LspAttach",
    opts = {
      auto_preview = true,
      position = "center"
    },
  },
  {
    "ahmedkhalf/project.nvim",
    name = "project_nvim",
    event = "BufReadPre",
    opts = {
      detection_methods = { "pattern", "lsp" },
      patterns = {
        "Makefile",
        "package.json",
        ".venv",
        "pyproject.toml",
        ".git",
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
      },
    },
  },
  "lukas-reineke/lsp-format.nvim",
  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    lazy = false,
  },
}
