# Notification System Alternatives
## Discord + Other Options for Hackathon

---

## Option 1: Discord (Recommended)

### Why Discord
- ✅ Free
- ✅ Rich embeds (images, formatted text, buttons)
- ✅ Instant delivery
- ✅ Easy webhook setup
- ✅ Judges recognize it

### Setup Steps
1. Create Discord server (or use existing)
2. Server Settings → Integrations → Webhooks
3. New Webhook → Select channel → Copy URL
4. URL format: `https://discord.com/api/webhooks/ID/TOKEN`

### Code (Simple Version)
```python
import requests

def send_discord_alert(webhook_url, post, viral_score, spin):
    if viral_score < 10:  # Only super viral
        return
    
    message = f"""
🚨 **SUPER VIRAL POST**

@{post['competitor']} - Score: {viral_score:.1f}/100

{post['text'][:150]}...

❤️ {post['likes']:,} | 💬 {post['comments']:,} | 🔄 {post['shares']:,}

AI Spin: {spin['spun_text'][:100]}...
    """.strip()
    
    requests.post(webhook_url, json={"content": message})
```

---

## Option 2: Telegram (Easiest)

### Why Telegram
- ✅ Super simple bot API
- ✅ No rich embeds needed (text works fine)
- ✅ Instant push notifications to phones
- ✅ Free forever

### Setup Steps
1. Message @BotFather on Telegram
2. Type `/newbot`
3. Give it a name (e.g., "ViralPost Alerts")
4. Get your API token
5. Message the bot, then get chat ID via: `https://api.telegram.org/bot<TOKEN>/getUpdates`

### Code
```python
import requests

TELEGRAM_BOT_TOKEN = "your_bot_token"
TELEGRAM_CHAT_ID = "your_chat_id"

def send_telegram_alert(post, viral_score, spin):
    if viral_score < 10:
        return
    
    message = f"""
🚨 <b>SUPER VIRAL POST</b>

@{post['competitor']} - Score: {viral_score:.1f}/100

{post['text'][:150]}...

❤️ {post['likes']:,} | 💬 {post['comments']:,}

<b>AI Spin:</b>
{spin['spun_text'][:150]}...
    """.strip()
    
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/sendMessage"
    requests.post(url, json={
        "chat_id": TELEGRAM_CHAT_ID,
        "text": message,
        "parse_mode": "HTML"
    })
```

---

## Option 3: Email (Simplest)

### Why Email
- ✅ Everyone has it
- ✅ No external apps needed
- ✅ Good for summaries
- ❌ Not instant (can be delayed)

### Setup (Using Gmail SMTP)
```python
import smtplib
from email.mime.text import MIMEText

GMAIL_USER = "your_email@gmail.com"
GMAIL_APP_PASSWORD = "your_app_password"  # Generate in Google Account settings

def send_email_alert(post, viral_score, spin, to_email):
    if viral_score < 10:
        return
    
    subject = f"🚨 Viral Post Alert: {post['competitor']}"
    
    body = f"""
SUPER VIRAL POST DETECTED

Competitor: @{post['competitor']}
Viral Score: {viral_score:.1f}/100

ORIGINAL POST:
{post['text']}

Engagement:
- Likes: {post['likes']:,}
- Comments: {post['comments']:,}
- Shares: {post['shares']:,}

AI SPIN:
{spin['spun_text']}

---
ViralPost Intelligence
    """.strip()
    
    msg = MIMEText(body)
    msg['Subject'] = subject
    msg['From'] = GMAIL_USER
    msg['To'] = to_email
    
    with smtplib.SMTP_SSL('smtp.gmail.com', 465) as server:
        server.login(GMAIL_USER, GMAIL_APP_PASSWORD)
        server.send_message(msg)
```

---

## Option 4: Slack (Professional)

### Why Slack
- ✅ Professional look
- ✅ Rich formatting
- ✅ Good for teams
- ❌ Requires Slack workspace

### Setup
1. Create Slack app at api.slack.com/apps
2. Add Incoming Webhooks
3. Copy webhook URL

