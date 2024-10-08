{
  inputs = {
    # Use unstable for flakes
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Add home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Use nixos generators for generating an iso
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, flake-utils, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };

        overlays = [ ];
      };

    in

    {
      inherit lib;

      packages.${system} = import ./packages { inherit pkgs; };

      # For nixos-rebuild
      nixosConfigurations = {
        console = lib.nixosSystem {
          specialArgs = {
            inherit self inputs system;
          };
          modules = [
            ./images/console
            ./images/common.nix
            {
              system.stateVersion = "23.11";
            }
          ];
        };

        contestant = lib.nixosSystem {
          specialArgs = {
            inherit self inputs system;
          };
          modules = [
            ./images/contestant
            ./images/common.nix
            {
              system.stateVersion = "23.11";
            }
          ];
        };
      };

      ## nix build .#console
      packages.x86_64-linux.console = inputs.nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        format = "raw";
        specialArgs = {
          inherit self inputs system;
        };
        modules = [
          ./images/common.nix
          ./images/console
          {
            system.stateVersion = "23.11";
          }
        ];
      };
      packages.x86_64-linux.contestant = inputs.nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        format = "raw";
        specialArgs = {
          inherit self inputs system;
        };
        modules = [
          ./images/common.nix
          ./images/contestant
          {
            system.stateVersion = "23.11";
          }
        ];
      };
    };
}
