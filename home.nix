{ config, pkgs, ... }:
{
	home = {
		username = "daxi";
		homeDirectory = "/home/daxi";
		stateVersion = "24.05";
		file = {
			sd = { source = ./sd; executable = true; };
			".zshrc" = {
				text = ''
export EDITOR=vi
export PROMPT="%F{175}%2~ %(?.%F{white}.%F{red})> "
export KEYTIMEOUT=1
export PATH="$PATH:/Users/daxi/.deno/bin:$HOME/.sh:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:/usr/local/opt/gnu-sed/libexec/gnubin:$HOME/.deno/bin:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/platform-tools:/usr/local/anaconda3/bin"
unsetopt beep
bindkey -v
export KEYTIMEOUT=1
'';
			};
		};
	};
	programs = {
		script-directory = {
			enable = true;
			settings = { SD_CAT = "ponysay"; SD_ROOT = "${config.home.homeDirectory}/.config/sd"; };
		};
		zsh = {
			initExtra = ''fpath+="${pkgs.script-directory}/share/zsh/site-functions'';
			shellAliases = {
				ll = "ls -l";
				please = "sudo";
				vi = "vim";
			};
		};
		home-manager = {
			enable = true;
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
			doom = { source = ./doom; };
		};
	};
}
