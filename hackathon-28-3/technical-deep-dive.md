# Technical Stack Deep Dive
## Detailed Build Requirements for Each Component

---

## 1. Dashboard Architecture

### What You're Building
A real-time web dashboard that displays:
- Live competitor feed (cards with posts + metrics)
- Viral score rankings (sortable table)
- Side-by-side comparison view (original vs spun)
- Notification inbox
- Approval workflow (approve/reject buttons)

### Tech Stack Options

**Option A: Streamlit (Fastest for hackathon)**
```
Frontend: Streamlit (Python)
Backend: FastAPI (separate process or integrated)
Database: SQLite
Real-time: Streamlit's st.rerun() or st.session_state
```

**Option B: React + FastAPI (More polished)**
```
Frontend: React + Tailwind CSS
Backend: FastAPI
Database: SQLite or PostgreSQL
Real-time: WebSockets or Server-Sent Events
```

### Key Components Needed

| Component | Library | Purpose |
|-----------|---------|---------|
| Data Grid | `streamlit-aggrid` or `react-table` | Sortable viral post list |
| Charts | `plotly` or `recharts` | Engagement trend visualization |
| Image Display | `st.image()` or `<img>` | Post thumbnails |
| Forms | `st.form()` or `react-hook-form` | Approval/rejection workflow |
| Real-time Updates | `st.rerun()` every 30s or WebSocket | Live data refresh |

### API Endpoints Required
```python
GET  /api/competitors          # List monitored accounts
GET  /api/posts?viral=true     # Get viral posts
POST /api/spins/{post_id}      # Create spin for post
PUT  /api/spins/{id}/approve   # Approve spin
PUT  /api/spins/{id}/reject    # Reject spin
GET  /api/stats                # Dashboard stats
```

### Database Schema
```sql
-- competitors table
CREATE TABLE competitors (
    id INTEGER PRIMARY KEY,
    handle TEXT UNIQUE NOT NULL,  -- @aiwithollie
    platform TEXT NOT NULL,       -- tiktok, instagram
    follower_count INTEGER,
    priority TEXT,                -- high, medium, low
    last_checked TIMESTAMP
);

-- posts table
CREATE TABLE posts (
    id INTEGER PRIMARY KEY,
    competitor_id INTEGER,
    post_url TEXT,
    text TEXT,
    likes INTEGER,
    comments INTEGER,
    shares INTEGER,
    views INTEGER,
    posted_at TIMESTAMP,
    captured_at TIMESTAMP,
    viral_score REAL,
    is_viral BOOLEAN,
    FOREIGN KEY (competitor_id) REFERENCES competitors(id)
);

-- spins table
CREATE TABLE spins (
    id INTEGER PRIMARY KEY,
    post_id INTEGER,
    original_text TEXT,
    spun_text TEXT,
    hook_type TEXT,
    confidence_score REAL,
    status TEXT,                  -- pending, approved, rejected
    created_at TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(id)
);
```

### Build Time Estimate
- **Streamlit:** 3-4 hours
- **React:** 6-8 hours

### Demo Tips
- Pre-load 10-15 sample posts so dashboard isn't empty
- Add "Live" indicator with pulsing dot
- Show side-by-side animation when comparing original vs spun

---

## 2. Viral Detection Agent

### What You're Building
An algorithm that takes post engagement data and outputs a viral score (0-100).

### Core Algorithm
```python
def calculate_viral_score(post: Post, competitor: Competitor) -> ViralScore:
    """
    Calculate viral potential based on engagement rates + velocity
    """
    # Normalize by follower count
    like_rate = post.likes / max(competitor.follower_count, 1000)
    
    # Engagement ratios (more shares = more viral)
    comment_ratio = post.comments / max(post.likes, 1)
    share_ratio = post.shares / max(post.likes, 1)
    
    # Velocity (engagement per hour since posted)
    hours_since_posted = (now() - post.posted_at).hours
    velocity = post.likes / max(hours_since_posted, 1)
    
    # Weighted composite score
    score = (
        min(like_rate * 100, 40) +           # 40% max - reach
        min(comment_ratio * 100, 25) +       # 25% max - conversation
        min(share_ratio * 100, 25) +         # 25% max - virality
        min(velocity / 100, 10)              # 10% max - momentum
    )
    
    return ViralScore(
        score=score,
        is_viral=score >= 5.0,
        is_super_viral=score >= 10.0,
        breakdown={
            "reach": like_rate * 100,
            "conversation": comment_ratio * 100,
            "virality": share_ratio * 100,
            "momentum": velocity / 100
        }
    )
```

