# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "fenrir"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "US/Mountain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "colemak";
    # useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.

  # Define a user account. Don't forget to set a password with ‘passwd’.
	environment.shells = with pkgs; [ zsh ];
	users = {
		users.daxi = {
			isNormalUser = true;
			extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
		};
	};
	users.defaultUserShell = pkgs.zsh;
	programs.zsh = { enable = true; };
	programs.git = {
		enable = true;
		config = {
			init.defaultBranch = "main";
			safe.directory = "/etc/nixos";
			user.name = "aljedaxi";
			user.email = "aljedaxi@pm.me";
		};
	};
	nixpkgs.overlays = [
		(import (builtins.fetchTarball {
			url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
			sha256 = "sha256:1r1jivryhbw43acypd53czz75z59ansb0g22c7cs5z9hfa0qiidp";
		}))
		# (import (pkgs.fetchFromGitHub {
			# user = "nix-community";
			# repo = "emacs-overlay";
			# rev = "7a58ace151bf1939308680f37db100b00769c318";
			# url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
			# sha256 = "sha256:1dnlckw7jrxw7r6sb9accsnsp7wy488fqs5xa7mxkkj7vaa2263c";
		# }))
	];
	services.emacs = {
		package = pkgs.emacs-git;
		startWithGraphical = true;
		enable = true;
		defaultEditor = true;
	};
	services.pipewire = {
	  enable = true;
	  pulse.enable = true;
	};
	environment.systemPackages = with pkgs; [ vim fzf ripgrep ponysay coreutils fd clang ];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}

