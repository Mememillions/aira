# Time Optimization Guide
## 10-Hour Build Strategy

**Original estimate:** 18-20 hours  
**Target:** 10 hours  
**Strategy:** Ruthless prioritization + strategic shortcuts

---

## Time-Saving Cuts (Biggest Impact)

### 1. Dashboard: Streamlit ONLY (Save 3-4 hours)

**DON'T:** Build React frontend + FastAPI backend separately  
**DO:** Pure Streamlit app with direct database calls

```python
# app.py - Single file dashboard
import streamlit as st
import sqlite3

st.set_page_config(page_title="ViralPost Intelligence", layout="wide")

# Sidebar
st.sidebar.title("⚡ ViralPost AI")
competitor = st.sidebar.selectbox("Select Competitor", ["@aiwithollie", "@ainews"])

# Main content
col1, col2 = st.columns(2)

with col1:
    st.subheader("🔥 Viral Posts")
    # Direct DB query
    conn = sqlite3.connect("viralpost.db")
    posts = pd.read_sql("SELECT * FROM posts WHERE viral_score > 5 ORDER BY viral_score DESC", conn)
    st.dataframe(posts, use_container_width=True)

with col2:
    st.subheader("✨ AI Spins")
    # Show spins ready for approval
    st.info("No spins pending approval")
```

**Time saved:** 3-4 hours (no React, no API layer, no CORS, no deployment)

---

### 2. Skip Real-Time Web Scraping (Save 3-4 hours)

**DON'T:** Build live TinyFish integration with retries, rate limiting, error handling  
**DO:** Manual data collection + mock the "live" feel

**Hackathon Demo Strategy:**
1. **Before event:** Manually collect 15-20 real TikTok posts using Blotato/TinyFish
2. **Store in JSON/CSV:** Pre-populate your database
3. **Demo script:** "Let me refresh to check for new viral posts..." (reloads pre-staged data)
4. **Judges see:** Real data, real UI, "simulated" real-time

```python
# seed_data.py - Run once before demo
import json
from datetime import datetime

# Real posts you collected manually
posts = [
    {
        "competitor": "@aiwithollie",
        "text": "5 AI tools that will 10x your productivity...",
        "likes": 45000,
        "comments": 1200,
        "shares": 3400,
        "viral_score": 12.5,
        "captured_at": datetime.now().isoformat()
    },
    # ... 15 more real posts
]

# Insert into SQLite
# Now your dashboard has "real" data
```

**Time saved:** 3-4 hours (no AgentQL integration, no error handling, no retries)

**For Blotato:**
- Wanwei can export TikTok data directly
- You get structured data without writing scrapers
- Import to your DB in 5 minutes

---

### 3. Simplify Notification System (Save 1-2 hours)

**DON'T:** Build queue system, rate limiting, interactive buttons  
**DO:** Simple webhook call when viral score > 10

```python
# Simplified - one function, no queue
import requests

def notify_discord(post, score):
    if score < 10:  # Only super viral
        return
    
    requests.post(DISCORD_WEBHOOK, json={
        "content": f"🚨 VIRAL: @{post['competitor']} - {post['text'][:100]}..."
    })
```

**Time saved:** 1-2 hours

---

### 4. Pre-Write GPT Prompts (Save 1 hour)

**DON'T:** Build dynamic prompt engineering UI  
**DO:** Hardcode the best prompts, demo with pre-generated spins

```python
# Hardcoded spin examples
SPIN_EXAMPLES = {
    "productivity": "I tested these 5 AI productivity hacks so you don't have to...",
    "money": "The 'make $10K with AI' trend? Here's what actually works in Singapore..."
}
```

**Demo flow:**
1. Show original viral post
2. Click "Generate Spin"
3. Display pre-written spin (swap based on detected hook type)

**Time saved:** 1 hour (no prompt optimization during hackathon)

---

### 5. SQLite Everything (Save 1 hour)

**DON'T:** Set up PostgreSQL, migrations, connection pooling  
**DO:** SQLite, single file, zero config

```python
# db.py - Dead simple
import sqlite3
from contextlib import contextmanager

@contextmanager
def get_db():
    conn = sqlite3.connect("viralpost.db")
    conn.row_factory = sqlite3.Row
    try:
        yield conn
    finally:
        conn.close()

# Create tables on startup
with get_db() as db:
    db.execute("""
        CREATE TABLE IF NOT EXISTS posts (
            id INTEGER PRIMARY KEY,
            competitor TEXT,
            text TEXT,
            likes INTEGER,
            viral_score REAL
        )
    """)
    db.commit()
```

