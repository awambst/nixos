{
  description = "My NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
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
          ./modules/sops.nix
          ./modules/packages.nix
          ./modules/services.nix
          ./modules/programs.nix
          ./modules/other.nix
          ./modules/nitrokey.nix

          ./modules/net.nix
          ./modules/fonts.nix
          ./modules/nvidia.nix
          ./modules/libinput.nix
          #./modules/discord.nix

          #./modules/swww

          ./configuration.nix
        ];
      };
    };
}
