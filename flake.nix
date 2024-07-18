{
	description = "Shimaru's Flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nixvim = {
			url = "github:nix-community/nixvim";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, nixvim } @ inputs: let 
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
				modules = [ ./nixos/${desktop}/configuration.nix ];
			};

			${laptop} = nixpkgs.lib.nixosSystem {
				specialArgs = let hostname = "${laptop}"; in {
					inherit inputs self username system stateVersion email hostname;
				};
				modules = [ ./nixos/${laptop}/configuration.nix ];
			};
		};


		homeConfigurations = {
			"${username}@${desktop}" = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ ./home/${desktop}/home.nix nixvim.homeManagerModules.nixvim ];
				extraSpecialArgs = let hostname = desktop; in {
					inherit self inputs username hostname system stateVersion email;
				};
			};
			"${username}@${laptop}" = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ ./home/${laptop}/home.nix nixvim.homeManagerModules.nixvim ];
				extraSpecialArgs = let hostname = laptop; in {
					inherit self inputs username hostname system stateVersion email;
				};
			};
		};
	};
}
