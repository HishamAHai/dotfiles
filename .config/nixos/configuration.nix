# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:
let
home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
in

{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		./home.nix
		(import "${home-manager}/nixos")
		];

	fileSystems = {
		"/".options = [ "compress=zstd" ];
		"/home".options = [ "compress=zstd" ];
		"/nix".options = [ "compress=zstd" "noatime" ];
	};

# nvidia drivers
	nixpkgs.config.allowUnfree = true;
# Make sure opengl is enabled
	hardware = {
		pulseaudio.enable = false;
		bluetooth.enable = true;
		opengl = {
			enable = true;
			driSupport = true;
		};
		nvidia = {
			modesetting.enable = true;
			open = false;
			nvidiaSettings = true;
			package = config.boot.kernelPackages.nvidiaPackages.stable;
			forceFullCompositionPipeline = true;
		};
		nvidia.prime = {
		#sync.enable = true;
			offload = {
				enable = true;
				enableOffloadCmd = true;
			};
			intelBusId = "PCI:0:2:0";
			nvidiaBusId = "PCI:1:0:0";
		};
		logitech = {
			wireless.enable = true;
			wireless.enableGraphical = true;
		};
	};

# Use grub
	boot.loader = {
		grub = {
			enable = true;
			efiSupport = true;
			device = "nodev";
			gfxmodeEfi = "text";
			gfxmodeBios = "text";
		};
		efi.canTouchEfiVariables = true;
	};

	networking = {
		hostName = "laptop";
		networkmanager.enable = true;
	};

# Set your time zone.
	time.timeZone = "America/Argentina/Buenos_Aires";

# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";
	console = {
		font = "Lat2-Terminus16";
		keyMap = "la-latin1";
	};

# Enable the X11 windowing system.
	services.xserver = {
# Tell Xorg to use the nvidia driver (also valid for Wayland)
		videoDrivers = ["nvidia"];
		enable = true;

		desktopManager.runXdgAutostartIfNone = true;
		displayManager = {
			sddm = {
				enable = true;
				settings = {
					Theme = {
						CursorTheme = "macOS-Monterey";
					};
				};
			};
			#defaultSession = "none+awesome";
			defaultSession = "none+openbox";
			};

		#windowManager.awesome = {
		#	enable = true;
		#	luaModules = with pkgs.luaPackages; [
		#		lgi
		#			luarocks
		#			luadbi-mysql
		#	];
		#};
		windowManager.openbox.enable = true;
		libinput = {
			enable = true;
			touchpad = {
				naturalScrolling = true;
				tapping = true;
			};
		};
# Configure keymap in X11
		layout = "latam,ara";
		xkbVariant = "deadtilde";
		xkbModel = "pc104";
		xkbOptions = "grp:alt_shift_toggle";
	};

# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.hisham = {
		isNormalUser = true;
		initialPassword = "password";
		extraGroups = [ "wheel" "networkmanager" "video" "audio" "libvirtd" ]; # Enable ‘sudo’ for the user.
			shell = pkgs.zsh;
	};
	programs = { 
		zsh = {
			enable = true;
			syntaxHighlighting = {
				enable = true;
			};
		};
		nm-applet.enable = true;
		dconf.enable = true;
	};

# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
		firefox
		brave
		opencl-info
		solaar
		gnome.adwaita-icon-theme
		nitrogen
		qbittorrent
		libreoffice-fresh
		kitty
		exa
		obs-studio
		ffmpeg_6-full
		ffmpegthumbnailer
		pcmanfm
		htop
		neofetch
		duf
		du-dust
		feh
		sxiv
		lf
		copyq
		carla
		arandr
		aria
		bat
		neovim
		bash-completion
		git
		wget
		curl
		gawk
		gimp
		czkawka
		gparted
		jdk
		file
		lxappearance
		xorg.xcursorthemes
		gnome.adwaita-icon-theme
		apple-cursor
		adwaita-qt
		adwaita-qt6
		papirus-icon-theme
		qemu_kvm
		qemu
		libvirt
		virt-manager
		dconf
		apparmor-utils
		apparmor-parser
		apparmor-profiles
		qgnomeplatform
		qgnomeplatform-qt6
		adwaita-qt
		adwaita-qt6
		libsForQt5.qtstyleplugin-kvantum
		libsForQt5.qt5ct
		qt5ct
		luajit
		gcc
		dmenu
		tint2
		xorg.xbacklight
		udiskie
		dunst
		flameshot
		nextcloud-client
			];
	nixpkgs.overlays = [
		(final: prev: {
		 dmenu = prev.dmenu.overrideAttrs (old: { src = /home/hisham/dmenu ;});
		 })
	];

# virtualisation with libvirt
	virtualisation.libvirtd.enable = true;
	boot.kernelModules = [ "kvm-amd" "kvm-intel" ];

	# Use virtual camera in OBS
	boot.extraModulePackages = with config.boot.kernelPackages; [
		v4l2loopback
	];

# Compositor
	services.picom = {
		enable = true;
		backend = "glx";
		fade = false;
		shadow = false;
		vSync = true;
		settings = {
			blur = {
			          method = "dual_kawase";
			          strength = 6;
			          background = true;
			          background-frame = false;
			          background-fixed = false;
			      };
		};
	};
# List services that you want to enable:

# Services
	services.openssh.enable = true;
	services.flatpak.enable = true;
	services.dbus.enable = true;
	xdg.portal = {
		enable = true;
		extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
	};
# Enable sound.
# sound.enable = true;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		pulse.enable = true;
		jack.enable = true;
	};
# Enable polkit.
	security.polkit.extraConfig = ''
		polkit.addRule(function(action, subject) {
				if (
						subject.isInGroup("users")
						&& (
							action.id == "org.freedesktop.login1.reboot" ||
							action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
							action.id == "org.freedesktop.login1.power-off" ||
							action.id == "org.freedesktop.login1.power-off-multiple-sessions" ||
						   )
				   )
				{
				return polkit.Result.YES;
				}
				})
	'';
	systemd = {
		user.services.polkit-gnome-authentication-agent-1 = {
			description = "polkit-gnome-authentication-agent-1";
			wantedBy = [ "graphical-session.target" ];
			wants = [ "graphical-session.target" ];
			after = [ "graphical-session.target" ];
			serviceConfig = {
				Type = "simple";
				ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
				Restart = "on-failure";
				RestartSec = 1;
				TimeoutStopSec = 10;
			};
		};
	};

# Fonts.
	fonts.fontDir.enable = true;
	fonts.fonts = with pkgs; [
		noto-fonts
			noto-fonts-cjk
			noto-fonts-emoji
			liberation_ttf
			font-awesome
			cantarell-fonts
			redhat-official-fonts
			dejavu_fonts
			(nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
	];

# Enable apparmor
	security.apparmor.enable = true;
	security.audit.enable = true;

# Gnome keyring
	services.gnome.gnome-keyring.enable = true;
	programs.seahorse.enable = true;

# power-profiles
	services.power-profiles-daemon.enable = true;

# udisk mounting
	services.udisks2 = {
		enable = true;
		mountOnMedia = true;
	};

# gtk and qt themes
	qt = {
		enable = true;
		platformTheme = "gnome";
		style = "adwaita-dark";
	};
	environment.pathsToLink = [ "/share/zsh" ];

# Faster shutdown and reboot
systemd.extraConfig = ''
DefaultTimeoutStopSec=10s
DefaultDeviceTimeoutStopSec=10s
'';


# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

	system.stateVersion = "23.05"; # Did you read the comment?

}

