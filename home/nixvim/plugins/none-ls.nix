{ config, pkgs, inputs, ... }:

{
  programs.nixvim = {
    plugins.none-lsp = {
      enable = true;
      enableLspFormat = true;
    };
  };
}
