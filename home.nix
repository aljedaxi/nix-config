{ config, pkgs, ... }:
{
	home = {
		username = "daxi";
		homeDirectory = "/home/daxi";
		stateVersion = "24.05";
		file = {
			sd = {
                source = builtins.fetchGit {
                    url = "https://github.com/aljedaxi/sd";
                    # TODO i don't much like this rev business. but it'll do.
                    rev = "f77c0cd9b7940be0c65e36d6e4345b7afa5fd31b";
                };
                executable = true;
            };
			".zshrc" = {
				text = ''
export EDITOR=vi
export PROMPT="%F{175}%2~ %(?.%F{white}.%F{red})> "
export KEYTIMEOUT=1
export PATH="$PATH:/Users/daxi/.deno/bin:$HOME/.sh:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:/usr/local/opt/gnu-sed/libexec/gnubin:$HOME/.deno/bin:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/platform-tools:/usr/local/anaconda3/bin"
unsetopt beep
bindkey -v
export KEYTIMEOUT=1'';
			};
		};
	};
	programs = {
		script-directory = {
			enable = true;
			settings = { SD_CAT = "ponysay"; };
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
			"user-dirs.dirs" = {
				text = ''XDG_DOWNLOAD_DIR="$HOME/tmp"
XDG_MUSIC_DIR="$HOME/mu"'';
			};
			"sx/sxrc" = {
				text = ''picom --backend xrender &
dunst &
hsetroot -cover $HOME/.config/nixos/forest.png
dwm'';
				executable = true;
			};
			doom = {
                source = builtins.fetchGit {
                    url = "https://github.com/aljedaxi/doom";
                    # TODO i don't much like this rev business. but it'll do.
                    rev = "bb3a024c2d0c4bad248bf775eb49e6edcbf2811e";
                };
            };
		};
	};
}