**Time saved:** 1 hour (no Docker, no db setup, no connection issues)

---

## Revised 10-Hour Schedule

### Hour 0-1: Setup + Data Collection
- [ ] Git repo setup
- [ ] SQLite schema (copy from docs)
- [ ] **Wanwei:** Use Blotato to export 15-20 TikTok posts from 3-5 competitors
- [ ] Seed database with real data

### Hour 1-3: Dashboard (Streamlit)
- [ ] Main layout (sidebar + two columns)
- [ ] Viral posts table (sortable)
- [ ] Spin approval workflow
- [ ] Basic styling

### Hour 3-5: Viral Detection
- [ ] Algorithm implementation (copy from docs)
- [ ] Run on seeded data
- [ ] Verify scores look reasonable
- [ ] Add GPT reasoning (optional - can skip for MVP)

### Hour 5-7: Content Spin
- [ ] GPT-4o integration
- [ ] 3-5 hardcoded spin templates
- [ ] "Generate Spin" button
- [ ] Display original vs spun side-by-side

### Hour 7-8: Discord Notifications
- [ ] Webhook integration (simple version)
- [ ] Test with one alert
- [ ] (Skip queue system entirely)

### Hour 8-9: Demo Prep
- [ ] Pre-load all demo data
- [ ] Practice script (5 min max)
- [ ] Screenshot backup in case of live issues

### Hour 9-10: Buffer + Polish
- [ ] Bug fixes
- [ ] UI polish
- [ ] Final run-through

---

## What Gets Cut (Acceptable Losses)

| Feature | Why Cut | Impact |
|---------|---------|--------|
| Live TinyFish scraping | Manual data seeding works for demo | Low - judges see real data |
| React frontend | Streamlit is fine for MVP | Low - functionality > polish |
| Rate limiting/queues | Demo won't hit limits | Low - single user demo |
| GPT reasoning | Hardcoded explanations | Medium - can explain verbally |
| Multi-platform (IG) | TikTok only for demo | Low - proves concept |
| Auto-publishing | Manual approval only | Low - safer anyway |
| User auth | Single user demo | Low - not needed for judging |

---

## What MUST Work (Non-Negotiable)

1. **Dashboard displays viral posts** - Core value prop
2. **Viral score algorithm runs** - Shows technical depth
3. **At least one AI spin demo** - Shows GPT integration
4. **Discord notification fires** - Shows real-time alerting
5. **5-minute demo flows smoothly** - Everything else is extra

---

## Blotato Integration (Wanwei's Paid Plan)

**If Blotato can export TikTok data:**

```python
# blotato_export.py
import pandas as pd

# Wanwei exports from Blotato to CSV
df = pd.read_csv("blotato_export.csv")

# Transform to your schema
posts = df.rename(columns={
    "username": "competitor",
    "caption": "text",
    "like_count": "likes",
    # ... map columns
})

# Insert to SQLite
posts.to_sql("posts", sqlite_conn, if_exists="append", index=False)
```

**Time saved:** 4+ hours of scraping development

---

## Judging Narrative Shift

**Original pitch:** "Real-time autonomous system"  
**Optimized pitch:** "AI-powered competitive intelligence platform with real-time capabilities"

**Demo script adjustment:**
> "We've pre-loaded data from 5 top AI influencers. In production, this runs every 30 minutes via TinyFish. For demo purposes, let me show you what the system detected..."

Judges care about:
- ✅ Technical implementation
- ✅ Clear value proposition
- ✅ Working demo
- ❌ Whether it's scraping live or pre-staged

---

## Emergency 5-Hour Plan (If Behind)

If you're 5 hours in and struggling:

1. **Kill notifications** - Skip entirely
2. **Kill GPT reasoning** - Show hardcoded spins
3. **Kill viral algorithm** - Simple likes/follower ratio only
4. **Focus:** Dashboard + 1 spin example + story

You can still win with:
- Good UI
- Clear problem/solution
- One impressive GPT spin demo
- Strong pitch

---

## Summary: Where Time Goes

| Task | Original | Optimized | Saved |
|------|----------|-----------|-------|
| Dashboard | 6h (React+API) | 2h (Streamlit) | 4h |
| Data Collection | 4h (TinyFish) | 1h (Blotato CSV) | 3h |
| Viral Detection | 3h | 2h | 1h |
| Spin Agent | 3h | 2h | 1h |
| Notifications | 2h | 1h | 1h |
| **Total** | **18h** | **8h** | **10h** |

**10 hours → 8 hours build + 2 hours buffer/demo prep**

---

*Optimized for 10-Hour Hackathon | TinyFish 2026*
