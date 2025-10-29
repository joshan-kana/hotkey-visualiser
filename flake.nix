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
            ./visual-keymap.sh
          '')
          (pkgs.writeScriptBin "live-reload" ''
            echo "zsa_voyager_keymap.yaml keychron_q12_keymap.yaml" | tr ' ' '\n' | ${pkgs.entr}/bin/entr sh ./visual-keymap.sh
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
