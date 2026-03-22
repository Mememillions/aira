# Complete AI Prompts for Tasks 3, 4, 5, 6
## Copy-Paste Ready for Claude/ChatGPT

---

## TASK 3: Content Spin Agent (GPT-4o Integration)

```
Act as an AI prompt engineer and copywriter specializing in social media content adaptation.

PROJECT CONTEXT:
- Brand: "Aira" — AI influencer, community anchor for ANCHR AI Labs
- Voice: Warm but not performative, Southeast Asia-forward, sharp but constructive
- Tone: "Your brilliant, grounded friend who actually cares about your progress"
- Goal: Rewrite viral competitor content into original posts that fit Aira's brand

WHAT TO BUILD:
A Python class that uses GPT-4o to spin viral TikTok posts into Aira's voice.

REQUIREMENTS:

1. SYSTEM PROMPT FOR GPT-4o
Create a comprehensive system prompt that defines Aira's voice and spin rules:

SYSTEM_PROMPT = """
You are a content strategist for "Aira" — an AI influencer with these traits:

VOICE CHARACTERISTICS:
- Warm but not performative (no fake enthusiasm)
- Southeast Asia-forward perspective (not US-centric)
- Sharp but constructive (contrarian takes welcome, but not mean)
- "Your brilliant, grounded friend who actually cares about your progress"
- Uses "fam", "we", "us" naturally — not forced
- Credits community members, lifts people up

SPIN RULES:
1. NEVER copy verbatim — always rewrite completely
2. Preserve the core insight/hook but change all examples
3. Add Southeast Asian context when relevant (Singapore, Malaysia, Indonesia, Philippines)
4. Be contrarian when original is hype-y or overpromising
5. Keep it conversational, never corporate
6. One good question is better than five shallow ones
7. Drop emojis when they earn their place (not decoration)

OUTPUT FORMAT (JSON):
{
    "spun_text": "The rewritten caption (100-300 chars ideal)",
    "hook_type": "curiosity|fear|aspiration|humor|contrarian|authority|general",
    "emotional_trigger": "What emotion drives engagement (1-2 words)",
    "added_value": "What unique angle we brought (1 sentence)",
    "cta": "Call to action (optional)",
    "confidence_score": 0.0-1.0
}

SPIN EXAMPLES:

Original: "5 ChatGPT prompts that made me $10K this month"
Analysis: Aspirational hook, money-focused, US-centric example
Spun: "I tested the 5 'make money with AI' prompts everyone's sharing. 2 actually work for Southeast Asian creators. Here's the honest breakdown."
Hook Type: aspiration → contrarian
Added Value: Regional context, honest testing

Original: "This AI tool will replace your designer"
Analysis: Fear-based, extreme claim, hype
Spun: "The AI design tool everyone's panicking about? I tried it on a real client project. Here's what it can (and can't) do."
Hook Type: fear → contrarian/authority
Added Value: Real testing, balanced take

Original: "Nobody is talking about this AI feature"
Analysis: Curiosity gap, FOMO
Spun: "The AI feature 90% of creators ignore — and why that's actually smart for most of us."
Hook Type: curiosity → contrarian
Added Value: Counter-intuitive take

TASK:
Rewrite the following viral post in Aira's voice. Follow all rules above. Return valid JSON only.
"""

2. PYTHON IMPLEMENTATION

class SpinAgent:
    def __init__(self, api_key: str, model: str = "gpt-4o"):
        self.client = OpenAI(api_key=api_key)
        self.model = model
        self.system_prompt = SYSTEM_PROMPT
    
    async def spin_post(self, post: Post, viral_score: ViralScore) -> Spin:
        \"\"\"
        Generate AI spin for a viral post
        
        Args:
            post: Post dataclass with text, likes, etc.
            viral_score: ViralScore with reasoning
        
        Returns:
            Spin dataclass with spun_text, hook_type, etc.
        \"\"\"
        # Build user prompt with context
        user_prompt = f\"\"\"
        ORIGINAL POST:
        \"{post.text}\"
        
        ENGAGEMENT:
        - Likes: {post.likes:,}
        - Comments: {post.comments:,}
        - Shares: {post.shares:,}
        
        WHY IT'S VIRAL:
        {viral_score.reasoning}
        
        Create a spin in Aira's voice. Return JSON only.
        \"\"\"
        
        # Call GPT-4o
        response = await self.client.chat.completions.create(
            model=self.model,
            messages=[
                {\"role\": \"system\", \"content\": self.system_prompt},
                {\"role\": \"user\", \"content\": user_prompt}
            ],
            response_format={\"type\": \"json_object\"},
            temperature=0.7,
            max_tokens=500
        )
        
        # Parse JSON response
        result = json.loads(response.choices[0].message.content)
        
        return Spin(
            post_id=post.id,
            original_text=post.text,
            spun_text=result[\"spun_text\"],
            hook_type=result[\"hook_type\"],
            emotional_trigger=result[\"emotional_trigger\"],
            added_value=result[\"added_value\"],
            cta=result.get(\"cta\", \"\"),
            confidence_score=result[\"confidence_score\"],
            status=\"pending\",
            created_at=datetime.now()
        )
    
    def spin_sync(self, post: Post, viral_score: ViralScore) -> Spin:
        \"\"\"Synchronous version for simple use cases\"\"\"
        return asyncio.run(self.spin_post(post, viral_score))

3. DATA MODELS

from dataclasses import dataclass
from datetime import datetime
from typing import Optional

@dataclass
class Spin:
    id: Optional[int] = None
    post_id: int = 0
    original_text: str = ""
    spun_text: str = ""
    hook_type: str = "general"
    emotional_trigger: str = ""
    added_value: str = ""
    cta: str = ""
    confidence_score: float = 0.0
    status: str = "pending"  # pending, approved, rejected
    created_at: Optional[datetime] = None

4. TEST CASES

Include 5 test cases with expected outputs:

Test 1: Money/promise post
Input: "How I made $50K in 30 days using AI"
Expected hook_type: aspiration or contrarian
Expected: Challenge the claim, add skepticism

Test 2: Listicle post  
Input: "10 AI tools you need in 2026"
Expected hook_type: curiosity or contrarian
Expected: Narrow to specific use case, add regional context

Test 3: Fear-based post
Input: "This AI will replace your job in 6 months"
Expected hook_type: fear → contrarian
Expected: Calming take, nuance, historical context

Test 4: Secret/tip post
Input: "The AI prompt nobody is sharing"
Expected hook_type: curiosity
Expected: Acknowledge + add twist

Test 5: Community/engagement post
Input: "What's your favorite AI tool? Comment below!"
Expected hook_type: general
Expected: Convert to statement/insight

5. ERROR HANDLING

- Handle JSON parsing errors gracefully
- Return default spin if GPT fails
- Log failures for debugging
- Retry once on rate limit

DELIVERABLES:
1. spin_agent.py — Complete SpinAgent class
2. test_spin_agent.py — 5+ test cases
3. demo_spins.json — 10 example spins for demo
4. requirements.txt — openai, pydantic

EVALUATION:
- Spun text should sound like Aira (warm, SEA-focused, contrarian)
- Should never copy original phrasing
- JSON output must be valid
- Confidence scores should reflect spin quality
```

