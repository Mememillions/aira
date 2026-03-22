# Simple Prompts - Original Build
## Copy-Paste Ready (No Explanations)

---

## Prompt 1: Dashboard

```
Build a Streamlit dashboard called "ViralPost" with this layout:

Sidebar:
- Title: "ViralPost Monitor"
- Dropdown: Select competitor (@aiwithollie, @ainews, @aiforwork)
- Slider: Viral threshold (0-20, default 5)
- Stats: Total posts, Viral posts

Main (two columns):
Left column - Posts table:
- Competitor handle
- Post text (first 60 chars)
- Likes (formatted: 1.2K)
- Viral score
- Click row to select

Right column - Selected post:
- Show full text
- Show engagement stats
- "Generate Spin" button
- Show AI rewrite

Use SQLite with 2 tables: posts, spins.
Seed with 10 sample posts.
Single file: app.py
```

---

## Prompt 2: Viral Detection

```
Create viral_detection.py:

Function calculate_viral_score(likes, comments, shares, follower_count):
    # Simple formula
    engagement_rate = (likes / max(follower_count, 1)) * 100
    
    return {
        "score": engagement_rate,
        "is_viral": engagement_rate >= 5,
        "is_super_viral": engagement_rate >= 10
    }

Include 5 test cases in test_detection.py:
1. Super viral (score >10)
2. Viral (score 5-10)
3. Not viral (score <5)
4. Zero likes
5. Very high engagement
```

---

## Prompt 3: GPT Spin

```
Create spinner.py:

Class ContentSpinner:
    def __init__(self, api_key):
        self.client = OpenAI(api_key=api_key)
    
    def spin(self, text):
        prompt = f"Rewrite this in a conversational, friendly tone:\n\n{text}"
        
        response = self.client.chat.completions.create(
            model="gpt-4o",
            messages=[{"role": "user", "content": prompt}],
            max_tokens=200
        )
        
        return response.choices[0].message.content

Include example usage.
```

---

## Prompt 4: Discord

```
Create notify.py:

Function send_discord_alert(webhook_url, post, score):
    if score < 10:
        return
    
    message = f"""
🚨 VIRAL POST

@{post['competitor']} - Score: {score:.1f}

{post['text'][:100]}...

❤️ {post['likes']} | 💬 {post['comments']}
    """.strip()
    
    requests.post(webhook_url, json={"content": message})

Include test.
```

---

## Prompt 5: Database

```
Create database.py:

import sqlite3

def init_db():
    conn = sqlite3.connect("viralpost.db")
    
    conn.execute("""
        CREATE TABLE IF NOT EXISTS posts (
            id INTEGER PRIMARY KEY,
            competitor TEXT,
            text TEXT,
            likes INTEGER,
            comments INTEGER,
            shares INTEGER,
            viral_score REAL
        )
    """)
    
    conn.execute("""
        CREATE TABLE IF NOT EXISTS spins (
            id INTEGER PRIMARY KEY,
            post_id INTEGER,
            original TEXT,
            spun TEXT,
            created_at TIMESTAMP
        )
    """)
    
    conn.commit()
    return conn

def seed_data(conn):
    # Insert 10 sample posts
    posts = [
        ("@aiwithollie", "5 AI tools you need", 45000, 1200, 3400, 9.0),
        ("@ainews", "AI news today", 12000, 800, 1500, 6.0),
        # ... 8 more
    ]
    conn.executemany("INSERT INTO posts VALUES (NULL, ?, ?, ?, ?, ?, ?)", posts)
    conn.commit()
```

---

## Prompt 6: Main App

```
Create main.py that ties everything together:

1. Initialize database
2. Seed sample data
3. Run viral detection on all posts
4. Update viral scores
5. Start Streamlit dashboard

Single command to run everything.
```

---

## Prompt 7: Requirements

```
Create requirements.txt:

streamlit
openai
requests
sqlite3
pandas
```

---

That's it. 7 prompts. Copy, paste, build. 🚀
