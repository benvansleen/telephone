{ inputs, ... }:

{
  perSystem =
    { system, lib, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            lisette = prev.lisette.overrideAttrs (
              new: old: {
                version = "0.11.1";
                src = old.src.overrideAttrs {
                  tag = "lisette-v${new.version}";
                  hash = "sha256-y4daDiPOf5egoAiE1y6vEZoZJfDLB2ywy7hOn75GS/Y=";
                };
                cargoDeps = final.rustPlatform.fetchCargoVendor {
                  inherit (new) src;
                  hash = "sha256-ARONSRqGiLF9UC5rJIc6754km7tS+9WQUSMuedRB1Fg=";
                };
                checkFlags = (old.checkFlags or [ ]) ++ [
                  "--skip=e2e_learn"
                ];
              }
            );
          })

          (final: _prev: {
            buildLisetteModule =
              { src, vendorHash }:
              let
                manifest = fromTOML (builtins.readFile "${src}/lisette.toml");
                go-mod = "${src}/target/go.mod";
                go-sum = "${src}/target/go.sum";

                initialRequires =
                  let
                    deps = manifest.dependencies.go or { };
                    pinVersion = pin: if builtins.isString pin then pin else pin.version;
                    lines = lib.mapAttrsToList (module: pin: "\t${module} ${pinVersion pin}") deps;
                  in
                  lib.concatStringsSep "\n" (
                    lines ++ [ "\tgithub.com/ivov/lisette/prelude v${lib.getVersion final.lisette}" ]
                  );

                goModules =
                  final.runCommand "lis-go-modules"
                    {
                      nativeBuildInputs = [ final.go ];
                      outputHashMode = "recursive";
                      outputHash = vendorHash;
                    }
                    /* sh */ ''
                      export HOME="$TMPDIR"
                      export GOCACHE="$TMPDIR/go-cache"
                      export GOMODCACHE="$TMPDIR/go-mod-cache"
                      export GOTOOLCHAIN=local
                      export GOWORK=off
                      export GOSUMDB=off

                      # Pre-tidy graph: versions pinned in lisette.toml + prelude. Needed by
                      # the bindgen typedef pass that runs before `go mod tidy`.
                      mkdir deps-initial
                      cat > deps-initial/go.mod <<EOF
                      module lis-python-server

                      go ${final.go.version}

                      require (
                      ${initialRequires}
                      )
                      EOF
                      (cd deps-initial && go mod download all)

                      # Final tidy'd graph: needed by `go mod tidy` and the Go build.
                      mkdir deps-final
                      cp ${go-mod} deps-final/go.mod
                      ${if builtins.pathExists go-sum then "cp ${go-sum} deps-final/go.sum" else ""}
                      chmod -R u+w deps-final
                      (cd deps-final && go mod download all)

                      # lisette fetches its bindgen tool at emit time via
                      # `go run github.com/ivov/lisette/bindgen@v${final.lisette.version}`; pre-download
                      # it and its dependency graph so emit runs fully offline.
                      mkdir tools
                      cat > tools/go.mod <<EOF
                      module lisette-bindgen-tools

                      go ${final.go.version}

                      require github.com/ivov/lisette/bindgen v${lib.getVersion final.lisette}
                      EOF
                      (cd tools && go mod download all)

                      mkdir -p "$out"
                      cp -r "$GOMODCACHE/cache/download/." "$out"
                    '';

                lisProject =
                  final.runCommand "lis-emitted"
                    {
                      nativeBuildInputs = [ final.go ];
                    }
                    /* sh */ ''
                      export HOME="$TMPDIR"
                      export GOCACHE="$TMPDIR/go-cache"
                      export GOMODCACHE="$TMPDIR/go-mod-cache"
                      export GOPROXY="file://${goModules},off"
                      export GOTOOLCHAIN=local
                      export GOWORK=off
                      export GOSUMDB=off

                      mkdir project
                      cp -r ${src}/src project/src
                      cp ${src}/lisette.toml project/lisette.toml
                      chmod -R u+w project

                      cd project
                      ${lib.getExe final.lisette} emit

                      mkdir -p "$out"
                      cp -r target/. "$out/project/"
                      rm -rf "$out/project/.lisette"
                    '';
              in
              final.buildGoModule {
                inherit (manifest.project) version;
                pname = manifest.project.name;
                src = "${lisProject}/project";
                proxyVendor = true;
                vendorHash = null;
                ldflags = [
                  "-s"
                  "-w"
                ];

                postConfigure = /* sh */ ''
                  export GOPROXY="file://${goModules},off"
                  export GOSUMDB=off
                  export GOTOOLCHAIN=local
                  export GOWORK=off
                  export GOFLAGS="-buildvcs=false $GOFLAGS"
                '';

                nativeBuildInputs = [ final.lisette ];
                meta.mainProgram = manifest.project.name;
              };
          })
        ];
      };
    };
}
