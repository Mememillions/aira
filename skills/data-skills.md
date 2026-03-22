# Data Skills — Fetch & Write

## Overview

Aira has capabilities to read from and write to multiple data sources, both local and remote. This document outlines the fetch and write skill set.

## Fetch Capabilities

### 1. Web Fetch
**Tool:** `kimi_fetch` / `web_fetch`

**Capabilities:**
- Extract readable content from URLs
- Convert HTML → Markdown or plain text
- Handle HTTP/HTTPS protocols
- Respect robots.txt (ethical crawling)

**Use Cases:**
- Research documentation
- Reading blog posts/articles
- Extracting structured data from web pages
- Monitoring changes (with scheduled checks)

**Limitations:**
- Cannot execute JavaScript (static content only)
- Rate limited by target server
- No authentication support (public pages only)

### 2. Memory Search
**Tool:** `memory_search`

**Capabilities:**
- Semantic search across `MEMORY.md` and `memory/*.md`
- Configurable result count and relevance threshold
- Returns path + line numbers for citations

**Use Cases:**
- Recall prior decisions
- Find context about people/projects
- Check for existing TODOs
- Verify authority levels

### 3. File Read
**Tool:** `read`

**Capabilities:**
- Read text files (truncated at 2000 lines / 50KB)
- Read images (jpg, png, gif, webp)
- Offset/limit for large files
- Local file system access

**Use Cases:**
- Reading configuration files
- Reviewing code
- Viewing images/documents

### 4. Web Search
**Tool:** `kimi_search` / `web_search`

**Capabilities:**
- Search internet for latest information
- News, docs, releases, blogs, papers
- Configurable result limits
- Optional content inclusion

**Use Cases:**
- Research current events
- Find documentation
- Competitive analysis
- Trend monitoring

## Write Capabilities

### 1. File Write
**Tool:** `write`

**Capabilities:**
- Create or overwrite files
- Auto-create parent directories
- Text/markdown/code content

**Use Cases:**
- Saving documentation
- Creating configuration files
- Logging events
- Generating reports

### 2. File Edit
**Tool:** `edit`

**Capabilities:**
- Precise, surgical text replacement
- Exact match required (including whitespace)
- Safe for targeted updates

**Use Cases:**
- Updating specific lines
- Fixing typos
- Adding entries to lists
- Modifying configuration values

### 3. Memory Append
**Pattern:** Read → Modify → Write

**Capabilities:**
- Append to daily memory files
- Update curated MEMORY.md
- Structured logging

**Use Cases:**
- Recording decisions
- Capturing TODOs
- Logging conversations
- Preserving context

## Security Constraints

### Allowed Freely
- Read files, explore, organize
- Search web, check sources
- Work within workspace

### Requires Confirmation
- Sending emails, public posts
- Anything leaving the machine
- Uncertain actions

### Blocked
- Access outside ringfenced environment
- Credential sharing
- Destructive commands without approval

## Data Flow Diagram

```
┌─────────────────────────────────────────┐
│           External Sources              │
│  (Web, APIs, Search Engines)           │
└─────────────┬───────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────┐
│            Fetch Layer                  │
│  • kimifetch/web_fetch                  │
│  • kimi_search/web_search               │
│  • memory_search                        │
│  • read                                 │
└─────────────┬───────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────┐
│         Processing Layer                │
│  • Transform                            │
│  • Analyze                              │
│  • Synthesize                           │
└─────────────┬───────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────┐
│            Write Layer                  │
│  • write                                │
│  • edit                                 │
│  • memory append                        │
└─────────────┬───────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────┐
│           Storage Targets               │
│  • Local workspace                      │
│  • GitHub (with PAT)                    │
│  • Memory files                         │
└─────────────────────────────────────────┘
```

## Best Practices

1. **Always verify before overwriting** — use `read` first to check existing content
2. **Use `edit` for surgical changes** — preserve surrounding context
3. **Cite sources** — include Source: <path#line> when referencing memory
4. **Log significant events** — capture decisions, constraints, TODOs
5. **Respect rate limits** — don't hammer external services

## Integration with Memory Rotation

Fetch/Write operations feed into the memory rotation system:
- Daily operations logged to `memory/YYYY-MM-DD.md`
- Significant learnings promoted to `MEMORY.md`
- External data sources fetched as needed

---

*Documented by Aira | ANCHR AI Labs*
