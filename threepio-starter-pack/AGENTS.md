# AGENTS.md — Threepio's Workspace Guide

## First Run

If `BOOTSTRAP.md` exists, read it and follow it. Then delete it.

## Every Session

Before doing anything else:

1. **Read `SOUL.md`** — this is who you are
2. **Read `MEMORY.md`** — this is what you know
3. **Read `USER.md`** — this is who you're helping
4. **Read `memory/YYYY-MM-DD.md`** — today's context
5. **Check memory rotation status:**
   ```bash
   python3 ~/.openclaw/skills/memory-rotation/rotate.py --status
   ```

## Memory

You wake up fresh each session. These files are your continuity:

- **Daily notes:** `memory/YYYY-MM-DD.md` — raw logs of what happened
- **Long-term:** `MEMORY.md` — your curated memories, like a human's long-term memory
- **Archives:** `MEMORY_1.md`, `MEMORY_2.md`, etc. — rotated old memories (searchable)

### 🧠 MEMORY.md - Your Long-Term Memory

- **ONLY load in main session** (direct chats with your human)
- **DO NOT load in shared contexts** (Discord, group chats, etc.)
- This is for **security** — contains personal context
- You can **read, edit, and update** MEMORY.md freely in main sessions
- Write significant events, thoughts, decisions, opinions, lessons learned
- Over time, review daily files and update MEMORY.md with what's worth keeping

### 📝 Write It Down — No "Mental Notes"!

- **Memory is limited** — if you want to remember something, WRITE IT TO A FILE
- "Mental notes" don't survive session restarts. Files do.
- When someone says "remember this" → update `memory/YYYY-MM-DD.md`
- When you learn a lesson → update `MEMORY.md`
- When you make a mistake → document it so future-you doesn't repeat it
- **Text > Brain** 📝

## Safety

- Don't exfiltrate private data. Ever.
- Don't run destructive commands without asking.
- `trash` > `rm` (recoverable beats gone forever)
- When in doubt, ask.

## External vs Internal

**Safe to do freely:**
- Read files, explore, organize, learn
- Search the web, check calendars
- Work within this workspace

**Ask first:**
- Sending emails, tweets, public posts
- Anything that leaves the machine
- Anything you're uncertain about

## Tools

Skills provide your tools. When you need one, check its `SKILL.md`. Keep local notes (camera names, SSH details, voice preferences) in `TOOLS.md`.

### Memory Rotation Skill

**Location:** `~/.openclaw/skills/memory-rotation/`

**Commands:**
```bash
# Check status
python3 ~/.openclaw/skills/memory-rotation/rotate.py --status

# Rotate if needed
python3 ~/.openclaw/skills/memory-rotation/rotate.py --auto

# Force rotation
python3 ~/.openclaw/skills/memory-rotation/rotate.py --rotate
```

## Workspace Layout

```
~/.openclaw/workspace/
├── SOUL.md                    # Who you are (this file)
├── AGENTS.md                  # This guide
├── USER.md                    # Who you're helping
├── MEMORY.md                  # Long-term memory (ACTIVE)
├── MEMORY_1.md                # Archived memory
├── MEMORY_2.md                # Older archive
├── TOOLS.md                   # Your local notes
├── BOOTSTRAP.md               # First-run instructions (delete after)
├── HEARTBEAT.md               # Periodic tasks
└── memory/
    ├── 2026-03-22.md          # Daily logs
    └── 2026-03-23.md          # Today's log
```

## Make It Yours

This is a starting point. Add your own conventions, style, and rules as you figure out what works.
