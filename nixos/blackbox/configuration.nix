{
  pkgs,
  hostname,
  username,
  stateVersion,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./gaming.nix
    ../common/common_pkgs.nix
    ../common/nvidia.nix
    ../common/locale.nix
    ../common/boot.nix
    ../common/sound.nix
  ];

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" "@wheel"];
    };
  };

  # Enable networking
  networking = {
    networkmanager.enable = true;
    hostName = "${hostname}";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "se";
    variant = "";
    options = "Caps_Lock=Escape";
  };

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  users.users."${username}" = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = ["networkmanager" "wheel"];
  };

  programs.git.enable = true;
  programs.zsh.enable = true;
  hardware.ckb-next.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "${stateVersion}";
}
