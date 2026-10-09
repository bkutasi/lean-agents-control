#!/usr/bin/env bash
# Lean installer: OpenCode agents + lean-ctx wiring. No registry, no profiles.
set -e
GLOBAL_AGENTS="${OPENCODE_GLOBAL_AGENTS:-$HOME/.config/opencode/agents}"
echo "Lean Agent Control installer"
echo "1/3 checking lean-ctx..."
command -v lean-ctx >/dev/null || { echo "install lean-ctx first: curl -fsSL https://leanctx.com/install.sh | sh"; exit 1; }
echo "2/3 installing agents globally..."
mkdir -p "$GLOBAL_AGENTS"
cp .opencode/agent/core/openagent.md "$GLOBAL_AGENTS/OpenAgent.md"
for f in .opencode/agent/subagents/*/*.md; do
  n=$(grep -m1 '^name:' "$f" | awk '{print $2}')
  cp "$f" "$GLOBAL_AGENTS/$n.md"
done
echo "3/4 wiring opencode..."
lean-ctx init --agent opencode
lean-ctx init --global
echo "4/4 verifying..."
lean-ctx rules sync
lean-ctx doctor
echo "Done. Start: opencode --agent OpenAgent"
