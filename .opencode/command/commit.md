---
description: Create conventional commits with validation
---

# Commit (lean)

1. `ctx_shell("git status --porcelain")` + `ctx_shell("git diff --cached --stat")`.
2. Validate: delegate to BuildAgent (typecheck) + TestEngineer (affected tests). Stop on fail.
3. Message: `<emoji> <type>: <imperative, <=72 chars>` (feat/fix/docs/refactor/perf/test/chore).
4. `ctx_shell("git commit -m '<msg>'")`, show hash. Record `ctx_session finding`.
