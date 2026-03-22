# Project: Viral Post Capture & Repost System

## Overview

Automated competitive intelligence system that monitors competitors' viral social media content and reposts/adapts it for own channels.

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    DISCOVERY LAYER                          │
│  AgentQL: Navigate competitor profiles                        │
│  • Scan for high-engagement posts                             │
│  • Filter by: likes, shares, comments threshold               │
│  • Detect viral velocity (engagement rate over time)          │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                    CAPTURE LAYER                            │
│  AgentQL: Extract structured data                             │
│  • Post text/content                                          │
│  • Engagement metrics (likes, shares, comments, views)        │
│  • Timestamp                                                  │
│  • Media URLs (images, videos)                                │
│  • Hashtags used                                              │
│  • Post format (carousel, reel, story, etc.)                  │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                    STORAGE LAYER                            │
│  • Structured database (JSON/CSV/SQLite)                      │
│  • Media assets (downloaded locally)                          │
│  • Metadata index (searchable)                                │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                   ANALYSIS LAYER (Optional)                 │
│  LLM: Why did this go viral?                                  │
│  • Sentiment analysis                                         │
│  • Hook identification                                        │
│  • Format analysis                                            │
│  • Audience targeting insights                                │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                    REPOST LAYER                             │
│  Content adaptation for own channels                          │
│  • Rewrite caption (preserve hook, adapt voice)               │
│  • Add commentary/insights                                    │
│  • Schedule optimal posting time                              │
│  • Cross-post to multiple platforms                           │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                   PUBLISHING LAYER                          │
│  API integrations:                                            │
│  • Instagram/TikTok/X posting                                 │
│  • LinkedIn (for B2B)                                         │
│  • Telegram/Discord channels                                  │
└─────────────────────────────────────────────────────────────┘
```

## AgentQL Query Examples

### Discovery Query
```python
# Find viral posts on competitor's profile
query = """
{
    posts[] {
        content(text)
        likes_count(number)
        comments_count(number)
        shares_count(number)
        timestamp
        is_video(boolean)
        media_urls[](string)
    }
}
"""

# Filter condition: >1000 likes OR >100 comments = viral threshold
```

### Capture Query
```python
# Extract full post details
query = """
{
    post {
        text(string)
        author(string)
        publish_date(string)
        engagement {
            likes(number)
            comments(number)
            shares(number)
            saves(number)
        }
        hashtags[](string)
        mentions[](string)
        media {
            type(enum: image|video|carousel)
            urls[](string)
            caption(string)
        }
        comments_preview[]({
            author(string)
            text(string)
            likes(number)
        })
    }
}
"""
```

## Data Schema

```json
{
  "viral_post": {
    "id": "unique_identifier",
    "source": {
      "platform": "instagram|tiktok|x|linkedin",
      "competitor_handle": "@competitor",
      "post_url": "https://...",
      "captured_at": "2026-03-28T10:00:00Z"
    },
    "content": {
      "text": "Original caption text",
      "hashtags": ["#tag1", "#tag2"],
      "mentions": ["@user1"],
      "media": [{
        "type": "image|video",
        "url": "https://cdn...",
        "local_path": "./media/..."
      }]
    },
    "engagement": {
      "likes": 5000,
      "comments": 300,
      "shares": 150,
      "views": 50000,
      "viral_score": 8.5
    },
    "analysis": {
      "hook_type": "curiosity|fear|aspiration|humor",
      "sentiment": "positive|neutral|negative",
      "key_insight": "Why this worked"
    },
    "repost": {
      "status": "pending|scheduled|posted",
      "adapted_caption": "Our version...",
      "scheduled_time": "2026-03-28T14:00:00Z",
      "posted_urls": ["https://our.post/1"]
    }
  }
}
```

## Viral Score Calculation

```
viral_score = (
    (likes / followers) * 0.4 +
    (comments / likes) * 0.3 +
    (shares / likes) * 0.2 +
    (saves / likes) * 0.1
) * 100

Threshold: viral_score > 5.0 = worth capturing
```

## Competitors to Monitor

| Platform | Competitor Handle | Focus Area |
|----------|-------------------|------------|
| Instagram | @... | AI Marketing |
| TikTok | @... | Tech tutorials |
| X/Twitter | @... | AI News |
| LinkedIn | @... | B2B content |

## Repost Strategy

### Timing
- **Immediate repost:** For time-sensitive news
- **Delayed repost:** For evergreen content (add commentary, wait 24-48h)
- **Batch repost:** Weekly roundup of best viral content

### Adaptation Rules
1. **Never copy verbatim** — always rewrite
2. **Add value** — commentary, insights, contrarian takes
3. **Tag original** — credit when appropriate
4. **Adapt format** — carousel → thread, video → text summary, etc.

## Technical Stack

| Component | Tool |
|-----------|------|
| Web Automation | TinyFish AgentQL |
| Data Storage | SQLite / JSON files |
| Analysis | OpenAI/Claude API |
| Scheduling | n8n or cron |
| Publishing | Platform APIs (Instagram Basic Display, etc.) |
| Dashboard | Simple HTML or Streamlit |

## MVP Scope (Hackathon)

### Day 1 Goals
- [ ] AgentQL setup and authentication
- [ ] Single competitor monitoring (1 platform)
- [ ] Basic viral post detection
- [ ] Data capture and storage

### Day 2 Goals
- [ ] Multi-platform support
- [ ] LLM-powered caption rewriting
- [ ] Repost scheduling
- [ ] Demo presentation

## Demo Narrative

**Problem:** "Keeping up with what works in social media is exhausting"

**Solution:** "AI agent that watches competitors 24/7 and surfaces viral content for you to adapt"

**Live Demo:**
1. Show competitor profile
2. Run AgentQL capture
3. Display viral post detected
4. Show AI-rewritten caption
5. Schedule repost

---

*Architecture Document | TinyFish Hackathon 2026*
