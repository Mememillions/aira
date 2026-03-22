# Complete AI Prompts for Task 1 & 2
## Ready-to-Use for AI Coding Assistants

---

## TASK 1: Streamlit Dashboard (Complete Prompt)

```
Act as a senior Python developer and Streamlit expert. Build a complete "ViralPost Intelligence Dashboard" for a hackathon demo.

PROJECT CONTEXT:
- This is a competitive intelligence tool for AI influencers
- It monitors competitor TikTok accounts and identifies viral posts
- Users can view viral content and approve AI-generated spins

FUNCTIONAL REQUIREMENTS:

1. MAIN LAYOUT
   - Page title: "⚡ ViralPost Intelligence"
   - Wide layout (full screen)
   - Two-column layout (left: posts, right: spins)
   - Sidebar with competitor selector and filters

2. SIDEBAR COMPONENTS
   - Logo/header: "ViralPost AI" with emoji
   - Dropdown: Select competitor (options: @aiwithollie, @ainews, @aiforwork, @ai.baddie, @viralaicommunity)
   - Slider: Viral score threshold (0-20, default 5)
   - Button: "Refresh Data" (reruns app)
   - Stats cards: Total posts monitored, Viral posts today, Pending spins

3. LEFT COLUMN - VIRAL POSTS FEED
   - Section header: "🔥 Viral Posts" with count badge
   - Table showing:
     * Competitor handle (with @)
     * Post preview (first 80 chars)
     * Likes (formatted: 1.2K, 45K, etc.)
     * Viral Score (color-coded: <5 gray, 5-10 orange, >10 red)
     * Posted time ("2h ago", "1d ago")
     * "Spin This" button for each row
   - Sortable by viral score (default: highest first)
   - Clicking "Spin This" stores post_id in session state

4. RIGHT COLUMN - SPIN WORKFLOW
   - Section header: "✨ AI Content Spin"
   - If no post selected: Show "Select a post to spin" with arrow pointing left
   - If post selected:
     * Card showing original post (full text)
     * "Generate AI Spin" button
     * Loading spinner during generation
     * Result card showing spun text
     * "Hook Type" badge (curiosity, fear, aspiration, humor, contrarian)
     * Confidence score (0-100%)
     * Two buttons: "✅ Approve" and "❌ Reject"
   - Below: "Recent Spins" mini-table with status (pending/approved/rejected)

5. DATABASE SCHEMA (SQLite)
   Create these tables on first run:
   
   competitors:
   - id (INTEGER PRIMARY KEY)
   - handle (TEXT UNIQUE)
   - follower_count (INTEGER)
   - platform (TEXT default 'tiktok')
   
   posts:
   - id (INTEGER PRIMARY KEY)
   - competitor_id (INTEGER)
   - text (TEXT)
   - likes (INTEGER)
   - comments (INTEGER)
   - shares (INTEGER)
   - viral_score (REAL)
   - posted_at (TIMESTAMP)
   - is_viral (BOOLEAN)
   
   spins:
   - id (INTEGER PRIMARY KEY)
   - post_id (INTEGER)
   - original_text (TEXT)
   - spun_text (TEXT)
   - hook_type (TEXT)
   - confidence_score (REAL)
   - status (TEXT default 'pending')
   - created_at (TIMESTAMP)

6. SAMPLE DATA (Seed on first run)
   Insert 15 realistic sample posts:
   - Mix of competitors
   - Likes ranging from 500 to 50,000
   - Viral scores from 2.0 to 15.0
   - Various hook types
   
   Example posts:
   - "5 ChatGPT prompts that made me $10K this month"
   - "The AI tool everyone's sleeping on in 2026"
   - "I asked 100 creators how they use AI. Here's what surprised me..."

7. STYLING REQUIREMENTS
   - Use st.metric() for sidebar stats
   - Color-code viral scores (CSS or conditional formatting)
   - Use st.info(), st.success(), st.warning() appropriately
   - Add emojis for visual appeal
   - Make "SUPER VIRAL" posts (>10 score) stand out with border/highlight

8. STATE MANAGEMENT
   - Use st.session_state to track:
     * selected_post_id
     * generated_spin (cache to avoid re-generation)
     * refresh_counter

TECHNICAL REQUIREMENTS:
- Single file: app.py
- Requirements: streamlit, pandas, sqlite3, datetime
- No external API calls for MVP (use sample data)
- Responsive layout (works on laptop screen)
- Error handling for database operations

DELIVERABLE:
Complete, runnable app.py file that I can save and run with "streamlit run app.py"

BONUS POINTS:
- Add a "Live" indicator with pulsing animation (CSS hack)
- Add export button for approved spins
- Add simple charts (viral score distribution)
```

---

## TASK 2: Viral Detection Algorithm (Complete Prompt)

