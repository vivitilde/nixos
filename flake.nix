{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

     home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
     };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
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
          #./home-manager/home.nix
        ];
      };
      umbra = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs ; };
	    modules = [
          ./host/umbra/configuration.nix
	      #inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
