{
  description = "daxiin system config";

  inputs = {
  	nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  	catppuccin.url = "github:catppuccin/nix";
  	community-emacs.url = "github:nix-community/emacs-overlay";
  	home-manager = {
  		url = "github:nix-community/home-manager";
  		inputs.nixpkgs.follows = "nixpkgs";
  	};
  };

  outputs = inputs@{ nixpkgs, catppuccin, community-emacs, home-manager,... }:
	let
		system = "x86_64-linux";
		pkgs = import nixpkgs {
			inherit system;
			overlays = [ community-emacs.overlays.emacs ];
		};
		emacs = {
			services.emacs = {
				package = pkgs.emacs-git;
				enable = true;
				defaultEditor = true;
			};
		};
		home = {
			catppuccin.flavor = "mocha";
			catppuccin.enable = true;
			home-manager.useGlobalPkgs = true;
			home-manager.useUserPackages = true;
			home-manager.users.daxi = {
				imports = [
					./home.nix
					catppuccin.homeManagerModules.catppuccin
				];
			};
		};
	in {
		nixosConfigurations = {
			urthr = nixpkgs.lib.nixosSystem {
				inherit system;
				modules = [
					{
						networking.hostName = "urthr";
					}
					./urthr-hardware.nix
					./configuration.nix
					./graphical-conf.nix
					catppuccin.nixosModules.catppuccin
					home-manager.nixosModules.home-manager
					home
				];
			};
			fenrir = nixpkgs.lib.nixosSystem {
				inherit system;
				modules = [
					{
						networking.hostName = "fenrir";
					}
					./fenrir-hardware.nix
					./configuration.nix
					./graphical-conf.nix
					catppuccin.nixosModules.catppuccin
					home-manager.nixosModules.home-manager
					home
					emacs
				];
			};
		};
	};
}