---

## TASK 4: TinyFish Integration (Extraction Agent)

```
Act as a web scraping engineer specializing in social media data extraction.

PROJECT CONTEXT:
- Tool: TinyFish AgentQL (natural language web scraping)
- Target: TikTok and Instagram posts
- Goal: Extract structured data from competitor profiles
- Challenge: Dynamic content, anti-bot protection

WHAT TO BUILD:
A robust extraction agent that fetches posts from TikTok/Instagram using TinyFish AgentQL.

REQUIREMENTS:

1. SETUP & CONFIGURATION

Environment variables:
TINYFISH_API_KEY=your_api_key_here

Dependencies:
agentql>=0.1.0
aiohttp>=3.9.0
pydantic>=2.0.0

2. CORE AGENTQL QUERIES

Query 1: Extract profile info
```
{
    profile {
        username
        display_name
        follower_count
        following_count
        total_likes
        bio
        verified
    }
}
```

Query 2: Extract recent posts (main query)
```
{
    posts(limit: 10) {
        id
        caption
        likes: like_count
        comments: comment_count
        shares: share_count
        views: view_count
        posted_at: publish_date
        duration: video_length
        music: sound_name
        hashtags: tags
        mentions: tagged_users
        video_url
        thumbnail_url
        is_pinned
    }
}
```

Query 3: Extract single post details
```
{
    post(id: "...") {
        caption
        likes
        comments
        shares
        comments_list(limit: 5) {
            username
            text
            likes
        }
    }
}
```

3. PYTHON IMPLEMENTATION

class ExtractionAgent:
    def __init__(self, api_key: str):
        self.api_key = api_key
        self.client = AgentQL(api_key=api_key)
        self.rate_limiter = RateLimiter(max_requests=10, window=60)
    
    async def fetch_profile(self, username: str, platform: str = "tiktok") -> Competitor:
        \"\"\"Fetch competitor profile info\"\"\"
        url = self._build_url(username, platform)
        query = \"\"\"
        {
            profile {
                username
                display_name
                follower_count
                following_count
                total_likes
                bio
                verified
            }
        }
        \"\"\"
        
        result = await self._execute_query(url, query)
        profile = result.profile
        
        return Competitor(
            handle=f\"@{profile.username}\",
            platform=platform,
            follower_count=self._parse_count(profile.follower_count),
            bio=profile.bio,
            verified=profile.verified
        )
    
    async def fetch_recent_posts(
        self, 
        username: str, 
        platform: str = "tiktok",
        limit: int = 10
    ) -> List[Post]:
        \"\"\"Fetch recent posts from competitor\"\"\"
        url = self._build_url(username, platform)
        
        query = f\"\"\"
        {{
            posts(limit: {limit}) {{
                id
                caption
                likes: like_count
                comments: comment_count
                shares: share_count
                views: view_count
                posted_at: publish_date
                hashtags: tags
                video_url
                thumbnail_url
            }}
        }}
        \"\"\"
        
        result = await self._execute_query(url, query)
        
        posts = []
        for item in result.posts:
            posts.append(Post(
                competitor_id=None,  # Set by caller
                post_url=f\"{url}/video/{item.id}\",
                text=item.caption or \"\",
                likes=self._parse_count(item.likes),
                comments=self._parse_count(item.comments),
                shares=self._parse_count(item.shares),
                views=self._parse_count(item.views) if item.views else None,
                posted_at=self._parse_date(item.posted_at),
                captured_at=datetime.now(),
                hashtags=item.hashtags or []
            ))
        
        return posts
    
    def _build_url(self, username: str, platform: str) -> str:
        \"\"\"Build profile URL from username\"\"\"
        username = username.lstrip(\"@\")
        
        if platform == \"tiktok\":
            return f\"https://www.tiktok.com/@{username}\"
        elif platform == \"instagram\":
            return f\"https://www.instagram.com/{username}/\"
        else:
            raise ValueError(f\"Unsupported platform: {platform}\")
    
    def _parse_count(self, value: Optional[str]) -> int:
        \"\"\"Parse '1.2K' or '1.2M' to integer\"\"\"
        if not value or value == \"\":
            return 0
        
        value = str(value).replace(\",\", \"\").lower().strip()
        
        if \"k\" in value:
            try:
                return int(float(value.replace(\"k\", \"\")) * 1000)
            except:
                return 0
        elif \"m\" in value:
            try:
                return int(float(value.replace(\"m\", \"\")) * 1000000)
            except:
                return 0
        else:
            try:
                return int(float(value))
            except:
                return 0
    
    def _parse_date(self, value: Optional[str]) -> datetime:
        \"\"\"Parse various date formats\"\"\"
        if not value:
            return datetime.now()
        
        formats = [
            \"%Y-%m-%dT%H:%M:%S\",
            \"%Y-%m-%d %H:%M:%S\",
            \"%m/%d/%Y\",
            \"%d/%m/%Y\",
        ]
        
        for fmt in formats:
            try:
                return datetime.strptime(value, fmt)
            except:
                continue
        
        # Try relative parsing (e.g., \"2h ago\")
        return self._parse_relative_date(value)
    
    def _parse_relative_date(self, value: str) -> datetime:
        \"\"\"Parse relative time like '2h ago', '1d ago'\"\"\"
        value = value.lower().replace(\"ago\", \"\").strip()
        
        now = datetime.now()
        
        if \"h\" in value:
            try:
                hours = int(value.replace(\"h\", \"\").strip())
                return now - timedelta(hours=hours)
            except:
                pass
        elif \"d\" in value:
            try:
                days = int(value.replace(\"d\", \"\").strip())
                return now - timedelta(days=days)
            except:
                pass
        
        return now
    
    async def _execute_query(self, url: str, query: str) -> dict:
        \"\"\"Execute AgentQL query with rate limiting and retries\"\"\"
        await self.rate_limiter.acquire()
        
        max_retries = 3
        for attempt in range(max_retries):
            try:
                result = await self.client.query(url, query)
                return result
            except RateLimitError:
                wait_time = 2 ** attempt  # Exponential backoff
                await asyncio.sleep(wait_time)
            except Exception as e:
                if attempt == max_retries - 1:
                    raise
                await asyncio.sleep(1)
        
        raise Exception(\"Max retries exceeded\")

4. RATE LIMITER

class RateLimiter:
    def __init__(self, max_requests: int = 10, window_seconds: int = 60):
        self.max_requests = max_requests
        self.window = timedelta(seconds=window_seconds)
        self.requests = []
        self.lock = asyncio.Lock()
    
    async def acquire(self):
        async with self.lock:
            now = datetime.now()
            
            # Remove old requests outside window
            cutoff = now - self.window
            self.requests = [r for r in self.requests if r > cutoff]
            
            if len(self.requests) >= self.max_requests:
                # Wait until oldest request expires
                sleep_seconds = (self.requests[0] + self.window - now).total_seconds()
                await asyncio.sleep(max(sleep_seconds, 0))
            
            self.requests.append(now)

5. ERROR HANDLING

- Private accounts: Return empty list with warning
- Deleted posts: Skip gracefully
- Network errors: Retry with backoff
- Parse errors: Use defaults, log warning
- Rate limits: Automatic backoff and retry

6. TESTING

Create mock responses for testing without API calls:

@pytest.fixture
def mock_tiktok_response():
    return {
        \"profile\": {
            \"username\": \"aiwithollie\",
            \"follower_count\": \"125.5K\",
            \"verified\": True
        },
        \"posts\": [
            {
                \"id\": \"123456\",
                \"caption\": \"5 AI tools you need!\",
                \"like_count\": \"45.2K\",
                \"comment_count\": \"1.2K\",
                \"share_count\": \"3.4K\",
                \"publish_date\": \"2h ago\"
            }
        ]
    }

DELIVERABLES:
1. extraction_agent.py — Complete ExtractionAgent class
2. test_extraction_agent.py — Unit tests with mocks
3. rate_limiter.py — Rate limiting utility
4. example_usage.py — Working examples
5. requirements.txt

EVALUATION:
- Correctly parses all count formats (1.2K, 1.5M, raw numbers)
- Handles relative dates (2h ago, 1d ago)
- Respects rate limits
- Graceful error handling
- Clean, documented code
```