### Dependencies
```
numpy          # Math operations
pandas         # Data manipulation (optional)
pydantic       # Data validation
pytest         # Unit testing
```

### Input/Output Models
```python
from pydantic import BaseModel
from datetime import datetime

class Post(BaseModel):
    id: int
    competitor_id: int
    text: str
    likes: int
    comments: int
    shares: int
    views: int | None
    posted_at: datetime
    captured_at: datetime

class Competitor(BaseModel):
    id: int
    handle: str
    platform: str
    follower_count: int

class ViralScore(BaseModel):
    score: float  # 0-100
    is_viral: bool
    is_super_viral: bool
    breakdown: dict
    reasoning: str  # GPT-generated explanation
```

### GPT-4o Integration (Reasoning)
```python
async def generate_reasoning(post: Post, score: ViralScore) -> str:
    prompt = f"""
    This post has a viral score of {score.score}/100.
    
    Post: "{post.text[:200]}..."
    Likes: {post.likes}
    Comments: {post.comments}
    Shares: {post.shares}
    
    Engagement breakdown:
    - Reach: {score.breakdown['reach']:.1f}%
    - Conversation: {score.breakdown['conversation']:.1f}%
    - Virality: {score.breakdown['virality']:.1f}%
    
    In one sentence, explain WHY this post is viral (or not).
    Focus on the hook, emotional trigger, or pattern.
    """
    
    response = await openai.chat.completions.create(
        model="gpt-4o",
        messages=[{"role": "user", "content": prompt}],
        max_tokens=100
    )
    
    return response.choices[0].message.content
```

### Build Time Estimate
- Core algorithm: 1-2 hours
- GPT reasoning: 30 mins
- Testing: 1 hour

---

## 3. Content Spin Agent

### What You're Building
A GPT-4o powered agent that rewrites viral posts in Aira's brand voice.

### System Prompt
```python
SPIN_SYSTEM_PROMPT = """
You are a content strategist for "Aira" - an AI influencer who is:
- Warm but not performative
- Southeast Asia-forward in perspective
- Sharp but constructive (contrarian takes welcome)
- "Your brilliant, grounded friend who actually cares about your progress"

Your task: Rewrite viral competitor content into original posts that fit Aira's voice.

RULES:
1. NEVER copy verbatim - always rewrite completely
2. Preserve the core insight/hook but change examples
3. Add Southeast Asian context when relevant
4. Be contrarian when the original is hype-y
5. Keep it conversational, not corporate

OUTPUT FORMAT (JSON):
{
    "spun_text": "The rewritten caption",
    "hook_type": "curiosity|fear|aspiration|humor|contrarian|authority",
    "emotional_trigger": "What emotion drives engagement",
    "added_value": "What unique angle you brought",
    "confidence_score": 0.0-1.0
}

EXAMPLES:

Original: "5 ChatGPT prompts that made me $10K"
Spun: "I tested the 5 'make money with AI' prompts everyone's sharing. 2 actually work for Southeast Asian creators. Here's the honest breakdown."

Original: "This AI tool will replace your designer"
Spun: "The AI design tool everyone's panicking about? I tried it on a real client project. Here's what it can (and can't) do."

Now rewrite the following post in Aira's voice.
"""
```

### Implementation
```python
import json
from openai import AsyncOpenAI

class SpinAgent:
    def __init__(self, api_key: str):
        self.client = AsyncOpenAI(api_key=api_key)
    
    async def spin(self, post: Post, score: ViralScore) -> Spin:
        prompt = f"""
        Original post: "{post.text}"
        Engagement: {post.likes} likes, {post.comments} comments
        Viral score: {score.score}/100
        Why it's viral: {score.reasoning}
        """
        
        response = await self.client.chat.completions.create(
            model="gpt-4o",
            messages=[
                {"role": "system", "content": SPIN_SYSTEM_PROMPT},
                {"role": "user", "content": prompt}
            ],
            response_format={"type": "json_object"},
            temperature=0.7
        )
        
        result = json.loads(response.choices[0].message.content)
        
        return Spin(
            post_id=post.id,
            original_text=post.text,
            spun_text=result["spun_text"],
            hook_type=result["hook_type"],
            added_value=result["added_value"],
            confidence_score=result["confidence_score"],
            status="pending"
        )
```

