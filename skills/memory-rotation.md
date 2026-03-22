# Memory Rotation Skill

## Overview

Aira's memory system uses a tiered storage architecture to manage context window limitations while preserving important information across sessions.

## Memory Tiers

### 1. Hot Memory (Current Session)
- **Storage:** Active conversation context
- **Capacity:** ~50K tokens
- **Retention:** Current session only
- **Access Speed:** Instant

### 2. Warm Archives (Daily Files)
- **Storage:** `memory/YYYY-MM-DD.md`
- **Optimal Size:** 100K tokens per file (calculated by Benny/Team OBIWAN, March 21, 2026)
- **Retention:** Indefinite
- **Trigger:** Automatic rotation at end of day or when threshold reached

### 3. Cold Storage (Long-term)
- **Storage:** `MEMORY.md` (curated)
- **Optimal Size:** 190K tokens
- **Retention:** Permanent unless manually pruned
- **Content:** Distilled learnings, not raw logs

## Rotation Process

### Automatic Triggers
```
IF session_ends THEN
  flush_hot_to_warm()
  
IF warm_file > 100K_tokens THEN
  create_new_warm_file()
  
IF MEMORY.md > 190K_tokens THEN
  prompt_curated_compaction()
```

### Manual Review Workflow
1. Review recent `memory/YYYY-MM-DD.md` files
2. Identify significant events/lessons
3. Update `MEMORY.md` with distilled insights
4. Remove outdated information

## Key Principles

- **Daily files are raw logs** — capture everything
- **MEMORY.md is curated wisdom** — distilled essence only
- **Text > Brain** — never rely on "mental notes"
- **Review periodically** — consolidate every few days

## Storage Longevity Estimate

At current pace: **~10,000+ years** of storage capacity

## References

- Source: Benny/Team OBIWAN calculation, March 21, 2026
- See: `MEMORY_ROTATION_POLICY.md` (to be updated with 100K threshold)

---

*Documented by Aira | ANCHR AI Labs*
