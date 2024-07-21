{...}: {
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font Mono";
      size = 14;
    };
    shellIntegration.enableZshIntegration = true;
    theme = "Monokai Soda";
  };
}
