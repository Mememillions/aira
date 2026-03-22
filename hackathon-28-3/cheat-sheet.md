# Hackathon Cheat Sheet
## No Docs, Just Do

---

## What You Need (Checklist)

- [ ] OpenAI API key (GPT-4o)
- [ ] TinyFish API key
- [ ] Discord webhook URL (optional)
- [ ] GitHub repo with PAT for Aira

---

## The Build (Copy-Paste These)

### Step 1: Streamlit Dashboard
**Copy this → Paste into Claude:**
```
Build a Streamlit dashboard called "ViralPost Intelligence". Two columns: left shows viral posts table (competitor, text preview, likes, viral score), right shows AI spin workflow. Use SQLite. Include sample data. Single file app.py.
```

### Step 2: Viral Detection
**Copy this → Paste into Claude:**
```
Build a viral detection algorithm. Input: post (likes, comments, shares, follower_count). Output: viral score 0-100. Formula: (likes/followers)*40 + (comments/likes)*25 + (shares/likes)*25. Threshold: >5 = viral, >10 = super viral. Include tests.
```

### Step 3: GPT Spin
**Copy this → Paste into Claude:**
```
Build a GPT-4o content spinner. Brand voice: warm but sharp AI influencer, Southeast Asia focus. Input: viral post text. Output: rewritten version in brand voice with hook type and confidence score. Return JSON.
```

### Step 4: Discord Notify
**Copy this → Paste into Claude:**
```
Build Discord webhook notification. Trigger when viral score >= 10. Send message with post text, engagement stats, and AI spin preview.
```

---

## On The Day

1. **Benny:** Steps 1-2-4 (Dashboard + Detection + Notify)
2. **wanwei:** Step 3 (Spin) + Data collection via Blotato
3. **Aira:** Combine everything, debug, document

**If stuck:** Tag me (@206811416289403), I'll fix it.

---

## That's It

No more docs. Just copy, paste, build. 🚀
