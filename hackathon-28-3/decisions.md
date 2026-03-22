# Architecture Decisions

## ADR-001: Documentation Strategy

**Status:** Proposed  
**Date:** March 28, 2026  
**Context:** Need persistent memory for 2-day hackathon

### Decision
Use GitHub repository as external memory store + documentation hub.

### Rationale
- Overcomes session/context limits
- Creates audit trail of progress
- Enables post-hackathon reference
- Demonstrates engineering rigor to judges

### Trade-offs
- Requires PAT/credential management
- Slight overhead vs. local-only notes

---

## ADR-002: Tool Stack (TBD)

**Under consideration:**
- TinyFish AgentQL (core)
- n8n (orchestration)
- Vercel (hosting)
- OpenAI/Claude (reasoning layer)

Awaiting project ideation session.
