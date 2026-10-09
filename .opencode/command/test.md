---
description: Run typecheck, build, and tests via lean gates
---

# Test (lean)

1. BuildAgent: `ctx_shell` typecheck + build. Stop on fail, report path:line.
2. TestEngineer: `ctx_shell` test runners. Positive+negative required, mocked externals.
3. Reviewer (optional): `ctx_review` + `ctx_smells scan`.
4. Record `ctx_session finding` + `ctx_feedback record`. Never auto-fix without approval.
