{ pkgs, username, ... }:
{
	environment.systemPackages = with pkgs; [
		lua-language-server
		kitty
		neovim
		helix
		wget
		ripgrep
		cmake
		pciutils
		zellij
		zoxide
		fzf
		git
		eza
	];
	programs.nh = {
		enable = true;
		clean.enable = true;
		clean.extraArgs = "--keep-since 7d --keep 5";
		flake = "/home/${username}/.config/shim_flake/";
	};
	programs.thefuck = {
		enable = true;
		alias = "tf";
	};
}
