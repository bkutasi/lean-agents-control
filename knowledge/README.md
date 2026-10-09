# Knowledge seeds (migrated from .opencode/context — deleted)

These 3 files are the only project facts kept as markdown. Everything else lives in lean-ctx:
- `kb-okf/code-quality.md` → `lean-ctx knowledge remember` (coding standards)
- `kb-okf/test-coverage.md` → `lean-ctx knowledge remember` (testing standards)
- `kb-okf/technical-domain.md` → `lean-ctx knowledge remember` (project patterns)

Import: `lean-ctx knowledge import ./knowledge/kb-okf --merge append`
Export OKF: `lean-ctx knowledge export --format okf --output ./knowledge/kb-okf`
Consolidate: `lean-ctx knowledge consolidate`
