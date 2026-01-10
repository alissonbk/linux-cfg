{
  description = "VM";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, self, ... }:
    let
      system = "x86_64-linux";
    in
    {
      apps.${system} = {
        default = {
          type = "app";
          program = "${self.nixosConfigurations.vm.config.system.build.vm}/bin/run-nixos-vm";
        };
      };
      nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [ ./vm.nix ];
      };
    };
}
