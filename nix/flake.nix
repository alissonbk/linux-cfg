{
  description = "VM";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
      apps.${system} = {
        default = {
          type = "app";
          program = "${self.nixosConfigurations.vm.config.system.build.vm}/bin/run-nixos-vm";
        };
      };
      nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./vm.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home.nix;
          }
        ];
      };
    };
}
