# AI Prompts for Market Intelligence Dashboard

## Prompt 1: Dashboard Architecture

```
Act as a senior full-stack developer specializing in real-time data dashboards.

I need to build a "Competitor Content Intelligence Dashboard" for a hackathon project.

CORE REQUIREMENTS:
- Display real-time viral post feeds from 10-15 competitor TikTok accounts
- Show viral score rankings (calculated from engagement rates + velocity)
- Side-by-side comparison: original post vs AI-spun version
- Notification center for alerts
- Simple controls to approve/reject spun content

TECH STACK:
- Backend: Python + FastAPI
- Frontend: Streamlit (MVP) or React
- Database: SQLite for hackathon
- Data source: TinyFish AgentQL for web extraction
- AI: OpenAI GPT-4o for content spinning

DELIVER:
1. Component architecture diagram
2. API endpoint specifications
3. Database schema for posts, competitors, and spins
4. Streamlit component structure (if using Streamlit)
5. Key UI/UX considerations for demo day

Focus on simplicity that looks impressive in a 5-minute demo.
```

## Prompt 2: Viral Detection Agent

```
Act as an AI/ML engineer building a viral content detection system.

I need Python code for a "Viral Detection Agent" that:

INPUT:
- Post data: {likes, comments, shares, saves, views, timestamp, follower_count}
- Historical data for velocity calculation

OUTPUT:
- Viral score (0-100)
- Is_viral boolean (threshold: 5.0)
- Is_super_viral boolean (threshold: 10.0)
- Reasoning: why this post is viral (hook type, engagement pattern)

ALGORITHM REQUIREMENTS:
1. Normalize engagement by follower count
2. Calculate velocity (engagement gained per hour)
3. Weight factors: likes (30%), comments (25%), shares (25%), saves (10%), velocity (10%)
4. Return structured data for dashboard display

DELIVER:
- Python function with type hints
- Unit tests with sample data
- Explanation of weight choices
- How to handle edge cases (new accounts, deleted posts)
```

## Prompt 3: Content Spin Agent

```
Act as a copywriter and AI prompt engineer specializing in social media content.

I need a prompt template for GPT-4o that spins viral competitor content into original posts.

CONTEXT:
- Brand: "Aira" — AI influencer, warm but sharp, Southeast Asia-focused
- Voice: "Your brilliant, grounded friend who actually cares about your progress"
- Goal: Adapt viral concepts without copying, add local/regional context

INPUT TO SPIN AGENT:
- Original post text
- Original engagement metrics
- Competitor handle
- Hook analysis (from Detection Agent)

OUTPUT FORMAT:
{
    "spun_text": "Rewritten caption in Aira's voice",
    "hook_type": "curiosity|fear|aspiration|humor|contrarian",
    "added_value": "What unique angle we brought",
    "cta": "Call to action",
    "confidence_score": 0.85
}

DELIVER:
- Complete GPT-4o system prompt for the Spin Agent
- 3 example spins showing transformation
- Guidelines for when to reject spinning (inappropriate content, etc.)
```

## Prompt 4: TinyFish Integration

```
Act as a web scraping specialist using TinyFish AgentQL.

I need AgentQL queries and Python integration code to extract TikTok post data.

EXTRACTION REQUIREMENTS:
1. Given a TikTok username, fetch last 10 posts
2. For each post extract:
   - Post text/caption
   - Like count
   - Comment count
   - Share count
   - View count (if available)
   - Timestamp
   - Video URL
   - Thumbnail URL
   - Hashtags

3. Handle pagination for "Load more" scenarios
4. Error handling for private accounts or deleted posts

DELIVER:
- AgentQL query strings for each extraction task
- Python function wrapping TinyFish SDK
- Retry logic for failed requests
- Data validation and cleaning
- Rate limiting compliance (respectful scraping)
```

## Prompt 5: Notification System

