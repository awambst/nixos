{
  description = "My NixOS flake";

  inputs = {
    #    nixpkgs.url = "github:NixOS/nixpkgs/26.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
    serein = {
      url = "github:ViceVerse-cz/Serein";
      #      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      info = import ./info.nix;
      inherit (nixpkgs) lib;
      modulesDir = ./modules;

      # Equivalent to ./modules/**/*.nix
      allModules = lib.filter (lib.hasSuffix ".nix") (
        lib.filesystem.listFilesRecursive ./modules
      );
    in
    {
      nixosConfigurations."${info.hostname}" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit system;
          inherit info;
          inherit nixpkgs-unstable;
        };

        modules = [
          ./configuration.nix
        ]
        ++ allModules;
      };
    };
}
