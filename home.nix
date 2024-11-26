{ config, pkgs, ... }:
{
	home.username = "daxi";
	home.homeDirectory = "/home/daxi";
	home.stateVersion = "24.05";
	programs.zsh = {
		shellAliases = {
			ll = "ls -l";
			please = "sudo";
			vi = "vim";
		};
	};
	xdg = {
		enable = true;
		configFile = {
			"sx/sxrc" = {
				text = ''picom --backend xrender &
dunst &
hsetroot -cover /etc/nixos/forest.png
dwm'';
				executable = true;
			};
		};
	};
	programs.home-manager = {
		enable = true;
	};
}
