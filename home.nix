{ config, pkgs, ... }:

{
  home.username = "spent";
  home.homeDirectory = "/home/spent";



  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    neofetch
    btop  # replacement of htop/nmon
    quarto

  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "KhalilAMARDJIA";
    userEmail = "khalil.amardjia@gmail.com";
  };

  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
