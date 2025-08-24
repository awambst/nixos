{
  description = "My NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/25.05";
    flake-waybar = {
      url = "git+https://gitea.napo280.fr/napo280/overlay-waybar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "git+https://github.com/nix-community/nixvim.git"; # ?rev=ab1b5962e1ca90b42de47e1172e0d24ca80e6256";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
    swww = {
      url = "github:LGFae/swww"; # /v0.10.3";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
    #home-manager = {
    #url = "github:nix-community/home-manager";
    #inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      info = import ./info.nix;
    in
    {
      nixosConfigurations."${info.hostname}" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit system;
        };
        modules = [
          inputs.nixvim.nixosModules.nixvim
          inputs.flake-waybar.nixosModules.waybar
          
          ./modules/firefox.nix
          ./modules/packages.nix
          ./modules/services.nix
          ./modules/programs.nix
          ./modules/other.nix
          ./modules/neovim
          ./modules/swww

          ./configuration.nix
        ];
      };
    };
}
