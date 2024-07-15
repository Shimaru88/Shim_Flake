{ pkgs, ... }:
{
	xdg.configFile.nvim.source = ../nvim;
	home.sessionVariables = {
		EDITOR = "nvim";
		VISUAL = "nvim";
	};
	programs.neovim = {
		enable = true;
		viAlias = true;
		vimAlias = true;

		extraPackages = with pkgs; [
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
	};
}
