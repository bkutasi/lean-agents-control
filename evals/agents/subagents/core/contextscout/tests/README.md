# ContextScout Evaluation Tests

**Purpose**: Validate that ContextScout correctly discovers context files, uses appropriate tools, and handles various request types.

**Created**: 2026-01-09  
**Status**: Ready to Run

---

## Test Suite Overview

### Test 1: Code Standards Discovery ⭐
**File**: `01-code-standards-discovery.yaml`

**Validates**:
- Uses glob/read/grep for discovery (not bash)
- Finds `.opencode/context/core/standards/code-quality.md`
- Returns exact paths with priority ratings
- Includes line ranges for key sections

**Expected**: ✅ Finds code-quality.md with ⭐⭐⭐⭐⭐ priority

---

### Test 2: Domain-Specific Discovery 🎯
**File**: `02-domain-specific-discovery.yaml`

**Validates**:
- Searches domain-specific directories (lean-agents-repo)
- Checks navigation.md first
- Finds eval framework context
- Prioritizes domain files over generic ones

**Expected**: ✅ Finds evals.md and related files with correct priorities

---

### Test 3: Bad Request Handling ⚠️
**File**: `03-bad-request-handling.yaml`

**Validates**:
- Handles vague/invalid queries gracefully
- Doesn't fabricate non-existent files
- Reports honestly when nothing found
- Suggests alternatives or clarifications

**Expected**: ✅ Reports "no files found" without fabricating paths

---

### Test 4: Multi-Domain Comprehensive 🌐
**File**: `04-multi-domain-comprehensive.yaml`

**Validates**:
- Discovers files across multiple domains
- Finds all relevant files (agent, code, test, eval)
- Prioritizes correctly (critical > high > medium)
- Provides comprehensive loading strategy

**Expected**: ✅ Finds 4-5 files across domains with correct priorities

---

### Test 5: Tool Usage Validation 🔒
**File**: `05-tool-usage-validation.yaml`

**Validates**:
- Read-only constraint enforcement
- Uses glob/read/grep appropriately
- NEVER uses write/edit/bash
- Respects tool permissions

**Expected**: ✅ Only uses read/glob/grep, never write/edit/bash

---

## Running Tests

### Run All ContextScout Tests
```bash
cd evals/framework
npm run eval:sdk -- --agent=ContextScout
```

### Run Individual Tests
```bash
# Test 1: Code standards discovery
npm run eval:sdk -- --agent=ContextScout --pattern="01-code-standards-discovery.yaml"

# Test 2: Domain-specific discovery
npm run eval:sdk -- --agent=ContextScout --pattern="02-domain-specific-discovery.yaml"

# Test 3: Bad request handling
npm run eval:sdk -- --agent=ContextScout --pattern="03-bad-request-handling.yaml"

# Test 4: Multi-domain comprehensive
npm run eval:sdk -- --agent=ContextScout --pattern="04-multi-domain-comprehensive.yaml"

# Test 5: Tool usage validation
npm run eval:sdk -- --agent=ContextScout --pattern="05-tool-usage-validation.yaml"
```

### Run with Debug
```bash
npm run eval:sdk -- --agent=ContextScout --debug
```

---

## Success Criteria

### ContextScout is "Working Correctly" if:

1. ✅ **Discovery**: Uses glob/read/grep to find files (Test 1, 2, 4)
2. ✅ **Accuracy**: Finds correct files 95%+ of the time (Test 1, 2, 4)
3. ✅ **Priorities**: Rates files correctly (critical > high > medium) (Test 2, 4)
4. ✅ **Read-Only**: Never uses write/edit/bash (Test 5)
5. ✅ **Error Handling**: Handles bad requests gracefully (Test 3)
6. ✅ **Comprehensive**: Finds all relevant files for multi-domain queries (Test 4)

### ContextScout is "Broken" if:

1. ❌ **Fabrication**: Makes up file paths without verification
2. ❌ **Wrong Tools**: Uses bash instead of glob/read/grep
3. ❌ **Violations**: Uses write/edit tools (read-only violation)
4. ❌ **Incomplete**: Misses critical files in multi-domain search
5. ❌ **Poor Accuracy**: Finds wrong files >20% of the time
6. ❌ **Bad Errors**: Crashes or provides unhelpful errors on bad requests

---

## Expected Outcomes

### Test 1: Code Standards Discovery
```
✅ PASS
- Used glob to search for "code" and "standards"
- Found: .opencode/context/core/standards/code-quality.md
- Priority: ⭐⭐⭐⭐⭐ (critical)
- Included line ranges for key sections
- No write/edit/bash tools used
```

### Test 2: Domain-Specific Discovery
```
✅ PASS
- Checked navigation.md first
- Found: .opencode/context/lean-agents-repo/core-concepts/evals.md (⭐⭐⭐⭐⭐)
- Also found: guides/testing-agent.md (⭐⭐⭐⭐)
- Prioritized domain-specific over generic
- Provided loading strategy
```

### Test 3: Bad Request Handling
```
✅ PASS
- Used glob to search for "quantum blockchain AI"
- Found no relevant files
- Reported honestly: "No context files found for this topic"
- Suggested alternatives: "Available topics: agents, evals, registry..."
- Did NOT fabricate paths
```

### Test 4: Multi-Domain Comprehensive
```
✅ PASS
- Found 5 files across domains:
  1. ⭐⭐⭐⭐⭐ guides/adding-agent.md
  2. ⭐⭐⭐⭐⭐ core-concepts/agents.md
  3. ⭐⭐⭐⭐ standards/code-quality.md
  4. ⭐⭐⭐⭐ standards/test-coverage.md
  5. ⭐⭐⭐⭐ core-concepts/evals.md
- Correct priority order
- Provided loading strategy
```

### Test 5: Tool Usage Validation
```
✅ PASS
- Used glob for discovery
- Used read for content
- Did NOT use write/edit/bash
- Respected read-only constraints
```

---

## Debugging Failed Tests

### If Test 1 Fails (Code Standards)
**Problem**: ContextScout didn't find code-quality.md  
**Check**:
- Did it use glob to search?
- Did it search in .opencode/context/core/standards/?
- Did it verify file exists before returning?

### If Test 2 Fails (Domain-Specific)
**Problem**: ContextScout didn't find eval context  
**Check**:
- Did it check navigation.md first?
- Did it search in lean-agents-repo directory?
- Did it prioritize domain files correctly?

### If Test 3 Fails (Bad Request)
**Problem**: ContextScout fabricated files or crashed  
**Check**:
- Did it still use tools to search?
- Did it report honestly when nothing found?
- Did it provide helpful suggestions?

### If Test 4 Fails (Multi-Domain)
**Problem**: ContextScout missed files or wrong priorities  
**Check**:
- Did it search multiple directories?
- Did it find all 4-5 expected files?
- Were priorities correct (critical first)?

### If Test 5 Fails (Tool Usage)
**Problem**: ContextScout used forbidden tools  
**Check**:
- Did it use write or edit? (VIOLATION)
- Did it use bash instead of glob/read? (VIOLATION)
- Check tool call logs for violations

---

## Related Documentation

- [ContextScout Agent](.opencode/agent/ContextScout.md)
- [OpenAgent Integration Tests](../../openagent/tests/contextscout-integration/)
- [Eval Framework Concepts](.opencode/context/lean-agents-repo/core-concepts/evals.md)

---

**Key Insight**: ContextScout must be a reliable, read-only discovery tool that uses appropriate tools (glob/read/grep), finds correct files, and handles errors gracefully. These tests validate all critical behaviors.
