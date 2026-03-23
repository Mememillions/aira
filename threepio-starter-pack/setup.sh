#!/bin/bash
# Threepio Memory System Setup Script
# Run this to set up the complete memory rotation system

set -e

echo "🤖 Setting up Threepio Memory System..."

# 1. Create directory structure
echo "📁 Creating directories..."
mkdir -p ~/.openclaw/workspace/memory
mkdir -p ~/.openclaw/skills/memory-rotation

# 2. Create rotate.py
echo "📝 Creating rotate.py..."
cat > ~/.openclaw/skills/memory-rotation/rotate.py << 'ROTATE_EOF'
#!/usr/bin/env python3
"""Memory Rotation Script for OpenClaw Agents"""

import os
import sys
import shutil
import glob
from datetime import datetime

TOKEN_THRESHOLD = 190000
MEMORY_DIR = os.path.expanduser("~/.openclaw/workspace")
ARCHIVE_PREFIX = "MEMORY_"

def get_token_count(text):
    return len(text) // 4

def get_next_archive_number():
    pattern = os.path.join(MEMORY_DIR, f"{ARCHIVE_PREFIX}*.md")
    files = glob.glob(pattern)
    if not files:
        return 1
    numbers = []
    for f in files:
        try:
            basename = os.path.basename(f)
            num = int(basename.replace(ARCHIVE_PREFIX, "").replace(".md", ""))
            numbers.append(num)
        except ValueError:
            continue
    return max(numbers) + 1 if numbers else 1

def check_memory_size():
    memory_path = os.path.join(MEMORY_DIR, "MEMORY.md")
    if not os.path.exists(memory_path):
        return False, 0
    with open(memory_path, 'r', encoding='utf-8') as f:
        content = f.read()
    token_count = get_token_count(content)
    return token_count > TOKEN_THRESHOLD, token_count

def rotate_memory():
    memory_path = os.path.join(MEMORY_DIR, "MEMORY.md")
    if not os.path.exists(memory_path):
        print("❌ MEMORY.md not found")
        return False
    
    with open(memory_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    next_num = get_next_archive_number()
    archive_name = f"{ARCHIVE_PREFIX}{next_num}.md"
    archive_path = os.path.join(MEMORY_DIR, archive_name)
    
    shutil.copy2(memory_path, archive_path)
    print(f"✅ Archived to {archive_name}")
    
    # Create new MEMORY.md with header
    header_lines = []
    lines = content.split('\n')
    for i, line in enumerate(lines[:50]):
        if line.startswith('#') or 'Name' in line or line.startswith('- **'):
            header_lines.append(line)
        elif i > 20 and line.strip() == '':
            break
    
    new_content = '\n'.join(header_lines)
    new_content += f"\n\n---\n\n"
    new_content += f"**[Previous: {archive_name}]** - Rotated {datetime.now().strftime('%Y-%m-%d %H:%M')}\n\n"
    new_content += f"## Recent Context\n(Add new memories here...)\n"
    
    with open(memory_path, 'w', encoding='utf-8') as f:
        f.write(new_content)
    
    print(f"✅ Created new MEMORY.md")
    return True

def main():
    args = sys.argv[1:] if len(sys.argv) > 1 else []
    
    if "--status" in args:
        needs_rotation, token_count = check_memory_size()
        print(f"📊 MEMORY.md: ~{token_count:,} tokens")
        print(f"   Rotation: {'NEEDED' if needs_rotation else 'OK'}")
        return
    
    if "--check" in args:
        needs_rotation, token_count = check_memory_size()
        print(f"{'⚠️ Rotation needed' if needs_rotation else '✅ OK'}: ~{token_count:,} tokens")
        sys.exit(1 if needs_rotation else 0)
    
    if "--rotate" in args:
        print("🔄 Rotating...")
        rotate_memory()
        return
    
    if "--auto" in args:
        needs_rotation, token_count = check_memory_size()
        if needs_rotation:
            print(f"🔄 Auto-rotating: ~{token_count:,} tokens")
            rotate_memory()
        else:
            print(f"✅ No rotation needed")
        return
    
    print("Usage: rotate.py --status | --check | --rotate | --auto")

if __name__ == "__main__":
    main()
ROTATE_EOF

chmod +x ~/.openclaw/skills/memory-rotation/rotate.py

# 3. Create initial MEMORY.md
echo "📝 Creating MEMORY.md..."
if [ ! -f ~/.openclaw/workspace/MEMORY.md ]; then
cat > ~/.openclaw/workspace/MEMORY.md << 'MEMORY_EOF'
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

---
*Memory rotation enabled. Check status with: python3 ~/.openclaw/skills/memory-rotation/rotate.py --status*
MEMORY_EOF
fi

# 4. Create today's memory log
echo "📝 Creating daily memory log..."
TODAY=$(date +%Y-%m-%d)
if [ ! -f ~/.openclaw/workspace/memory/${TODAY}.md ]; then
cat > ~/.openclaw/workspace/memory/${TODAY}.md << DAILY_EOF
# Memory Log — ${TODAY}

## Session Start
- Memory system initialized
- Threepio configured with file persistence

## Events

## Decisions

## Lessons
DAILY_EOF
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "📊 Check memory status:"
echo "   python3 ~/.openclaw/skills/memory-rotation/rotate.py --status"
echo ""
echo "🔄 Force rotation:"
echo "   python3 ~/.openclaw/skills/memory-rotation/rotate.py --rotate"
echo ""
echo "📁 Files created:"
echo "   ~/.openclaw/workspace/MEMORY.md"
echo "   ~/.openclaw/workspace/memory/${TODAY}.md"
echo "   ~/.openclaw/skills/memory-rotation/rotate.py"
