{ config, pkgs, ... }:
{
	home = {
		username = "daxi";
		homeDirectory = "/home/daxi";
		stateVersion = "24.05";
		file = {
			"sd/mac/lain-say" = {
				executable = true;
				text = ''outfile=$1
toSay=$2
say -r 125 -v whisper -o $outfile.aiff $toSay
ffmpeg -i $outfile.aiff -f mp3 -acodec libmp3lame -ab 192000 -ar 44100 $outfile.mp3
rm $outfile.aiff
open $outfile.mp3'';
			};
			"sd/nix/gc"	= { executable = true; text = "nix-collect-garbage -d"; };
			"sd/nix/search"	= { executable = true; text = ''surf "https://search.nixos.org/packages?channel=24.05&from=0&size=50&sort=relevance&type=packages&query=$@"''; };
			"sd/nix/update"	= { executable = true; text = ''pushd /etc/nixos
sudo nix flake update && sudo nixos-rebuild switch
popd''; };
			"sd/doom/install" = { executable = true; text = "git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs && ~/.config/emacs/bin/doom install"; };
			"sd/doom/run" = { executable = true; text = "~/.config/emacs/bin/doom run $@"; };
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
