{
  description = "daxiin system config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};
  };

  outputs = { self, nixpkgs, home-manager, ... }:
	let
		inherit (self) outputs;
	in {
		nixosConfigurations = {
			fenrir = nixpkgs.lib.nixosSystem {
				modules = [
					./configuration.nix
				];
			};
		};
	};
}
