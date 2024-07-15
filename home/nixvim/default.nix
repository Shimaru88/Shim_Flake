{ config, pkgs, inputs, ... }:

{
  imports = [];

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

      have_nerd_font = true;
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
    };

    keymaps = [
      {
        mode = "n";
        key  = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
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
      
    ];

    extraConfigLuaPre = ''
      require('nvim-web-devicons').setup {}
    '';

    extraConfigLuaPost = ''
      -- vim: ts=2 sts=2  sw=2 et
    '';
  };
}
