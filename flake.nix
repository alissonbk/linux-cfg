{
  description = "VM";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";      
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      self,
      ...
    }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      username = "alissonbk";
    in
    {
      homeConfigurations."alissonbk" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;          
        };

        modules = [
          ./home.nix
        ];
      };
    };
}