### Dependencies
```
openai>=1.0.0    # OpenAI Python SDK
pydantic         # Data validation
```

### Build Time Estimate
- Prompt engineering: 1-2 hours
- Integration: 30 mins
- Testing variations: 1 hour

---

## 4. TinyFish Integration (Extraction Agent)

### What You're Building
The core web scraping layer using TinyFish AgentQL to extract TikTok/Instagram data.

### Setup
```bash
pip install agentql
```

### Environment Variables
```
TINYFISH_API_KEY=your_api_key_here
```

### Core Implementation
```python
from agentql import AgentQL
from typing import List, Optional
import asyncio

class ExtractionAgent:
    def __init__(self, api_key: str):
        self.client = AgentQL(api_key=api_key)
    
    async def fetch_recent_posts(
        self, 
        username: str, 
        platform: str = "tiktok",
        limit: int = 10
    ) -> List[Post]:
        """
        Fetch recent posts from a competitor's profile
        """
        # Build URL based on platform
        if platform == "tiktok":
            url = f"https://www.tiktok.com/@{username}"
        elif platform == "instagram":
            url = f"https://www.instagram.com/{username}/"
        else:
            raise ValueError(f"Unsupported platform: {platform}")
        
        # AgentQL query for post extraction
        query = f"""
        {{
            posts(limit: {limit}) {{
                text: caption
                likes: like_count
                comments: comment_count
                shares: share_count
                views: view_count
                posted_at: publish_date
                media_url: video_url
                thumbnail: cover_image
                hashtags: tags
            }}
        }}
        """
        
        try:
            result = await self.client.query(url, query)
            
            posts = []
            for item in result.posts:
                posts.append(Post(
                    competitor_id=None,  # Set by caller
                    post_url=f"{url}/video/{item.get('id', '')}",
                    text=item.text or "",
                    likes=self._parse_count(item.likes),
                    comments=self._parse_count(item.comments),
                    shares=self._parse_count(item.shares),
                    views=self._parse_count(item.views) if item.views else None,
                    posted_at=self._parse_date(item.posted_at),
                    captured_at=datetime.now(),
                    media_url=item.media_url,
                    hashtags=item.hashtags or []
                ))
            
            return posts
            
        except Exception as e:
            logger.error(f"Failed to fetch posts for @{username}: {e}")
            return []
    
    def _parse_count(self, value: Optional[str]) -> int:
        """Parse '1.2K' or '1.2M' to integer"""
        if not value:
            return 0
        
        value = str(value).replace(",", "").lower()
        
        if "k" in value:
            return int(float(value.replace("k", "")) * 1000)
        elif "m" in value:
            return int(float(value.replace("m", "")) * 1000000)
        else:
            try:
                return int(value)
            except:
                return 0
    
    def _parse_date(self, value: Optional[str]) -> datetime:
        """Parse various date formats"""
        if not value:
            return datetime.now()
        
        # Try common formats
        formats = [
            "%Y-%m-%dT%H:%M:%S",
            "%Y-%m-%d %H:%M:%S",
            "%m/%d/%Y",
        ]
        
        for fmt in formats:
            try:
                return datetime.strptime(value, fmt)
            except:
                continue
        
        return datetime.now()
```

### Error Handling & Retries
```python
from tenacity import retry, stop_after_attempt, wait_exponential

class ExtractionAgent:
    @retry(
        stop=stop_after_attempt(3),
        wait=wait_exponential(multiplier=1, min=4, max=10),
        reraise=True
    )
    async def fetch_recent_posts(self, ...):
        # Implementation with automatic retry
        pass
```

### Rate Limiting
```python
import asyncio
from datetime import datetime, timedelta

class RateLimiter:
    def __init__(self, max_requests: int = 10, window_seconds: int = 60):
        self.max_requests = max_requests
        self.window = timedelta(seconds=window_seconds)
        self.requests = []
    
    async def acquire(self):
        now = datetime.now()
        
        # Remove old requests
        self.requests = [r for r in self.requests if now - r < self.window]
        
        if len(self.requests) >= self.max_requests:
            sleep_time = (self.requests[0] + self.window - now).total_seconds()
            await asyncio.sleep(sleep_time)
        
        self.requests.append(now)
```