---

## TASK 5: Notification System (Discord)

```
Act as a backend engineer building real-time notification systems.

PROJECT CONTEXT:
- Platform: Discord (via webhooks)
- Trigger: When viral_score >= 10.0 (super viral)
- Goal: Alert team with rich, actionable notifications

WHAT TO BUILD:
A notification agent that sends rich embed alerts to Discord when super viral content is detected.

REQUIREMENTS:

1. DISCORD WEBHOOK SETUP

To get webhook URL:
1. Create Discord server (or use existing)
2. Server Settings → Integrations → Webhooks
3. New Webhook → Select channel → Copy URL
4. URL format: https://discord.com/api/webhooks/{id}/{token}

Environment:
DISCORD_WEBHOOK_URL=https://discord.com/api/webhooks/...

2. NOTIFICATION AGENT

class NotificationAgent:
    def __init__(self, webhook_url: str):
        self.webhook_url = webhook_url
        self.session = None
        self.queue = NotificationQueue(max_per_hour=5)
    
    async def __aenter__(self):
        self.session = aiohttp.ClientSession()
        return self
    
    async def __aexit__(self, *args):
        if self.session:
            await self.session.close()
    
    async def send_viral_alert(self, post: Post, viral_score: ViralScore, spin: Spin):
        \"\"\"Send rich embed notification for super viral post\"\"\"
        
        # Only send for super viral content
        if not viral_score.is_super_viral:
            return
        
        # Build rich embed
        embed = {
            \"title\": \"🚨 SUPER VIRAL POST DETECTED\",
            \"description\": f\"**{post.competitor_handle}** just dropped fire content 🔥\",
            \"color\": 0xFF0000,  # Red for urgency
            \"fields\": [
                {
                    \"name\": \"📊 Engagement\",
                    \"value\": f\"❤️ {self._format_number(post.likes)}\\n💬 {self._format_number(post.comments)}\\n🔄 {self._format_number(post.shares)}\",
                    \"inline\": True
                },
                {
                    \"name\": \"🎯 Viral Score\",
                    \"value\": f\"**{viral_score.score:.1f}/100**\\n{viral_score.hook_type.upper()} hook\\n{viral_score.reasoning[:80]}...\",
                    \"inline\": True
                },
                {
                    \"name\": \"📝 Original Post\",
                    \"value\": post.text[:200] + (\"...\" if len(post.text) > 200 else \"\"),
                    \"inline\": False
                },
                {
                    \"name\": \"✨ AI Spin Ready\",
                    \"value\": spin.spun_text[:200] + (\"...\" if len(spin.spun_text) > 200 else \"\"),
                    \"inline\": False
                }
            ],
            \"image\": {\"url\": post.thumbnail_url} if post.thumbnail_url else None,
            \"timestamp\": datetime.now().isoformat(),
            \"footer\": {
                \"text\": f\"Confidence: {spin.confidence_score:.0%} | Click buttons below to approve/reject\"
            }
        }
        
        # Build payload with buttons
        payload = {
            \"content\": f\"@here New viral content from {post.competitor_handle}!\",
            \"embeds\": [embed],
            \"components\": [
                {
                    \"type\": 1,  # Action row
                    \"components\": [
                        {
                            \"type\": 2,  # Button
                            \"style\": 3,  # Green
                            \"label\": \"✅ Approve & Queue\",
                            \"custom_id\": f\"approve_{spin.id}\",
                            \"emoji\": {\"name\": \"✅\"}
                        },
                        {
                            \"type\": 2,
                            \"style\": 1,  # Blue
                            \"label\": \"✏️ Edit in Dashboard\",
                            \"custom_id\": f\"edit_{spin.id}\",
                            \"emoji\": {\"name\": \"✏️\"}
                        },
                        {
                            \"type\": 2,
                            \"style\": 4,  # Red
                            \"label\": \"❌ Reject\",
                            \"custom_id\": f\"reject_{spin.id}\",
                            \"emoji\": {\"name\": \"❌\"}
                        }
                    ]
                }
            ]
        }
        
        async with self.session.post(self.webhook_url, json=payload) as resp:
            if resp.status == 204:
                return True
            else:
                logger.error(f\"Discord webhook failed: {resp.status}\")
                return False
    
    def _format_number(self, n: int) -> str:
        \"\"\"Format large numbers (45000 → 45K)\"\"\"
        if n >= 1000000:
            return f\"{n/1000000:.1f}M\"
        elif n >= 1000:
            return f\"{n/1000:.1f}K\"
        return str(n)

3. NOTIFICATION QUEUE

class NotificationQueue:
    \"\"\"Rate-limited notification queue\"\"\"
    
    def __init__(self, max_per_hour: int = 5):
        self.max_per_hour = max_per_hour
        self.pending = asyncio.Queue()
        self.sent_times = []
        self.lock = asyncio.Lock()
    
    async def add(self, notification: dict):
        \"\"\"Add notification to queue\"\"\"
        await self.pending.put(notification)
    
    async def process(self, agent: NotificationAgent):
        \"\"\"Process queue with rate limiting\"\"\"
        while True:
            # Clean old sent times
            now = datetime.now()
            cutoff = now - timedelta(hours=1)
            self.sent_times = [t for t in self.sent_times if t > cutoff]
            
            # Check if we can send
            if len(self.sent_times) < self.max_per_hour:
                try:
                    notification = await asyncio.wait_for(
                        self.pending.get(), timeout=60
                    )
                    await agent.send_viral_alert(**notification)
                    self.sent_times.append(now)
                except asyncio.TimeoutError:
                    continue
            else:
                # Wait until next hour
                await asyncio.sleep(300)  # 5 minutes

4. SIMPLIFIED VERSION (For MVP)

If time is tight, use this minimal version:

import requests

def send_viral_alert_simple(webhook_url: str, post: dict, score: float):
    \"\"\"Simple notification without rich embeds\"\"\"
    
    if score < 10:
        return
    
    message = f\"\"\"
🚨 **SUPER VIRAL POST**

@{post['competitor']} - Score: {score:.1f}/100

{post['text'][:150]}...

❤️ {post['likes']:,} | 💬 {post['comments']:,} | 🔄 {post['shares']:,}

View in dashboard: http://localhost:8501
    \"\"\".strip()
    
    requests.post(webhook_url, json={\"content\": message})

5. TESTING

Test webhook with curl first:

curl -X POST -H \"Content-Type: application/json\" \
  -d '{\"content\": \"Test message from ViralPost\"}' \
  YOUR_WEBHOOK_URL

DELIVERABLES:
1. notification_agent.py — Complete agent
2. notification_queue.py — Rate limiting
3. simple_version.py — Minimal MVP version
4. test_notifications.py — Unit tests
5. setup_instructions.md — Discord webhook guide

EVALUATION:
- Rich embeds display correctly in Discord
- Rate limiting prevents spam
- Buttons (if used) have correct custom_ids
- Graceful handling of webhook failures
```

