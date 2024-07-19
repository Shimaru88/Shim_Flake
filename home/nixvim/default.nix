{pkgs, ...}: {
  imports = [
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes = {
      tokyonight = {
        enable = true;
        settings = {
          style = "night";
        };
      };
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    opts = {
      number = true;
      relativenumber = true;

      clipboard = "unnamedplus";
      breakindent = true;
      undofile = true;
      ignorecase = true;
      smartcase = true;

      signcolumn = "yes";

      updatetime = 250;

      splitright = true;
      splitbelow = true;

      inccommand = "split";

      cursorline = true;

      scrolloff = 10;

      hlsearch = true;

      tabstop = 2;
      softtabstop = 2;
      showtabline = 2;
    };

    keymaps = [
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
      }
      {
        mode = "n";
        key = "-";
        action = "<CMD>Oil<CR>";
      }
      {
        mode = "n";
        key = "<leader>fm";
        action = "<CMD>lua vim.lsp.buf.format()<CR>";
      }
    ];

    plugins = {
      sleuth = {
        enable = true;
      };

      comment = {
        enable = true;
      };

      todo-comments = {
        enable = true;
        signs = true;
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      nvim-web-devicons
    ];

    extraConfigLuaPre = ''
      require('nvim-web-devicons').setup {}
    '';

    extraConfigLuaPost = ''
      -- vim: ts=2 sts=2  sw=2 et
    '';
  };
}
