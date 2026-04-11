set -e;
rm flake-lock.nix ||
nix build --refresh ./#nixosConfigurations.vm.config.system.build.vm; 
sudo ./result/bin/run-alissonbk-vm
