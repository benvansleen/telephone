module telephone

go 1.25.0

require (
	dario.cat/mergo v1.0.0
	github.com/ProtonMail/go-crypto v1.1.6
	github.com/bwesterb/go-ristretto v1.2.3
	github.com/cloudflare/circl v1.6.3
	github.com/creack/pty v1.1.9
	github.com/cyphar/filepath-securejoin v0.6.1
	github.com/emirpasic/gods v1.18.1
	github.com/go-git/gcfg v1.5.1-0.20230307220236-3a3c6141e376
	github.com/go-git/go-billy/v5 v5.9.0
	github.com/go-git/go-git-fixtures/v4 v4.3.2-0.20231010084843-55a94097c399
	github.com/go-git/go-git/v5 v5.19.2
	github.com/golang/groupcache v0.0.0-20241129210726-2c02b8208cf8
	github.com/golang/protobuf v1.5.4
	github.com/google/go-cmp v0.7.0
	github.com/ivov/lisette/prelude v0.11.1
	github.com/jbenet/go-context v0.0.0-20150711004518-d14ea06fba99
	github.com/kevinburke/ssh_config v1.2.0
	github.com/klauspost/cpuid/v2 v2.3.0
	github.com/kr/pretty v0.3.1
	github.com/kr/text v0.2.0
	github.com/mattn/go-pointer v0.0.1
	github.com/pjbgf/sha1cd v0.6.0
	github.com/rogpeppe/go-internal v1.14.1
	github.com/sergi/go-diff v1.4.0
	github.com/skeema/knownhosts v1.3.1
	github.com/telephone/ts-shim v0.0.0
	github.com/telephone/tsgrammar v0.0.0
	github.com/tree-sitter/go-tree-sitter v0.25.0
	github.com/xanzy/ssh-agent v0.3.3
	github.com/yuin/goldmark v1.4.13
	golang.org/x/crypto v0.54.0
	golang.org/x/mod v0.37.0
	golang.org/x/net v0.56.0
	golang.org/x/sync v0.22.0
	golang.org/x/sys v0.47.0
	golang.org/x/telemetry v0.0.0-20260625142307-59b4966ccb57
	golang.org/x/term v0.45.0
	golang.org/x/text v0.40.0
	golang.org/x/tools v0.47.0
	google.golang.org/protobuf v1.33.0
	gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c
	gopkg.in/warnings.v0 v0.1.2
)

replace github.com/telephone/ts-shim => /home/ben/Code/telephone/vendor/ts-shim

replace github.com/telephone/tsgrammar => /home/ben/Code/telephone/vendor/tsgrammar
