
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.colorscheme = "citruszest"
vim.opt.relativenumber = true

-- Enable powershell as your default shell
vim.opt.shell = "pwsh.exe -NoLogo"
vim.opt.shellcmdflag =
"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.cmd [[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
  ]]

-- Set a compatible clipboard manager
vim.g.clipboard = {
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
}


------------------------
-- Setup Plugins
------------------------
lvim.plugins = {
  "olexsmir/gopher.nvim",
  "leoluz/nvim-dap-go",
  {
    "zootedb0t/citruszest.nvim",
    config = function()
      require("citruszest").setup({
        style = {
          MatchParen = { bg = "#BFBFBF", bold = true }
        }
      })
    end
  },
  {
    "rmagatti/goto-preview",
    config = function()
      require('goto-preview').setup {
        default_mappings = true,
      }
    end
  },
  {
    "nvim-telescope/telescope-project.nvim",
    event  = "BufWinEnter",
    config
           = function()
      require('telescope').load_extension("project")
    end,
  },
  {
    'nvim-orgmode/orgmode',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter', lazy = true },
    },
    event = 'VeryLazy',
    config = function()
      -- Load treesitter grammar for org
      require('orgmode').setup_ts_grammar()

      -- Setup treesitter
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { 'org' },
        },
        ensure_installed = { 'org' },
      })

      -- Setup orgmode
      require('orgmode').setup({
        org_agenda_files = '~/orgfiles/**/*',
        org_default_notes_file = '~/orgfiles/refile.org',
      })
    end,
  }
}

------------------------
-- Key Mapping
------------------------

lvim.builtin.which_key.mappings["sp"] = {
  "<CMD>lua require'telescope'.extensions.project.project{}<CR>", "Search Projects"
}

lvim.builtin.which_key.mappings['w'] = {
  name = "Window",
  h = { "<cmd>split<CR>", "Split Window Horizontally" },
  v = { "<cmd>vsplit<CR>", "Split Window Vertically" },
  n = { "<C-w>h", "Move To Left Window" },
  i = { "<C-w>l", "Move To Right Window" },
  u = { "<C-w>k", "Move To Above Window" },
  e = { "<C-w>j", "Move To Below Window" },
}

------------------------
-- Telescope
------------------------
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, "telescope-project")
end
