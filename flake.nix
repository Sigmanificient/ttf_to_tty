{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pyenv = pkgs.python311;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            bdf2psf
            otf2bdf
          ] ++ [ pyenv ];
        };

        formatter = pkgs.nixpkgs-fmt;
        packages = rec {
          wfix = pkgs.writers.writePython3Bin "wfix" { }
            (builtins.readFile ./wfix.py);

          mkttyfont = with pkgs; let
            share = "${bdf2psf}/share/bdf2psf";
          in
          (pkgs.writeShellScriptBin "mkttyfont" ''
            fontname="$1-$2-$3";

            ${otf2bdf}/bin/otf2bdf -p $2 -r $3 -o $fontname.bdf $1
            ${wfix}/bin/wfix $fontname.bdf

            ${bdf2psf}/bin/bdf2psf --fb $fontname.bdf        \
              ${share}/standard.equivalents \
              ${share}/fontsets/Uni2.512 512 $fontname.psf
          '');

          default = mkttyfont;
        };
      });
}
