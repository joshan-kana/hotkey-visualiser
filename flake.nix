{
  description = "flake for hotkey-visualiser";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        packages = with pkgs; [
          nixfmt-tree
          qmk
          keymap-drawer
        ];

        # Create shell scripts
        scripts = [
          (pkgs.writeScriptBin "km" ''
            ./keymap.sh
          '')
          (pkgs.writeScriptBin "another-script" ''
            ./scripts/another-script.sh
          '')
        ];
      in
        {
          # For nix develop
          devShells = {
            default = pkgs.mkShell {
              packages = packages ++ scripts;
            };
          };

          # For nix shell
          packages = {
            default = pkgs.buildEnv {
              name = "hotkey-visualiser";
              paths = packages ++ scripts;
            };
          };
        });
}