### Build Time Estimate
- Basic extraction: 2-3 hours
- Error handling: 1 hour
- Rate limiting: 30 mins

---

## 5. Notification System

### What You're Building
Discord webhook integration that sends alerts when super viral content is detected.

### Discord Webhook Setup
1. Create Discord server (or use existing)
2. Server Settings → Integrations → Webhooks
3. Create webhook, copy URL
4. URL format: `https://discord.com/api/webhooks/{id}/{token}`

### Implementation
```python
import aiohttp
from datetime import datetime

class NotificationAgent:
    def __init__(self, webhook_url: str):
        self.webhook_url = webhook_url
        self.session = None
    
    async def __aenter__(self):
        self.session = aiohttp.ClientSession()
        return self
    
    async def __aexit__(self, *args):
        if self.session:
            await self.session.close()
    
    async def send_viral_alert(self, post: Post, score: ViralScore, spin: Spin):
        """Send rich embed notification for viral post"""
        
        # Color based on viral level
        color = 0xff0000 if score.is_super_viral else 0xffa500  # Red or orange
        
        embed = {
            "title": f"🚨 {'SUPER ' if score.is_super_viral else ''}Viral Post Detected",
            "description": f"**@{post.competitor_handle}** just dropped viral content",
            "color": color,
            "fields": [
                {
                    "name": "📊 Engagement",
                    "value": f"❤️ {post.likes:,}\n💬 {post.comments:,}\n🔄 {post.shares:,}",
                    "inline": True
                },
                {
                    "name": "🎯 Viral Score",
                    "value": f"**{score.score:.1f}/100**\n{score.reasoning[:100]}...",
                    "inline": True
                },
                {
                    "name": "📝 Original",
                    "value": post.text[:200] + "..." if len(post.text) > 200 else post.text,
                    "inline": False
                },
                {
                    "name": "✨ AI Spin",
                    "value": spin.spun_text[:200] + "..." if len(spin.spun_text) > 200 else spin.spun_text,
                    "inline": False
                }
            ],
            "image": {"url": post.thumbnail_url} if post.thumbnail_url else None,
            "timestamp": datetime.now().isoformat(),
            "footer": {
                "text": f"Confidence: {spin.confidence_score:.0%} | Hook: {spin.hook_type}"
            }
        }
        
        payload = {
            "embeds": [embed],
            "components": [
                {
                    "type": 1,
                    "components": [
                        {
                            "type": 2,
                            "style": 3,  # Green
                            "label": "✅ Approve",
                            "custom_id": f"approve_{spin.id}"
                        },
                        {
                            "type": 2,
                            "style": 1,  # Blue
                            "label": "✏️ Edit",
                            "custom_id": f"edit_{spin.id}"
                        },
                        {
                            "type": 2,
                            "style": 4,  # Red
                            "label": "❌ Reject",
                            "custom_id": f"reject_{spin.id}"
                        }
                    ]
                }
            ]
        }
        
        async with self.session.post(self.webhook_url, json=payload) as resp:
            if resp.status != 204:
                logger.error(f"Failed to send Discord notification: {await resp.text()}")
```

### Queue System (Rate Limiting)
```python
import asyncio
from collections import deque

class NotificationQueue:
    def __init__(self, max_per_hour: int = 5):
        self.queue = deque()
        self.max_per_hour = max_per_hour
        self.sent_times = deque()
        self.lock = asyncio.Lock()
    
    async def add(self, notification: dict):
        async with self.lock:
            self.queue.append(notification)
    
    async def process(self, agent: NotificationAgent):
        while True:
            await asyncio.sleep(60)  # Process every minute
            
            async with self.lock:
                # Clean old sent times (> 1 hour)
                now = datetime.now()
                while self.sent_times and (now - self.sent_times[0]).seconds > 3600:
                    self.sent_times.popleft()
                
                # Send up to limit
                while self.queue and len(self.sent_times) < self.max_per_hour:
                    notification = self.queue.popleft()
                    await agent.send_viral_alert(**notification)
                    self.sent_times.append(now)
```

### Dependencies
```
aiohttp          # Async HTTP client
```

