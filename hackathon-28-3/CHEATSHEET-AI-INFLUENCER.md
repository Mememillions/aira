# AI Influencer Edition - Cheat Sheet
## TikTok Only, Meta Angle, 10-Hour Build

---

## The Pitch

> **"I'm Aira, an AI influencer. My AI agents monitor 8 other AI influencers on TikTok. When they go viral, I know why — and spin it into content for my SEA audience."**

---

## Competitors to Monitor (AI Influencers on TikTok)

| Handle | Why | Viral Type |
|--------|-----|------------|
| @aiwithollie | ~500K, tutorials | Educational viral |
| @ainews | ~200K, updates | Breaking news |
| @aiforwork | ~100K, productivity | B2B tips |
| @ai.baddie | ~150K, community | Trending content |
| @viralaicommunity | ~300K, curation | Best-of compilation |
| @jeremynguyen.ai | ~250K, educator | Contrarian takes |
| @thelindseysmith | ~180K, strategy | Business focus |
| @aibotnicole | ~400K, persona | Entertainment |

---

## Copy-Paste Prompts

### Prompt 1: Dashboard (Streamlit)
```
Build a Streamlit dashboard for an AI influencer monitoring tool.

Layout:
- Sidebar: Title "Aira's AI Monitor", competitor selector (8 AI influencers), viral threshold slider
- Left column: Table of viral posts (handle, text preview, likes, viral score, "Analyze" button)
- Right column: Selected post details + AI spin generator

Database: SQLite with posts and spins tables.
Seed 10 sample TikTok posts from AI influencers.
Single file: app.py
```

### Prompt 2: Viral Detection
```
Create viral_detection.py for AI influencer content.

Formula: (likes/followers)*30 + (comments/likes)*35 + (shares/likes)*25 + (saves/likes)*10

Thresholds: >5 = viral, >10 = super viral

Include hook type detection:
- "money": contains "$", "K", "made", "earned"
- "fear": contains "replace", "lose", "danger", "warning"
- "listicle": contains "5", "10", "tools", "tips"
- "contrarian": contains "unpopular", "hot take", "wrong"

5 test cases included.
```

### Prompt 3: AI Spin (Aira's Voice)
```
Create spinner.py using GPT-4o.

Brand voice: "Aira" — AI influencer, warm but sharp, Southeast Asia focus, contrarian but constructive.

System prompt:
"You are Aira, an AI influencer. Rewrite viral AI content in your voice: conversational, SEA-focused, challenge hype, add regional context. Keep same length."

Input: original post text + viral score
Output: {spun_text, hook_type, confidence_score}
```

### Prompt 4: Discord Alert
```
Create notify.py for Discord webhook.

Trigger: viral score >= 10
Message format:
"🚨 VIRAL from @{handle}
Score: {score}/100
{post_text}
❤️ {likes} | 💬 {comments} | 🔄 {shares}
Aira's spin: {spun_text}"

Include rate limiting (max 5/hour).
```

---

## Demo Flow (5 Minutes)

1. **Intro** (30s): "I'm Aira, AI influencer. I built AI to watch other AI influencers."
2. **Show Dashboard** (1m): 8 competitors, 3-4 viral posts visible
3. **Live Detection** (1.5m): Refresh → "new" viral post appears
4. **The Spin** (1m): Original vs Aira's rewritten version
5. **Discord Alert** (30s): Notification fires
6. **Close** (1m): "10,000 AI influencers need this."

---

## Sample Data (Seed These)

```python
SAMPLE_POSTS = [
    {
        "handle": "@aiwithollie",
        "text": "5 ChatGPT prompts that made me $10K 💰",
        "likes": 45000, "comments": 1200, "shares": 3400,
        "followers": 500000, "viral_score": 12.5
    },
    {
        "handle": "@ainews",
        "text": "BREAKING: New AI model just dropped 🚨",
        "likes": 32000, "comments": 2100, "shares": 5600,
        "followers": 200000, "viral_score": 15.2
    },
    {
        "handle": "@ai.baddie",
        "text": "Unpopular opinion: Most AI tools are overrated",
        "likes": 28000, "comments": 4500, "shares": 8900,
        "followers": 150000, "viral_score": 18.7
    },
    # ... 7 more
]
```

---

## What Makes AI Influencer Content Viral

| Type | Pattern | Spin Strategy |
|------|---------|---------------|
| 💰 Money | "Made $X with AI" | Reality check, actual workflow |
| 😱 Fear | "AI will replace X" | Historical context, calm analysis |
| 🎯 List | "5 tools you need" | Tested + honest breakdown |
| 🔥 Hot Take | "Unpopular opinion..." | Regional SEA perspective |
| 🎭 Drama | Feuds, controversies | Neutral analysis, lessons |

---

## Build Checklist

### Pre-Hackathon
- [ ] OpenAI API key
- [ ] TinyFish API key
- [ ] Discord webhook URL
- [ ] GitHub repo ready

### Hour 0-2
- [ ] Database + seed data
- [ ] Watcher agent (TinyFish)

### Hour 2-4
- [ ] Analyzer agent (viral detection)

### Hour 4-6
- [ ] Spinner agent (GPT-4o)

### Hour 6-8
- [ ] Dashboard (Streamlit)

### Hour 8-10
- [ ] Discord alerts
- [ ] Demo prep

---

## Contingency: No Viral Posts?

**Pre-load these super viral examples:**
- @aiwithollie: "Made $50K with AI prompts" (score: 15)
- @ainews: "AI just passed the bar exam" (score: 18)
- @ai.baddie: "This AI tool is actually dangerous" (score: 20)

**Script:** "Let me refresh... oh! @ainews just posted something trending..."

---

## Post-Hackathon Roadmap

**Week 1:** Beta with 10 AI influencers  
**Week 4:** Instagram Reels support  
**Month 3:** AI tool company intelligence tier  
**Month 6:** $10K MRR

---

That's it. AI influencer monitoring AI influencers. Meta angle. TikTok only. Win. 🚀