### Code
```python
import requests

def send_slack_alert(webhook_url, post, viral_score, spin):
    if viral_score < 10:
        return
    
    payload = {
        "text": "🚨 Super Viral Post Detected!",
        "blocks": [
            {
                "type": "header",
                "text": {
                    "type": "plain_text",
                    "text": "🔥 Super Viral Post"
                }
            },
            {
                "type": "section",
                "fields": [
                    {"type": "mrkdwn", "text": f"*Competitor:*\n@{post['competitor']}"},
                    {"type": "mrkdwn", "text": f"*Viral Score:*\n{viral_score:.1f}/100"},
                    {"type": "mrkdwn", "text": f"*Likes:*\n{post['likes']:,}"},
                    {"type": "mrkdwn", "text": f"*Shares:*\n{post['shares']:,}"}
                ]
            },
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": f"*Original:*\n{post['text'][:200]}..."
                }
            },
            {
                "type": "section",
                "text": {
                    "type": "mrkdwn",
                    "text": f"*AI Spin:*\n{spin['spun_text'][:200]}..."
                }
            }
        ]
    }
    
    requests.post(webhook_url, json=payload)
```

---

## Option 5: Console/Log (MVP Fallback)

### Why Console
- ✅ Works immediately
- ✅ No setup
- ✅ Can see during demo
- ❌ Not real notification

### Code
```python
from datetime import datetime

def console_alert(post, viral_score, spin):
    """Simple console notification for testing/MVP"""
    
    print("\n" + "="*60)
    print("🚨 SUPER VIRAL POST DETECTED")
    print("="*60)
    print(f"Time: {datetime.now().strftime('%H:%M:%S')}")
    print(f"Competitor: @{post['competitor']}")
    print(f"Viral Score: {viral_score:.1f}/100")
    print(f"Engagement: ❤️ {post['likes']:,} | 💬 {post['comments']:,} | 🔄 {post['shares']:,}")
    print("-"*60)
    print(f"Original: {post['text'][:100]}...")
    print("-"*60)
    print(f"AI Spin: {spin['spun_text'][:100]}...")
    print("="*60 + "\n")
```

---

## Option 6: Web Dashboard Only (No External)

Just show notifications in the Streamlit dashboard:

```python
import streamlit as st

# In your Streamlit app
def show_notification(post, viral_score, spin):
    if viral_score >= 10:
        st.toast(f"🚨 Super viral post from {post['competitor']}!", icon="🔥")
        
        # Or show in sidebar
        with st.sidebar:
            st.error(f"🔥 NEW: {post['competitor']}")
            st.caption(f"Score: {viral_score:.1f}")
            st.caption(post['text'][:50] + "...")
```

---

## Comparison Table

| Feature | Discord | Telegram | Email | Slack | Console | Dashboard |
|---------|---------|----------|-------|-------|---------|-----------|
| Setup Time | 2 min | 3 min | 5 min | 5 min | 0 min | 0 min |
| Rich Formatting | ✅ | ⚠️ | ❌ | ✅ | ❌ | ✅ |
| Mobile Push | ✅ | ✅ | ⚠️ | ✅ | ❌ | ❌ |
| Demo Impressive | ✅ | ✅ | ⚠️ | ✅ | ❌ | ⚠️ |
| No Extra Accounts | ❌ | ❌ | ✅ | ❌ | ✅ | ✅ |
| Real-time | ✅ | ✅ | ⚠️ | ✅ | ✅ | ✅ |

**Legend:** ✅ = Yes, ⚠️ = Partial, ❌ = No

---

## Recommendation for Hackathon

### Quick Decision Tree:

**Do you have Discord?**
→ YES → Use Discord (most impressive)

**Do you want mobile notifications?**
→ YES → Use Telegram

**Want zero setup?**
→ YES → Use Console + Dashboard

**Have Slack workspace?**
→ YES → Use Slack

**Want professional look?**
→ YES → Use Email or Slack

---

## My Suggestion

**For Demo Day:**
1. **Primary:** Discord (looks impressive, instant)
2. **Backup:** Telegram (if Discord fails)
3. **MVP:** Console (always works)

**Code Strategy:**
```python
class NotificationManager:
    def __init__(self, discord_url=None, telegram_token=None, chat_id=None):
        self.discord_url = discord_url
        self.telegram_token = telegram_token
        self.chat_id = chat_id
    
    async def send(self, post, viral_score, spin):
        # Try Discord first
        if self.discord_url and viral_score >= 10:
            try:
                await self._send_discord(post, viral_score, spin)
                return
            except:
                pass  # Fallback to next
        
        # Try Telegram
        if self.telegram_token and viral_score >= 10:
            try:
                await self._send_telegram(post, viral_score, spin)
                return
            except:
                pass
        
        # Always log to console
        console_alert(post, viral_score, spin)
```

This way something always works! 🚀

---

*Notification Alternatives | TinyFish Hackathon 2026*
