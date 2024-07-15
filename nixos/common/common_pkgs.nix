{ pkgs, username, ... }:
{
	environment.systemPackages = with pkgs; [
		lua-language-server
		kitty
		kitty-themes
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
		wl-clipboard
		(firefox.overrideAttrs (old: {
			buildCommand =
				old.buildCommand
				+ ''
					substituteInPlace $out/bin/firefox --replace "exec -a" "MOZ_ENABLE_WAYLAND=0 exec -a"
				'';
		}))
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

	fonts.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
	];
}