```
Act as an AI/ML engineer building a viral content detection system for TikTok/Instagram posts.

PROJECT CONTEXT:
- Input: Post engagement data (likes, comments, shares, views, follower count)
- Output: Viral score (0-100), boolean flags, reasoning
- Goal: Identify which posts have high viral potential

CORE ALGORITHM REQUIREMENTS:

1. VIRAL SCORE CALCULATION
   
   Calculate composite score based on:
   
   a) ENGAGEMENT RATE (40% weight)
      - Normalize likes by follower count
      - Formula: (likes / follower_count) * 100
      - Cap at 40 points max
   
   b) COMMENT RATIO (25% weight)
      - Comments per like (conversation quality)
      - Formula: (comments / likes) * 100
      - Higher ratio = more engaging content
   
   c) SHARE RATIO (25% weight)
      - Shares per like (virality indicator)
      - Formula: (shares / likes) * 100
      - Shares are weighted heavily for virality
   
   d) SAVE RATIO (10% weight, optional)
      - Saves per like (value indicator)
      - Formula: (saves / likes) * 100
      - Only if saves data available
   
   FINAL SCORE = sum of all weighted components, capped at 100

2. THRESHOLDS
   - is_viral: score >= 5.0
   - is_super_viral: score >= 10.0

3. REASONING GENERATION
   Generate human-readable explanation:
   - "High comment ratio indicates strong conversation"
   - "Share velocity suggests viral potential"
   - "Low engagement relative to follower count"
   - etc.

4. DATA MODELS (Pydantic)

   class Competitor:
       id: int
       handle: str (e.g., "@aiwithollie")
       platform: str (default "tiktok")
       follower_count: int
   
   class Post:
       id: int
       competitor_id: int
       text: str
       likes: int
       comments: int
       shares: int
       views: Optional[int]
       saves: Optional[int]
       posted_at: datetime
       captured_at: datetime
   
   class ViralScore:
       score: float (0-100)
       is_viral: bool
       is_super_viral: bool
       breakdown: dict with component scores
       reasoning: str
       hook_type: str (detected from text analysis)

5. HOOK TYPE DETECTION (Simple heuristic)
   Analyze post text to categorize:
   - "curiosity": contains "secret", "truth", "revealed", "what they don't tell"
   - "fear": contains "stop", "avoid", "mistake", "wrong", "don't"
   - "aspiration": contains "success", "rich", "millionaire", "grow", "10x"
   - "humor": contains funny tone, jokes, relatable complaints
   - "authority": contains "study", "research", "expert", "data shows"
   - "contrarian": contains "unpopular opinion", "controversial", "hot take"
   Default to "general" if no match

6. VELOCITY CALCULATION (Advanced, optional)
   If historical data available:
   - Track engagement growth over time
   - Fast growth in first hour = higher velocity score
   - Add velocity bonus (up to 10 points)

7. EDGE CASE HANDLING
   - New accounts (<1000 followers): Use different thresholds
   - Zero likes: Return score 0, avoid division by zero
   - Missing data: Use sensible defaults
   - Very old posts (>7 days): Reduce score (stale content)

8. TESTING REQUIREMENTS
   Include 10 test cases:
   - Super viral post (score >10)
   - Borderline viral (score ~5)
   - Not viral (score <5)
   - New account post
   - Zero engagement post
   - High comments but low likes
   - High shares (viral potential)
   - Old post (should be discounted)
   - Missing data fields
   - Extremely high engagement

CODE STRUCTURE:

1. viral_detection.py - Main module
   - calculate_viral_score(post, competitor) -> ViralScore
   - detect_hook_type(text) -> str
   - format_engagement(number) -> str (1.2K, 45M, etc.)

2. test_viral_detection.py - Unit tests
   - pytest fixtures for test data
   - Test all edge cases
   - Assert score ranges and threshold logic

3. demo.py - Interactive demo script
   - Load sample posts
   - Run detection on each
   - Print formatted results table

IMPLEMENTATION NOTES:
- Use type hints throughout
- Add docstrings to all functions
- Log warnings for edge cases
- Keep algorithm deterministic (same input = same output)
- Optimize for speed (will run on many posts)

DELIVERABLES:
1. Complete viral_detection.py with all functions
2. Complete test_viral_detection.py with 10+ test cases
3. demo.py script showing example usage
4. requirements.txt (pytest, pydantic)

EVALUATION CRITERIA:
- Accuracy: Correctly identifies viral vs non-viral
- Speed: O(1) per post, no external API calls
- Robustness: Handles all edge cases gracefully
- Clarity: Code is readable and well-documented

SAMPLE INPUT/OUTPUT:

Input Post:
- likes: 45000
- comments: 1200
- shares: 3400
- follower_count: 500000
- text: "5 ChatGPT prompts that made me $10K this month"

Expected Output:
- score: ~12.5
- is_viral: True
- is_super_viral: True
- hook_type: "aspiration"
- reasoning: "High engagement rate (9%) with strong share ratio suggests viral potential. Money-related content performing well."
```

---

## How to Use These Prompts

1. **Copy the full prompt** (everything between the triple backticks)
2. **Paste into ChatGPT, Claude, or any AI coding assistant**
3. **Review the generated code**
4. **Test immediately** - the prompts are designed to produce runnable code
5. **Iterate** - if something's missing, ask follow-up questions

## Expected Output Quality

**Task 1 (Dashboard):**
- ✅ Single file: app.py
- ✅ Runs with: streamlit run app.py
- ✅ Shows real-looking data
- ✅ Interactive buttons work
- ✅ Layout matches spec

**Task 2 (Algorithm):**
- ✅ Passes all 10 test cases
- ✅ Accurate viral scoring
- ✅ No division by zero errors
- ✅ Clear reasoning output

## Testing Checklist

**Before accepting generated code:**

**Dashboard:**
- [ ] streamlit run app.py works without errors
- [ ] Sidebar shows 5 competitor options
- [ ] Viral posts table displays
- [ ] Viral scores are color-coded
- [ ] "Spin This" button stores selection
- [ ] Right column updates when post selected

**Algorithm:**
- [ ] pytest passes all tests
- [ ] Super viral post (likes > 10% of followers) scores >10
- [ ] Borderline post scores around 5
- [ ] Low engagement post scores <5
- [ ] Reasoning text makes sense

---

*AI Prompts for Hackathon Build | TinyFish 2026*
