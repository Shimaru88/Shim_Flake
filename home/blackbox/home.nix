{
	pkgs,
	email,
	username,
	stateVersion,
	...
}: {
	imports = [
    #../neovim.nix
    ../nixvim
    ../common/zsh.nix
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
			git
			gcc
			unzip
			wget
			curl
			ripgrep
			fd
			fzf

			nil
			lua-language-server
			stylua
			alejandra
	];

	programs.git = {
		enable = true;
		userName = "Shimaru88";
		userEmail = "${email}";
	};
	programs.fzf = {
		enable = true;
		enableZshIntegration = true;
	};
	programs.eza = {
		enable = true;
		git = true;
		icons = true;
		extraOptions = [
			"--group-directories-first"
			"--header"
			"-o"
			"--no-permissions"
			"--hyperlink"
		];
	};
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