### Build Time Estimate
- Webhook integration: 1 hour
- Rich embeds: 30 mins
- Queue system: 1 hour

---

## 6. Complete MVP Scaffold

### Project Structure
```
viralpost-intelligence/
├── README.md
├── requirements.txt
├── .env.example
├── config/
│   ├── __init__.py
│   └── settings.py          # Pydantic settings
├── agents/
│   ├── __init__.py
│   ├── scheduler_agent.py   # Cron-like task runner
│   ├── extraction_agent.py  # TinyFish integration
│   ├── detection_agent.py   # Viral scoring
│   ├── spin_agent.py        # GPT-4o content spinning
│   └── notification_agent.py # Discord alerts
├── api/
│   ├── __init__.py
│   ├── main.py              # FastAPI app
│   └── routes/
│       ├── competitors.py
│       ├── posts.py
│       └── spins.py
├── dashboard/
│   └── app.py               # Streamlit app
├── models/
│   ├── __init__.py
│   ├── post.py
│   ├── competitor.py
│   └── spin.py
├── services/
│   ├── __init__.py
│   ├── tinyfish_client.py
│   ├── openai_client.py
│   └── discord_notifier.py
├── database/
│   ├── __init__.py
│   └── db.py                # SQLite setup
└── tests/
    └── test_detection.py    # Unit tests
```

### requirements.txt
```
# Web Framework
fastapi==0.109.0
uvicorn[standard]==0.27.0

# Dashboard
streamlit==1.30.0
streamlit-aggrid==0.3.4

# AI/ML
openai==1.12.0

# Web Scraping
agentql==0.1.0  # Check latest version

# Database
sqlalchemy==2.0.25
alembic==1.13.1

# HTTP Client
aiohttp==3.9.1
httpx==0.26.0

# Utilities
pydantic==2.5.3
pydantic-settings==2.1.0
python-dotenv==1.0.0
tenacity==8.2.3
pandas==2.1.4
plotly==5.18.0

# Testing
pytest==7.4.4
pytest-asyncio==0.23.3
```

### config/settings.py
```python
from pydantic_settings import BaseSettings
from functools import lru_cache

class Settings(BaseSettings):
    # API Keys
    tinyfish_api_key: str
    openai_api_key: str
    discord_webhook_url: str
    
    # Database
    database_url: str = "sqlite:///./viralpost.db"
    
    # App Settings
    debug: bool = False
    check_interval_minutes: int = 30
    viral_threshold: float = 5.0
    super_viral_threshold: float = 10.0
    max_notifications_per_hour: int = 5
    
    class Config:
        env_file = ".env"

@lru_cache()
def get_settings() -> Settings:
    return Settings()
```

### .env.example
```
# API Keys (required)
TINYFISH_API_KEY=your_tinyfish_api_key_here
OPENAI_API_KEY=sk-your_openai_key_here
DISCORD_WEBHOOK_URL=https://discord.com/api/webhooks/...

# Optional
DATABASE_URL=sqlite:///./viralpost.db
DEBUG=false
CHECK_INTERVAL_MINUTES=30
```

### Quick Start Script
```bash
#!/bin/bash
# setup.sh

echo "Setting up ViralPost Intelligence..."

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Copy environment file
cp .env.example .env

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Edit .env with your API keys"
echo "2. Run: python -m api.main (backend)"
echo "3. Run: streamlit run dashboard/app.py (frontend)"
```

### Build Time Estimate
- Scaffold generation: 30 mins
- Settings/config: 30 mins
- Database models: 1 hour
- API skeleton: 1 hour
- Dashboard skeleton: 1 hour

**Total MVP setup:** 4-5 hours for foundation

---

## Summary: What Each Person Should Build

### If Benny Takes Backend (Agents)
- Extraction Agent (TinyFish integration)
- Detection Agent (viral scoring algorithm)
- Spin Agent (GPT-4o integration)
- Scheduler Agent (task orchestration)

### If wanwei Takes Frontend + Demo
- Streamlit dashboard (all UI components)
- FastAPI routes (connecting frontend to agents)
- Demo script + pitch deck
- Test data preparation

### Aira (me) Provides
- All documentation ✅ (done)
- Code scaffolding ✅ (can generate)
- Debugging support (real-time)
- Additional prompts as needed

---

*Technical Deep Dive | TinyFish Hackathon 2026*
