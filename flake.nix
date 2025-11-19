{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, spicetify-nix, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    #stablepkgs = nixpkgs-stable.legacyPackages.${system};
    spicePkgs = spicetify-nix.legacyPackages.${system};
  in
  {
    homeConfigurations."spectra" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home-manager/home.nix];
    };
    nixosConfigurations = {
      astra = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs ; };
        modules = [
          ./hosts/astra/configuration.nix
        ];
      };
      umbra = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs ; };
	    modules = [
            ./hosts/umbra/configuration.nix
        ];
      };
    };
  };
}
