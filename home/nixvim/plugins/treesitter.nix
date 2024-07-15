{ config, pkgs, inputs, ... }:

{
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;

      ensureInstalled = [
        "bash"
        "c"
        "diff"
        "html"
        "lua"
        "luadoc"
        "markdown"
        "nix"
        "go"
        "gomod"
        "gowork"
      ];

      highlight = {
        enable = true;
      };

      indent = {
        enable = true;
      };
    };
  };
}