```
Act as a DevOps engineer building real-time notification systems.

I need a Discord webhook integration for viral post alerts.

REQUIREMENTS:
- Trigger: When viral_score >= 10.0 (super viral)
- Payload: Rich embed with:
  - Competitor handle
  - Post preview (text + thumbnail)
  - Engagement metrics
  - Viral score
  - Link to spun version
  - CTA buttons (Approve, Edit, Reject)

ADDITIONAL:
- Queue system for batch notifications (don't spam)
- Rate limiting (max 5 alerts per hour)
- Fallback to email if Discord fails

DELIVER:
- Python function for Discord webhook
- Embed formatting code
- Queue/buffer implementation
- Environment variable setup
```

## Prompt 6: Complete MVP Scaffold

```
Act as a hackathon technical lead. I need a complete project scaffold.

PROJECT: "ViralPost Intelligence" — Competitor content monitoring dashboard

GENERATE:

1. PROJECT STRUCTURE
```
viralpost-intelligence/
├── agents/
│   ├── __init__.py
│   ├── scheduler_agent.py
│   ├── extraction_agent.py
│   ├── detection_agent.py
│   ├── spin_agent.py
│   └── notification_agent.py
├── api/
│   ├── main.py (FastAPI)
│   └── routes/
├── dashboard/
│   └── app.py (Streamlit)
├── models/
│   ├── post.py
│   ├── competitor.py
│   └── spin.py
├── services/
│   ├── tinyfish_client.py
│   ├── openai_client.py
│   └── discord_notifier.py
├── database/
│   └── db.py
├── config/
│   └── settings.py
├── tests/
├── requirements.txt
└── README.md
```

2. KEY FILES
- requirements.txt with all dependencies
- config/settings.py with Pydantic settings
- models/ with SQLAlchemy or dataclasses
- Basic FastAPI main.py with health check
- Basic Streamlit app.py with sidebar navigation

3. ENVIRONMENT SETUP
- .env.example with all required variables
- Setup instructions

Focus on "works out of the box" for hackathon demo.
```

---

## Team Roles Required

Based on the project scope, here are the recommended roles:

### Minimum Viable Team (2-3 People)

| Role | Responsibilities | Time Allocation |
|------|------------------|-----------------|
| **Backend Developer** | AgentQL integration, agent logic, API endpoints, database | 50% |
| **Frontend Developer** | Streamlit/React dashboard, data visualization, UI polish | 30% |
| **DevOps/Demo** | Discord webhooks, deployment, demo prep, pitch support | 20% |

### Ideal Team (3-4 People)

| Role | Responsibilities | Skills Needed |
|------|------------------|---------------|
| **Agent Engineer** | TinyFish AgentQL integration, extraction logic, data pipeline | Python, web scraping |
| **AI/ML Engineer** | Viral detection algorithm, GPT-4o integration, spin logic | OpenAI API, prompt engineering |
| **Full-Stack Developer** | Dashboard UI, API endpoints, database, real-time updates | FastAPI, Streamlit/React |
| **Product/Demo Lead** | Demo script, pitch deck, user flow, presentation | Communication, storytelling |

### Role Breakdown by Agent

| Agent | Primary Role | Secondary Role |
|-------|--------------|----------------|
| Scheduler Agent | Backend Dev | DevOps |
| Extraction Agent | Agent Engineer | Backend Dev |
| Detection Agent | AI/ML Engineer | Backend Dev |
| Spin Agent | AI/ML Engineer | Product |
| Notification Agent | DevOps | Backend Dev |
| Dashboard | Full-Stack Dev | Product |

### Recommended Split for Your Team

**Current team:** @wanwei + @TheSignalsLab.Eth + Aira (me)

| Person | Role | Focus |
|--------|------|-------|
| **Benny (@TheSignalsLab.Eth)** | Agent Engineer + AI/ML | Extraction Agent, Detection Agent, Spin Agent |
| **wanwei** | Full-Stack + Product | Dashboard, demo prep, pitch |
| **Aira (me)** | Documentation + Support | Specs, prompts, code scaffolding, real-time assistance |

### External Resources to Leverage

1. **TinyFish engineering support** — Use their Discord for AgentQL questions
2. **OpenAI documentation** — Agents SDK examples
3. **Streamlit gallery** — Dashboard inspiration
4. **Aira (me)** — Generate code, debug, document

---

*Prompts compiled for TinyFish Hackathon 2026*
