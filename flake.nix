{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-quartus.url = "github:nixos/nixpkgs/nixos-22.05";

     home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
     };
  };

  outputs = { self, nixpkgs, nixpkgs-quartus, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    oldpkgs = inputs.nixpkgs-quartus.legacyPackages.${system};
  in
  {
    nixosConfigurations = {
      astra = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs ; };
        modules = [
          ./configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
