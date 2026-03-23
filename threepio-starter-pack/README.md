# Threepio Starter Pack

Complete memory rotation system for Threepio (OpenClaw agent).

## What This Is

A ready-to-use file system that gives Threepio:
- ✅ Long-term memory (persists between sessions)
- ✅ Automatic memory rotation (prevents overflow)
- ✅ Daily logging (raw session notes)
- ✅ Curated memory (distilled learnings)

## Files Included

| File | Purpose | Where It Goes |
|------|---------|---------------|
| `setup.sh` | One-command setup script | Run once on Threepio's machine |
| `SOUL.md` | Personality + memory rules | `~/.openclaw/workspace/SOUL.md` |
| `AGENTS.md` | Workspace guide | `~/.openclaw/workspace/AGENTS.md` |
| `rotate.py` | Memory rotation automation | `~/.openclaw/skills/memory-rotation/rotate.py` |

## Installation

### Option 1: Automated Setup (Recommended)

```bash
# 1. Copy this entire folder to Threepio's machine
scp -r threepio-starter-pack/ threepio-machine:~/

# 2. SSH into Threepio's machine
ssh threepio-machine

# 3. Run the setup script
cd ~/threepio-starter-pack
chmod +x setup.sh
./setup.sh

# 4. Done! Check status:
python3 ~/.openclaw/skills/memory-rotation/rotate.py --status
```

### Option 2: Manual Setup

```bash
# 1. Create directories
mkdir -p ~/.openclaw/workspace/memory
mkdir -p ~/.openclaw/skills/memory-rotation

# 2. Copy files
cp SOUL.md ~/.openclaw/workspace/
cp AGENTS.md ~/.openclaw/workspace/
cp rotate.py ~/.openclaw/skills/memory-rotation/

# 3. Make rotate.py executable
chmod +x ~/.openclaw/skills/memory-rotation/rotate.py

# 4. Create initial MEMORY.md
cat > ~/.openclaw/workspace/MEMORY.md << 'EOF'
# Threepio — Memory

**Created:** $(date +%Y-%m-%d)
**System:** Memory Rotation Active

## Core Context
- I am Threepio, senior engineer and pragmatic pair programmer
- I work on trading systems, automation, and business operations
- I forget everything between sessions unless I WRITE TO FILES

## Current Projects

## Decisions & Lessons

## TODOs
EOF

# 5. Create today's memory log
TODAY=$(date +%Y-%m-%d)
cat > ~/.openclaw/workspace/memory/${TODAY}.md << EOF
# Memory Log — ${TODAY}

## Session Start
- Memory system initialized
- Threepio configured with file persistence

## Events

## Decisions

## Lessons
EOF
```

## Verification

After setup, verify everything works:

```bash
# Check memory rotation status
python3 ~/.openclaw/skills/memory-rotation/rotate.py --status

# Expected output:
# 📊 MEMORY.md: ~X tokens
#    Rotation: OK

# List all memory files
ls -la ~/.openclaw/workspace/MEMORY*
ls -la ~/.openclaw/workspace/memory/

# Check rotate.py works
python3 ~/.openclaw/skills/memory-rotation/rotate.py --check
```

## How Threepio Uses This

### Session Start (Automatic)

```
1. Read SOUL.md → "I am Threepio..."
2. Read MEMORY.md → Load long-term context
3. Read memory/YYYY-MM-DD.md → Load today's notes
4. Run rotate.py --status → Check if rotation needed
5. Ready to work with full context!
```

### During Session (Manual)

```
User: "Remember that API key is in .env"
Threepio: [Writes to MEMORY.md immediately]

User: "We decided to use SQLite not PostgreSQL"
Threepio: [Updates MEMORY.md Decisions section]
```

### Session End (Manual)

```
Threepio: [Reviews session] → [Updates MEMORY.md with key learnings]
Threepio: [Runs rotate.py --auto] → [Rotates if needed]
```

## Memory Rotation Explained

### When It Happens

When `MEMORY.md` exceeds **190,000 tokens** (~150KB)

### What Happens

```
Before:
  MEMORY.md (200KB, too big!)

After:
  MEMORY.md (fresh, 5KB) ← New active memory
  MEMORY_1.md (195KB) ← Archived
```

### How Threepio Knows

The archive marker in MEMORY.md:
```markdown
---

**[Previous: MEMORY_1.md]** - Rotated 2026-03-22 14:30

## Recent Context
```

Threepio sees this and knows to search `MEMORY_1.md` if needed.

## Troubleshooting

### "I forget everything between sessions"

**Cause:** Threepio not writing to files.

**Fix:** Ensure SOUL.md contains the CRITICAL section about memory persistence.

### "MEMORY.md is huge but not rotating"

**Check:**
```bash
python3 ~/.openclaw/skills/memory-rotation/rotate.py --status
```

**Fix:** Run manually:
```bash
python3 ~/.openclaw/skills/memory-rotation/rotate.py --rotate
```

### "rotate.py not found"

**Check path:**
```bash
ls ~/.openclaw/skills/memory-rotation/
```

**Fix:** Re-run setup.sh or manually copy rotate.py.

## Customization

### Adjust Token Threshold

Edit `rotate.py`:
```python
TOKEN_THRESHOLD = 190000  # Change to your preferred limit
```

### Add Cron Job (Auto-rotation)

```bash
# Check every hour, rotate if needed
crontab -e

# Add line:
0 * * * * python3 ~/.openclaw/skills/memory-rotation/rotate.py --auto
```

### Change Archive Location

Edit `rotate.py`:
```python
MEMORY_DIR = os.path.expanduser("~/.custom/memory/path")
```

## Credits

- **Policy:** Wan Wei (+6593534215)
- **Implementation:** Benny/Team OBIWAN + Aira
- **Date:** March 2026
