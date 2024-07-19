{ config, pkgs, inputs, ... }:

{
  programs.nixvim = {
    plugins.oil = {
      enable = true;
    };
  };
}
