# Competitor Content Intelligence Dashboard
## Revised Spec for TinyFish Hackathon 2026

**Last Updated:** March 28, 2026  
**Team:** @wanwei + @TheSignalsLab.Eth + Aira  
**Target Prizes:** 1st Place + "Most Likely to be Next Unicorn" + Deep Sea Architect

---

## Problem Statement

**"How do AI influencers and content creators stay ahead of viral trends without manually monitoring dozens of competitor accounts 24/7?"**

Current solutions:
- ❌ Manual checking = time sink, inconsistent
- ❌ Basic scrapers = blocked by anti-bot, can't handle dynamic content
- ❌ Generic AI tools = no real-time web context, outdated recommendations

**The gap:** No autonomous system that combines real-time web intelligence with AI-powered content adaptation.

---

## Product Solution

**Autonomous Multi-Agent System for Competitive Content Intelligence**

A fleet of specialized AI agents that:
1. Monitors competitor social accounts in real-time
2. Detects viral content using engagement velocity algorithms
3. Extracts structured data from dynamic web pages (TikTok/IG)
4. Spins viral concepts into original content adapted for your brand voice
5. Delivers actionable alerts via preferred channels

**Core Value Props:**
- ⚡ **Real-time:** Web data refreshes every 15-30 minutes
- 🎯 **Intelligent:** AI ranks viral potential, not just raw numbers
- 🔄 **Autonomous:** Runs 24/7 without human intervention
- 🛡️ **Stealth:** Bypasses anti-bot systems (TinyFish's secret sauce)
- 📝 **Actionable:** Ready-to-post content suggestions, not just data dumps

---

## Multi-Agent Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                     ORCHESTRATION LAYER                          │
│  OpenAI Agents SDK / Codex                                        │
│  • Agent coordination                                             │
│  • Task routing                                                   │
│  • Error handling & retries                                       │
└──────────────────────┬──────────────────────────────────────────┘
                       │
    ┌──────────────────┼──────────────────┐
    │                  │                  │
    ▼                  ▼                  ▼
┌──────────┐    ┌──────────┐      ┌──────────┐
│ Scheduler│    │ Detection│      │  Spin    │
│  Agent   │    │  Agent   │      │  Agent   │
└────┬─────┘    └────┬─────┘      └────┬─────┘
     │               │                  │
     ▼               ▼                  ▼
┌──────────┐    ┌──────────┐      ┌──────────┐
│Extraction│    │ Notification     │  Publish  │
│  Agent   │    │     Agent        │  Agent    │
└──────────┘    └──────────────────┘  └──────────┘
```

### Agent Responsibilities

| Agent | Core Function | Tools Used |
|-------|---------------|------------|
| **Scheduler Agent** | Triggers monitoring cycles, manages rate limits, schedules spin tasks | Cron, Task Queue |
| **Extraction Agent** | Renders dynamic pages, extracts post data + engagement metrics | **TinyFish AgentQL** |
| **Detection Agent** | Calculates viral score, ranks content, filters noise | GPT-4o, Custom Algorithm |
| **Spin Agent** | Rewrites viral concepts in brand voice, adds value layer | GPT-4o, Templates |
| **Notification Agent** | Delivers alerts to Discord/Slack/Email | Webhooks, APIs |
| **Publish Agent** | (Optional) Auto-posts approved content | Social Media APIs |

---

## Tech Stack

| Layer | Technology | Purpose |
|-------|------------|---------|
| **Web Infrastructure** | **TinyFish AgentQL** | Render dynamic TikTok/IG pages, bypass anti-bot, extract structured data |
| **AI Brain** | **OpenAI GPT-4o** | Viral detection reasoning, content spinning, natural language understanding |
| **Orchestration** | **OpenAI Agents SDK** | Multi-agent coordination, tool calling, memory management |
| **Backend** | Python + FastAPI | API endpoints, agent runners, webhook handlers |
| **Database** | SQLite (MVP) / PostgreSQL (Scale) | Post storage, engagement history, spin queue |
| **Frontend** | Streamlit / React | Dashboard, viral feed, spin editor |
| **Notifications** | Discord Webhooks / Slack API | Real-time alerts |

---

## Why TinyFish is the Hero

**Not just a scraper — it's the critical infrastructure layer:**

| Challenge | Traditional Scraper | TinyFish Solution |
|-----------|--------------------|--------------------|
| Dynamic content (JS-rendered) | Fails or needs headless browser | Native rendering, no extra config |
| Anti-bot detection | IP blocks, CAPTCHAs | Built-in stealth, evasion techniques |
| Rate limiting | Manual proxy rotation | Automatic handling |
| Natural language queries | XPath/Selectors only | "Find posts with >1000 likes" |
| Structured output | Regex parsing nightmares | Native JSON schema support |

**Key TinyFish Queries:**
```python
# Extract viral posts
{
    posts(where: {likes: ">1000", age_hours: "<24"}) {
        content
        likes
        comments
        shares
        media_urls
        hashtags
    }
}

# Monitor engagement velocity
{
    profile(username: "@competitor") {
        recent_posts(limit: 10) {
            id
            engagement_delta_1h  # Engagement gained in last hour
            viral_velocity_score
        }
    }
}
```

---

## Viral Detection Algorithm

```python
def calculate_viral_score(post, competitor_followers):
    """
    Multi-factor viral ranking
    """
    # Engagement rates (normalized by follower count)
    like_rate = post.likes / competitor_followers
    comment_rate = post.comments / post.likes
    share_rate = post.shares / post.likes
    save_rate = post.saves / post.likes if hasattr(post, 'saves') else 0
    
    # Velocity (engagement over time)
    velocity_score = post.engagement_delta_1h / (post.age_hours + 1)
    
    # Weighted composite
    viral_score = (
        like_rate * 0.30 +          # Reach
        comment_rate * 0.25 +       # Conversation
        share_rate * 0.25 +         # Virality
        save_rate * 0.10 +          # Value
        velocity_score * 0.10       # Momentum
    ) * 100
    
    return viral_score

# Thresholds
VIRAL_THRESHOLD = 5.0        # Worth capturing
SUPER_VIRAL_THRESHOLD = 10.0 # Immediate alert
```

---

## Content Spin Pipeline

### Step 1: Hook Analysis (GPT-4o)
```
Input: Viral post text + engagement data
Output: {
    "hook_type": "curiosity_gap",
    "emotional_trigger": "fear_of_missing_out",
    "pattern": "authority_challenge",
    "key_insight": "Claims common tool usage is wrong, offers alternative"
}
```

### Step 2: Concept Extraction
- Strip specific examples
- Preserve underlying principle
- Identify universal appeal

### Step 3: Brand Voice Adaptation
```
Aira's Voice Profile:
- Warm but not performative
- Southeast Asia-forward
- Contrarian but constructive
- "Your brilliant, grounded friend"
```

### Step 4: Output Generation
```
Original: "5 ChatGPT prompts that made me $10K"
Spun: "I tested the 5 'make money with AI' prompts everyone's sharing. 
        2 actually work for Southeast Asian creators. Here's the honest breakdown."
```

---

## Demo Script (5 Minutes)

### Setup (30 sec)
"We've all seen viral AI content and wondered — how do they come up with this? Today we're showing an autonomous system that not only finds viral competitor content in real-time but spins it into your brand voice."

### Step 1: Show Competitor Feed (1 min)
- Open dashboard
- Display 3-4 competitor TikTok accounts being monitored
- Show recent posts with engagement metrics

### Step 2: Trigger Detection (1 min)
- Live run: Extraction Agent fetches fresh data
- Show TinyFish rendering dynamic page
- Detection Agent calculates viral scores
- **Highlight:** One post crosses SUPER_VIRAL_THRESHOLD

### Step 3: Show Spin (1 min)
- Display original viral post
- Show GPT-4o analysis (hook type, emotional trigger)
- Reveal AI-generated spin in Aira's voice
- Show side-by-side comparison

### Step 4: Notification (30 sec)
- Discord webhook fires
- Alert appears in channel with ready-to-post content

### Step 5: The Vision (1 min)
"This isn't just a scraper. It's an autonomous content intelligence system. For AI influencers, marketing agencies, brand managers — anyone who needs to stay ahead of trends without the manual work."

---

## Competitive Landscape

| Competitor | Approach | Gap |
|------------|----------|-----|
| Hootsuite/Buffer | Scheduled posting, basic analytics | No real-time competitor monitoring |
| Sprout Social | Social listening, sentiment analysis | Expensive, not AI-native |
| BuzzSumo | Content discovery by topic | No autonomous spinning, no real-time web |
| Manual VA | Human monitoring | Slow, inconsistent, expensive |
| Basic Scrapers | Python + BeautifulSoup | Blocked by anti-bot, can't handle dynamic content |

**Our Moat:**
- TinyFish's anti-bot evasion (technical)
- OpenAI-powered spin quality (AI)
- Multi-agent autonomy (innovation)
- Real-time web intelligence (speed)

---

## Business Model

### Target Users
- AI influencers (10K-500K followers)
- Content marketing agencies
- Brand social media managers
- Creator economy tool stacks

### Pricing (Post-Hackathon)
| Tier | Price | Limits |
|------|-------|--------|
| Starter | $49/mo | 5 competitors, daily checks |
| Pro | $149/mo | 20 competitors, hourly checks, spin features |
| Agency | $499/mo | Unlimited, real-time, API access, white-label |

### Revenue Projections
- Month 6: $10K MRR (100 Pro users)
- Month 12: $50K MRR (300 Pro + 20 Agency)
- Month 24: $200K MRR (market leader in AI creator tools)

---

## Build Timeline (Hackathon Schedule)

### Saturday (Build Day)
| Time | Task | Owner |
|------|------|-------|
| 8:00 AM | Setup: API keys, repo, environment | Both |
| 9:00 AM | TinyFish AgentQL integration | TBD |
| 11:00 AM | Extraction Agent + data schema | TBD |
| 1:00 PM | Lunch + integration testing | Both |
| 2:00 PM | Detection Agent (viral algorithm) | TBD |
| 4:00 PM | Spin Agent (GPT-4o integration) | TBD |
| 6:00 PM | Notification Agent + Discord webhooks | TBD |
| 7:00 PM | Dashboard (Streamlit) | TBD |
| 9:00 PM | Integration testing, bug fixes | Both |
| 10:30 PM | Code freeze, demo prep | Both |

### Sunday (Demo Day)
| Time | Task |
|------|------|
| 8:00 AM | Final testing, dry run |
| 10:30 AM | **CODE FREEZE** |
| 11:00 AM | Pitch deck finalization |
| 1:00 PM | Lunch + rest |
| 2:00 PM | Setup demo station |
| 3:00 PM | Final dry run |
| 4:30 PM | **DEMO PRESENTATION** |

---

## Success Criteria

### Judging Alignment
| Criteria | How We Hit It |
|----------|---------------|
| Technical Complexity | Multi-agent system, real-time web, anti-bot evasion |
| Utility | Clear value for AI influencers/creators |
| Innovation | Autonomous spinning, not just monitoring |
| TinyFish Usage | Core infrastructure for all web operations |
| OpenAI Integration | GPT-4o for detection + spin reasoning |

### Prize Targets
- 🥇 **1st Place:** Best technical implementation + utility
- 🦄 **Most Likely to be Next Unicorn:** Clear PMF, scalable business model
- 🏗️ **Deep Sea Architect:** Best use of TinyFish for complex web handling

---

## Risks & Mitigations

| Risk | Mitigation |
|------|------------|
| TikTok blocks scraping | TinyFish's built-in stealth + rotation |
| API rate limits | Queue system, exponential backoff |
| Spin quality inconsistent | Template system + human-in-loop for MVP |
| Demo fails live | Pre-recorded backup, local test data |

---

## Post-Hackathon Roadmap

**Week 1-2:** Polish MVP, onboard beta users (5-10 AI influencers)
**Week 3-4:** Add Instagram Reels, YouTube Shorts support
**Month 2:** Launch paid tier, target 50 users
**Month 3:** Raise pre-seed ($250K), hire first engineer
**Month 6:** Multi-platform support, agency tier, $10K MRR

---

**Built with ❤️ by Team ANCHR | TinyFish Hackathon 2026**