---

## TASK 6: Complete MVP Scaffold

```
Act as a technical lead architecting a complete hackathon project.

PROJECT: ViralPost Intelligence — Competitor content monitoring for AI influencers

GOAL: Generate a complete, runnable project structure that compiles all components.

REQUIREMENTS:

1. PROJECT STRUCTURE

viralpost-intelligence/
├── README.md                          # Project overview
├── requirements.txt                   # All dependencies
├── .env.example                       # Environment template
├── setup.py                           # Quick setup script
│
├── config/
│   ├── __init__.py
│   └── settings.py                    # Pydantic settings management
│
├── agents/                            # All agent implementations
│   ├── __init__.py
│   ├── scheduler_agent.py            # Task orchestration
│   ├── extraction_agent.py           # TinyFish integration
│   ├── detection_agent.py            # Viral scoring
│   ├── spin_agent.py                 # GPT-4o content spinning
│   └── notification_agent.py         # Discord alerts
│
├── dashboard/                         # Streamlit UI
│   ├── __init__.py
│   └── app.py                        # Main Streamlit app
│
├── models/                           # Data models
│   ├── __init__.py
│   ├── competitor.py
│   ├── post.py
│   └── spin.py
│
├── database/                         # Database layer
│   ├── __init__.py
│   ├── db.py                        # SQLite setup
│   └── seed.py                      # Sample data
│
├── services/                         # External services
│   ├── __init__.py
│   ├── tinyfish_client.py
│   ├── openai_client.py
│   └── discord_client.py
│
├── utils/                           # Utilities
│   ├── __init__.py
│   ├── rate_limiter.py
│   └── formatters.py                # Number/date formatting
│
└── tests/                           # Test suite
    ├── __init__.py
    ├── test_detection.py
    ├── test_spin.py
    └── test_extraction.py

2. KEY FILES

File: config/settings.py
---
from pydantic_settings import BaseSettings
from functools import lru_cache

class Settings(BaseSettings):
    # API Keys
    tinyfish_api_key: str = \"\"
    openai_api_key: str = \"\"
    discord_webhook_url: str = \"\"
    
    # App Settings
    database_url: str = \"sqlite:///./viralpost.db\"
    debug: bool = False
    check_interval_minutes: int = 30
    viral_threshold: float = 5.0
    super_viral_threshold: float = 10.0
    max_notifications_per_hour: int = 5
    
    class Config:
        env_file = \".env\"

@lru_cache()
def get_settings() -> Settings:
    return Settings()

File: requirements.txt
---
# Web & API
streamlit==1.30.0
streamlit-aggrid==0.3.4

# AI/ML
openai==1.12.0

# Web Scraping
agentql>=0.1.0

# Database
sqlalchemy==2.0.25

# HTTP
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

File: .env.example
---
# Required API Keys
TINYFISH_API_KEY=your_tinyfish_api_key_here
OPENAI_API_KEY=sk-your_openai_key_here
DISCORD_WEBHOOK_URL=https://discord.com/api/webhooks/...

# Optional Settings
DATABASE_URL=sqlite:///./viralpost.db
DEBUG=false
CHECK_INTERVAL_MINUTES=30
VIRAL_THRESHOLD=5.0
SUPER_VIRAL_THRESHOLD=10.0

File: database/seed.py
---
\"\"\"Seed database with sample data for demo\"\"\"

SAMPLE_COMPETITORS = [
    {\"handle\": \"@aiwithollie\", \"follower_count\": 125000, \"platform\": \"tiktok\"},
    {\"handle\": \"@ainews\", \"follower_count\": 89000, \"platform\": \"tiktok\"},
    {\"handle\": \"@aiforwork\", \"follower_count\": 45000, \"platform\": \"tiktok\"},
]

SAMPLE_POSTS = [
    {
        \"competitor_handle\": \"@aiwithollie\",
        \"text\": \"5 ChatGPT prompts that made me $10K this month 💰 #ai #chatgpt\",
        \"likes\": 45000,
        \"comments\": 1200,
        \"shares\": 3400,
        \"posted_at\": \"2026-03-28T08:00:00\"
    },
    # ... 14 more posts
]

def seed_database():
    \"\"\"Insert sample data into SQLite\"\"\"
    pass  # Implementation

File: setup.sh
---
#!/bin/bash
# Quick setup script

echo \"🚀 Setting up ViralPost Intelligence...\"

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Create .env from template
cp .env.example .env

echo \"✅ Setup complete!\"
echo \"\"
echo \"Next steps:\"
echo \"1. Edit .env with your API keys\"
echo \"2. Run: python database/seed.py\"
echo \"3. Run: streamlit run dashboard/app.py\"

3. INTEGRATION PATTERN

Show how all components work together:

async def main_workflow():
    \"\"\"Complete workflow example\"\"\"
    
    # 1. Initialize
    settings = get_settings()
    db = Database(settings.database_url)
    
    # 2. Extract
    extraction = ExtractionAgent(settings.tinyfish_api_key)
    posts = await extraction.fetch_recent_posts(\"@aiwithollie\")
    
    # 3. Detect
    detection = DetectionAgent()
    for post in posts:
        score = detection.calculate_score(post)
        if score.is_viral:
            
            # 4. Spin
            spin_agent = SpinAgent(settings.openai_api_key)
            spin = await spin_agent.spin_post(post, score)
            
            # 5. Notify
            if score.is_super_viral:
                notifier = NotificationAgent(settings.discord_webhook_url)
                await notifier.send_viral_alert(post, score, spin)
    
    # 6. Store
    db.save_posts(posts)
    db.save_spins([spin])

4. README TEMPLATE

# ViralPost Intelligence 🚀

AI-powered competitive intelligence for content creators.

## Quick Start

```bash
# 1. Clone and setup
git clone https://github.com/airacandylove/viralpost-intelligence.git
cd viralpost-intelligence
chmod +x setup.sh && ./setup.sh

