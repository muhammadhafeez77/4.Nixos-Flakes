{ config, lib, pkgs, ... }:

let 
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
	(import "${home-manager}/nixos")
    ];

  # Home Manager
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.coffee = import ./home.nix;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Network Manager ( For WIFI )
  networking.hostName = "nixos-btw"; # Hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Karachi"; # CHange time for your secific zone

  # Enable the X11 windowing system.
  services.xserver = {
	enable=true;
	windowManager.qtile.enable = true;
	displayManager.sessionCommands = ''
	xset r rate 200 35 &
	'';
 };
  
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.coffee = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
   };

   programs.firefox.enable = true;

  # List packages installed in system profile.
  # To search for packages , run ,  nix search wget
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
        vim-full 
	neovim
	alacritty
        wget
   	fastfetch
	htop
	btop
	sl
	cmatrix
	cbonsai
	git 
	tealdeer
	xclip 
	maim	
	slop
	bat 
	tree
	fzf
	killall
	ranger
	thunar	 
	xwallpaper
	rofi
	picom
	mousepad
	unzip
	python3
	gcc
	
   ];

  # Add Fonts
  fonts.packages = with pkgs; [
 	jetbrains-mono
   ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
	services.openssh = {
  	enable = true;
  	settings = {
    	X11Forwarding = false;
    		PermitRootLogin = "yes"; 
    		PasswordAuthentication = true; 
       };
   };

  #Set FZF as Reverse search in terminal
  programs.bash.interactiveShellInit = ''
  source ${pkgs.fzf}/share/fzf/completion.bash
  source ${pkgs.fzf}/share/fzf/key-bindings.bash
    '';

  # So that sudo vim also yanks properly 
  security.sudo.extraConfig = ''
     Defaults env_keep += "DISPLAY XAUTHORITY"
    '';

  #Enable Picom for transparency 
  services.picom = {
	enable = true;
	backend = "glx";
	fade = true;
  };

  # ============ Pushing all the things i dont need for the moment at bottom . It'll be a hassle to write them again. ==============

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;


  # ===============================================================          ================================================================== 
  
  # https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment? Probably :)

}

