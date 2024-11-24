{
  description = "daxiin system config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
	let
		system = "x86_64-linux";
		inherit (self) outputs;
		lib = nixpkgs.lib;
		pkgs = nixpkgs.legacyPackages.${system};
	in {
		nixosConfigurations = {
			fenrir = nixpkgs.lib.nixosSystem {
				inherit system;
				modules = [ ./configuration.nix ];
			};
		};
	};
}
