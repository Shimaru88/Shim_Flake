{
  pkgs,
  email,
  username,
  stateVersion,
  ...
}: {
  imports = [
    ../nixvim
    ../common/zsh.nix
    ../common/eza.nix
    ../common/git.nix
    ../common/kitty.nix
    ../common/tmux.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "${stateVersion}";
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    gcc
    unzip
    wget
    curl
    ripgrep
    fd

    nil
    lua-language-server
    stylua
    alejandra
  ];

 programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
