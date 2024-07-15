{ pkgs, ... }:

{
  programs.zsh = {
	enable = true;
	enableCompletion = true;
autosuggestions.enable = true;
oh-my-zsh = {
	enable = true;
	theme = "robbyrussell";
	plugins = [
		"git"
		"vi-mode"
	];
};
  };
}
