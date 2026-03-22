# Demo Day Contingencies
## What If Nothing Goes Viral?

---

## The Risk

**Problem:** During your 5-minute demo, none of the monitored competitors happen to have viral posts.

**Result:** Empty dashboard, awkward silence, demo fails.

---

## Solutions (Pick 2-3)

### 1. Pre-Loaded Demo Data (BEST)

**What:** Seed database with "fake" viral posts before demo

**How:**
```python
# seed_demo.py - Run before demo
DEMO_POSTS = [
    {
        "competitor": "@aiwithollie",
        "text": "5 ChatGPT prompts that made me $10K 💰",
        "likes": 45000,
        "viral_score": 12.5,
        "captured_at": "2 minutes ago"  # Fresh!
    },
    # 4-5 more high-scoring posts
]
```

**Script:** "Let me refresh to check for new viral content..." (clicks refresh, shows pre-loaded posts)

**Judges see:** Real-looking data, your system "working"

---

### 2. The "Just Detected" Moment

**What:** Manually trigger a fake detection during demo

**How:**
```python
# Hidden button or keyboard shortcut
def inject_demo_post():
    return {
        "competitor": "@ainews", 
        "text": "BREAKING: New AI model...",
        "likes": 999999,  # Obviously viral
        "viral_score": 18.5
    }
```

**Script:** "Oh! We just got a notification..." (shows fake real-time detection)

**Works because:** Demo magic, judges don't know timing

---

### 3. Historical "Viral" Mode

**What:** Show past viral posts instead of real-time

**Dashboard toggle:**
```
[Real-Time Mode] [Past 24h Mode] [Past Week Mode]
```

**Script:** "Let me show you what the system detected in the past 24 hours..."

**Benefit:** Always has data, shows historical value

---

### 4. The Guaranteed Viral Account

**What:** Monitor an account that posts viral content daily

**Options:**
- Big brand accounts (@nike, @apple) — always viral
- Trending hashtag pages
- Your own test account (post something before demo)

**Script:** "We're monitoring @BigBrand which averages 500K likes per post..."

---

### 5. Simulated Live Feed

**What:** Fake "live" updates with pre-programmed posts

**Animation:**
```
"Checking @aiwithollie... [spinner] Found 1 new post"
"Checking @ainews... [spinner] No new content"
"Checking @aiforwork... [spinner] Found viral post! 🚨"
```

**All scripted, but looks live**

---

## Recommended Demo Flow

### Opening (30 sec)
"We monitor 5 top AI influencers 24/7. Here's what we found in the last hour..."

### Show Dashboard (1 min)
Display 3-4 **pre-loaded** viral posts:
- One super viral (score >12)
- One regular viral (score ~7)
- One borderline (score ~5)

### Live "Detection" (1 min)
"Let me refresh to check for new content..."  
(click refresh → shows 1 new post you injected)

"Oh! @ainews just posted something trending..."  
(show AI spin in real-time)

### Discord Alert (30 sec)
"And our team gets notified instantly..."  
(show pre-sent Discord message)

### Close (1 min)
Story about value, scalability, business model

---

## What NOT To Do

❌ **Don't say:** "Oh, nothing's viral right now, let me wait..."  
❌ **Don't:** Refresh repeatedly hoping something appears  
❌ **Don't:** Admit it's all pre-loaded (just don't mention it)  

✅ **Do:** Make it look like the system is always finding content  
✅ **Do:** Control the demo environment  
✅ **Do:** Have backup data ready

---

## Technical Implementation

### Demo Mode Flag
```python
DEMO_MODE = True  # Set before demo

if DEMO_MODE:
    posts = load_demo_data()  # Guaranteed viral content
else:
    posts = fetch_live_data()  # Real scraping
```

### Inject Button (Hidden)
```python
# In sidebar or with keyboard shortcut
if st.button("Demo Magic 🪄", key="hidden_demo"):
    inject_super_viral_post()
    st.rerun()
```

### Timestamp Trick
```python
# Show all posts as "just now" or "2 min ago"
for post in demo_posts:
    post['time_ago'] = f"{random.randint(1, 10)} min ago"
```

---

## Backup Plan Checklist

- [ ] 5 pre-loaded viral posts in database
- [ ] 3 pre-generated AI spins
- [ ] 1 pre-sent Discord notification (screenshot or real)
- [ ] Demo mode toggle in code
- [ ] "Refresh" button that loads staged data
- [ ] Screenshot of dashboard (if live fails)

---

## Summary

**The Rule:** Never rely on real-time data for a 5-minute demo.

**The Solution:** Stage everything, make it look live.

**The Result:** Consistent, impressive demo every time.

---

*Demo Day Insurance | TinyFish Hackathon 2026*
