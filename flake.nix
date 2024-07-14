{
  description = "Shimaru's Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
	url = "github:nix-community/home-manager";
	inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager } @ inputs: let 
	pkgs = import nixpkgs {
		inherit system;
		config = {
			allowUnfree = true;
			allowUnfreePredicate = _: true;
		};
	};
	stateVersion = "24.05";
	username = "shimaru";
	desktop = "blackbox";
	laptop = "thinkbox";
	system = "x86_64-linux";
	email = "";
  in {
	nixosConfigurations = {
		${desktop} = nixpkgs.lib.nixosSystem {
			specialArgs = let hostname = "${desktop}"; in {
				inherit inputs self username system stateVersion email hostname;
			};
			modules = [ ./modules/${desktop}/configuration.nix ];
		};
	};

	homeConfigurations = {
		"${username}@${desktop}" = home-manager.lib.homeManagerConfiguration {
			inherit pkgs;
			modules = [ ./modules/${desktop}/home.nix ];
			extraSpecialArgs = let hostname = desktop; in {
				inherit self inputs username hostname system stateVersion email;
			};
		};
	};
  };
}
