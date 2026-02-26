{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    font-awesome_7
    powerline-fonts
    powerline-symbols
    nerd-fonts._3270
    nerd-fonts.code-new-roman
    nerd-fonts.comic-shanns-mono
    nerd-fonts.cousine
    nerd-fonts.d2coding
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    nerd-fonts.monaspace
    nerd-fonts.overpass
    nerd-fonts.roboto-mono
    nerd-fonts.symbols-only
    nerd-fonts.terminess-ttf
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-mono
    nerd-fonts.ubuntu-sans
  ];
}
