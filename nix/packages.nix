{ inputs, ... }:

{
  flake-file.inputs = {
    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages = {
        default = pkgs.buildLisetteModule {
          src = inputs.gitignore.lib.gitignoreSource ../.;
          vendorHash = "sha256-VpmvNZwZ2MEJJ+c2k+ZBnqBdeBsw5iZ4eqIzZzoEM24=";
        };
      };
    };
}
