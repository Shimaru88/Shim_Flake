{
	pkgs,
	email,
	username,
	stateVersion,
	...
}: {
	imports = [
		../neovim.nix
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

	]

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
}
