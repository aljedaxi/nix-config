{
  description = "daxiin system config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
  };

  outputs = inputs@{ nixpkgs, home-manager,... }:
	let
		system = "x86_64-linux";
	in {
		nixosConfigurations = {
			fenrir = nixpkgs.lib.nixosSystem {
				inherit system;
				modules = [
					./configuration.nix
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.daxi = import ./home.nix;
					}
				];
			};
		};
	};
}
