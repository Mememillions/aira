# Original Build - Simple Version
## Faster to Build, Less Complex

---

## Overview

**Build Time:** ~8 hours  
**Complexity:** Medium  
**Architecture:** Simple pipeline (Extract → Analyze → Spin)

**Good for:** Testing build time, learning the stack, backup plan

---

## Architecture (Simple)

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Scraper   │────▶│   Analyzer  │────▶│   Spinner   │
│  (Manual)   │     │  (Simple)   │     │  (Basic)    │
└─────────────┘     └─────────────┘     └─────────────┘
         │                                     │
         ▼                                     ▼
┌─────────────┐                       ┌─────────────┐
│   SQLite    │                       │  Discord    │
│   (Data)    │                       │  (Optional) │
└─────────────┘                       └─────────────┘
```

---

## Copy-Paste Prompts (Use These)

### Step 1: Simple Dashboard
**Paste into Claude:**
```
Build a simple Streamlit dashboard for monitoring viral TikTok posts.

Features:
- Table showing posts (competitor, text, likes, viral score)
- Simple viral score = likes / follower_count * 100
- Threshold: >5 = viral
- Sidebar with competitor selector
- Right panel: show post details when clicked

Use SQLite. Single file: app.py
Include 10 sample posts.
```

### Step 2: Simple Viral Detection
**Paste into Claude:**
```
Build a simple viral detection function.

Input: likes, comments, shares, follower_count
Formula: (likes / followers) * 100
Output: viral score 0-100

Thresholds:
- <5: not viral
- 5-10: viral
- >10: super viral

Include 5 test cases.
```

### Step 3: Simple GPT Spin
**Paste into Claude:**
```
Build a simple GPT-4 content rewriter.

Input: post text
Output: rewritten version

Style: conversational, friendly
Keep same length.
Return JSON: {original, rewritten}
```

### Step 4: Simple Discord (Optional)
**Paste into Claude:**
```
Build simple Discord webhook.

Trigger: viral score >10
Message: "Viral post detected: [text]"
```

---

## Simplified Features

| Feature | Original Simple | Revised Complex |
|---------|-----------------|-----------------|
| **Scraping** | Manual data entry / CSV import | TinyFish live extraction |
| **Viral Detection** | Likes/follower ratio only | Multi-factor algorithm |
| **Spin** | Basic GPT rewrite | Brand voice + hook analysis |
| **Agents** | None | 6 specialized agents |
| **Notifications** | Simple text | Rich embeds |
| **Database** | SQLite, 2 tables | SQLite, 4 tables |
| **Orchestration** | Manual | Autonomous scheduler |

---

## File Structure (Simple)

```
viralpost-simple/
├── app.py              # Streamlit dashboard
├── detection.py        # Viral score function
├── spinner.py          # GPT rewrite
├── notify.py           # Discord (optional)
├── database.py         # SQLite setup
├── sample_data.py      # 10 fake posts
└── requirements.txt
```

---

## Sample Data (Pre-Made)

```python
SAMPLE_POSTS = [
    {
        "competitor": "@aiwithollie",
        "text": "5 ChatGPT prompts that made me $10K",
        "likes": 45000,
        "comments": 1200,
        "shares": 3400,
        "follower_count": 500000,
    },
    {
        "competitor": "@ainews",
        "text": "New AI model drops today",
        "likes": 12000,
        "comments": 800,
        "shares": 1500,
        "follower_count": 200000,
    },
    # ... 8 more
]
```

---

## Build Checklist (Original)

- [ ] Create `app.py` with Streamlit dashboard
- [ ] Add sample data (10 posts)
- [ ] Build viral detection function
- [ ] Add GPT spin (basic)
- [ ] Add Discord notify (optional)
- [ ] Test end-to-end

**Total estimated time:** 6-8 hours

---

## Differences from Revised

| Aspect | Original | Revised |
|--------|----------|---------|
| **Build time** | 6-8 hrs | 10-12 hrs |
| **Code complexity** | Low-Medium | High |
| **Demo impressiveness** | 6/10 | 9/10 |
| **Winning potential** | Medium | High |
| **Risk of bugs** | Low | Medium |

---

## When to Use Original

✅ **Use Original if:**
- Testing build time
- Learning the stack
- Backup plan if Revised fails
- Team has limited coding experience

❌ **Don't use Original if:**
- Targeting 1st place
- Need to impress technical judges
- Want unicorn investment prize

---

## Test Tomorrow

**Goal:** See how long this simple version takes

**Process:**
1. Copy prompts above
2. Paste into Claude one by one
3. Time each step
4. Note where you get stuck

**Expected:**
- Step 1: 2-3 hours
- Step 2: 1 hour
- Step 3: 1-2 hours
- Step 4: 30 mins
- **Total: 5-7 hours**

---

*Original Build - For Testing | TinyFish Hackathon 2026*
