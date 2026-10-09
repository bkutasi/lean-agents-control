# Lean evals — kept TS harness, adapted to lean-ctx

Keep: `evals/framework/` (vitest + `eval:sdk:core`), `evals/agents/core/openagent/`,
`evals/agents/subagents/code/*`, `evals/agents/subagents/core/{contextscout,task-manager,documentation}/`,
`evals/agents/shared/tests/{golden,templates,common}/`.
Deleted: `opencoder`, `codebase-pattern-analyst`, `context-retriever`, content/development/meta suites,
`debug/edge-cases/examples`, CONTEXTSCOUT_* findings docs, results history.

Adapted suites must assert:
- `ctx_compose`/`ctx_overview` called before `ctx_read(paths[], full)` (no search→read chains, no single-read loops)
- no native Read/Grep/Glob/Shell where `ctx_*` exists (shadow_mode=true)
- `ctx_session task|finding|decision` used; handoff via `ctx_handoff` + `ctx_share`
- `lean-ctx doctor overhead --gate` passes (~3k fixed footprint)
- `lean-ctx benchmark report .` recorded; savings quoted as touched-traffic only, never universal

Run: `npm run test:lean` (validate) → `npm run test:smoke` → `npm run test` (core).
