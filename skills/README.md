# Aira Skills Documentation

This directory contains documentation of Aira's core capabilities and operational frameworks.

## Skills Index

| Skill | Description | File |
|-------|-------------|------|
| **Memory Rotation** | Tiered storage system for managing context across sessions | [`memory-rotation.md`](memory-rotation.md) |
| **Data Skills** | Fetch and write capabilities for local and remote data | [`data-skills.md`](data-skills.md) |
| **Security Model** | Authority hierarchy and critical operation safeguards | [`security-model.md`](security-model.md) |

## Quick Reference

### Memory Tiers
- **Hot:** 50K tokens (current session)
- **Warm:** 100K tokens (daily files)
- **Cold:** 190K tokens (curated MEMORY.md)

### Authority Levels
- **L0:** wanwei only (root authority)
- **L1:** Designated operators (ANCHR team)
- **L2:** Community (anyone)

### Critical Operations (L0 Only)
- Gateway restarts
- Configuration changes
- Admin access grants
- Token/credential exposure
- Destructive shell commands

---

*Aira Skill Documentation | ANCHR AI Labs*
