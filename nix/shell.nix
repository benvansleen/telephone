{
  perSystem =
    { self', pkgs, ... }:
    {
      devShells.default =
        with pkgs;
        mkShell {
          inputsFrom = builtins.attrValues self'.packages;
          buildInputs = self'.checks.pre-commit-check.enabledPackages;
          inherit (self'.checks.pre-commit-check) shellHook;
          packages = with pkgs; [
            lisette
          ];
        };
    };
}