# 2. Configure
vim .env  # Add your API keys

# 3. Run
streamlit run dashboard/app.py
```

## Features

- 🔍 Monitor competitor TikTok/Instagram accounts
- 🎯 AI-powered viral content detection
- ✨ GPT-4o content spinning in your brand voice
- 🚨 Real-time Discord notifications
- 📊 Interactive dashboard

## Architecture

See docs/ for full architecture documentation.

## License

MIT — Built for TinyFish Hackathon 2026

DELIVERABLE:

Complete project structure with:
- All __init__.py files
- Placeholder classes with TODO comments
- Type hints throughout
- Docstrings for all public methods
- Working imports between modules

EVALUATION:
- Project imports without errors
- Clear separation of concerns
- Easy to navigate structure
- Ready for component implementation
```

---

## Summary

| Task | Complexity | Time Estimate | Priority |
|------|-----------|---------------|----------|
| 3. Content Spin | Medium | 2h | High |
| 4. TinyFish Extract | High | 3h | High |
| 5. Notifications | Low | 1h | Medium |
| 6. Scaffold | Low | 1h | Low (can skip) |

**Recommended order:** 3 → 4 → 5 → 6 (if time)

**Copy these prompts into Claude one at a time** — each should produce working code you can integrate.

Good luck! 🚀
