{ config, pkgs, ... }:
{
home-manager.users.hisham = {
	home.stateVersion = "23.05";
	home.packages = with pkgs; [
	];
	gtk = {
		enable = true;
		cursorTheme = {
			name = "macOS-Monterey";
			package = pkgs.apple-cursor;
		};
		iconTheme = {
			name = "Papirus";
			package = pkgs.papirus-icon-theme;
		};
		theme = {
			name = "Orchis-Purple-Dark";
			package = pkgs.orchis-theme;
		};
		font = {
			name = "Red Hat Display 11";
			package = pkgs.redhat-official-fonts;
		};
		gtk3.extraConfig = {
			gtk-application-prefer-dark-theme=1;
			gtk-xft-antialias = 1;
			gtk-xft-hinting = 1;
			gtk-xft-hintstyle = "hintfull";
			gtk-xft-rgba = "rgb";
		};
	};
	programs.kitty = {
		enable = true;
		font = {
			name = "FantasqueSansM Nerd Font";
			size = 14;
		};
		theme = "Material Dark";
		settings = {
			background_opacity = "0.9";
		};
	};
	programs.zsh = {
		enable = true;
		autocd = true;
		enableAutosuggestions = true;
		defaultKeymap = "viins";
		dotDir = ".config/zsh";
		history = {
			path = ".cache/zsh/history";
			save = 20000;
			size = 20000;
		};
		completionInit = ''
			autoload -Uz compinit
			compinit
		'';
		historySubstringSearch = {
			enable = true;
			searchDownKey = [ "^[[A" "^P" ];
			searchUpKey = [ "^[[B" "^N" ];
		};
		envExtra = '' 
			export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
			export PATH=$HOME/.local/bin:$HOME/.bin:$PATH
		'';
		initExtraBeforeCompInit = ''
			zstyle ':completion:*' completer _menu _expand _complete _correct _approximate
			zstyle ':completion:*' completions 0
			zstyle ':completion:*' glob 0
			zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
			zstyle ':completion:*' max-errors 10
			zstyle ':completion:*' special-dirs true
			zstyle ':completion:*' substitute 1
			zstyle :compinstall filename '/home/hisham/.config/zsh/.zshrc'
		'';
	};
	home.shellAliases = {
	ls = "exa -lag --color=always --group-directories-first --icons --color-scale";
	grep = "grep --color=always";
	du = "dust -r";
	df = "df -h";
	cd = "z";
	v = "nvim";
	sduo = "sudo";
	suod = "sudo";
	};
	programs.zoxide = {
	enable = true;
	};
	programs.starship = {
	enable = true;
	};
	programs.tint2.enable = true;
	programs.mpv = {
		enable = true;
		config = {
			"osd-font" = "UbuntuMono Nerd Font";
			"osd-font-size" = "14";
			"osd-bar-align-y" = "0.95";
			"osd-on-seek" = "msg-bar";
			"osd-bold" = "no";
			"osd-border-size" = "0";
			"osd-back-color" = "#4f1b1d1e";
			"osd-color" = "#ffffff";
			"osd-duration" = "3000";
			"osd-level" = "3";
		};
		bindings = {
			"j" = "seek 5";
			"h" = "seek -5";
			"Ctrl+j" = "seek 30";
			"Ctrl+h" = "seek -30";
		};
	};
	services.copyq = {
		enable = true;
	};
	services.dunst = {
		enable = true;
		iconTheme = {
			name = "Papirus";
			size = "24";
			package = pkgs.papirus-icon-theme;
			};
		settings = {
			global = {
				width = 300;
				height = 150;
				offset = "10x30";
				origin = "bottom-right";
				font = "Red Hat Display 10";
				frame_width = 1;
				gap_size = 2;
				transparency = 20;
				background = "#2d2d2d";
				};
			};
		};
	xresources.properties = {
		"Xcursor.theme" = "macOS-Monterey";
		"Xft.dpi" = "120";
	};
	xdg.userDirs = {
		enable = true;
		createDirectories = true;
	};
};
}
