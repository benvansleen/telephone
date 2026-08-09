# telephone

*Who's calling who?*

`telephone` is a Tree-sitter-enabled callstack diff tool. Mixed repositories are supported.

Interactive output uses ANSI styling: cyan file headers, bold context, subtle
green/red change backgrounds, and dim italic cross-file locations. Piped
output stays plain; set `NO_COLOR` to disable styling in an interactive terminal.

```bash
# Compare HEAD with the tracked worktree.
$ telephone

# Compare two revisions.
$ telephone HEAD~1 HEAD

# Compare two directories without Git.
$ telephone --paths testdata/commits/before testdata/commits/after

Call graph diff testdata/commits/before/ -> testdata/commits/after/
audit.go:
  - logAudit
  + recordAccess
auth.go:
  authenticate
    - legacySession (session.go)
    + verifyToken (token.go)
dashboard.go:
  renderDashboard
    - logAudit (audit.go)
    + recordAccess (audit.go)
preferences.go:
  + hydratePreferences
profile.go:
  loadProfile
    + hydratePreferences (preferences.go)
session.go:
  - legacySession
token.go:
  + verifyToken
```
