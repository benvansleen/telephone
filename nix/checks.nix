{ inputs, ... }:

{
  flake-file.inputs = {
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  perSystem =
    { self', system, ... }:
    {
      checks = {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ../.;
          hooks = {
            check-added-large-files.enable = true;
            check-merge-conflicts.enable = true;
            detect-private-keys = {
              enable = true;
              excludes = [
              ];
            };
            deadnix = {
              enable = true;
              excludes = [
              ];
            };
            end-of-file-fixer = {
              enable = true;
              excludes = [ ".svg" ];
            };
            flake-checker.enable = true;
            ripsecrets.enable = true;
            statix.enable = true;
            treefmt = {
              enable = true;
              packageOverrides.treefmt = self'.formatter;
            };
            typos = {
              enable = true;
              excludes = [
              ];
              settings = {
                diff = false;
                ignored-words = [
                ];
              };
            };
          };
        };
      };
    };
}
