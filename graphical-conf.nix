{ config, pkgs, ... }:
{
	services.xserver = {
		enable = true;
		windowManager.dwm = {
			enable = true;
			package = pkgs.dwm.override {
				patches = [ ./patches/dwm-borderless-1.0.0.diff ];
			};
		};
		displayManager.sx.enable = true;
    xkb.layout = "us";
    xkb.variant = "colemak";
  # xkb.options = "eurosign:e,caps:escape";
	};
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

	nixpkgs.config.permittedInsecurePackages = [ "electron-27.3.11" ]; # needed for logseq >~<
  environment.systemPackages = with pkgs; [
		hsetroot
		(st.overrideAttrs (oldAttrs: rec {
			patches = [
				./patches/st-alpha-20220206-0.8.5.diff
			];
		}))
		surf
		dmenu
		dunst
		pulsemixer
		picom
		scrot
		firefox
		telegram-desktop
		logseq
		neofetch
  ];
}
