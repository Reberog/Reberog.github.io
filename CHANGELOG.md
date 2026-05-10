# Portfolio Project Changelog

## [Latest] - May 9, 2026

### ✨ New Features

#### AI-Powered Project Ranking System
- **Gemini AI Integration**: Added Python backend to analyze GitHub projects using Google's Gemini AI
- **Intelligent Scoring**: Projects are automatically scored (0-100) based on:
  - Technical complexity and innovation
  - Real-world applicability
  - Code quality and documentation
  - Technology stack sophistication
- **Smart Summaries**: AI generates concise project summaries and highlights
- **Technology Detection**: Automatically extracts and lists tech stack used

#### Architecture-First Display
- **Removed README Tab**: Streamlined UI to focus on architecture documentation
- **Automatic Image Extraction**: Detects and displays architecture diagrams from markdown
- **Smart URL Resolution**: Handles both relative and absolute image URLs
- **Error Handling**: Gracefully hides broken images without showing error icons

#### Commit Date Tracking
- **Last Updated Display**: Shows when each project was last committed to
- **Human-Readable Format**: "3 weeks ago", "2 months ago" format

### 🔧 Technical Implementation

#### Backend Structure (`/api/`)
```
api/
├── analyze_projects.py      # Main Gemini AI analyzer
├── project_rankings.json    # Generated rankings cache
├── requirements.txt         # Python dependencies
├── .env.example            # Environment template
└── README.md              # Setup instructions
```

#### Key Components
1. **`GitHubProjects.tsx`**
   - Removed README display
   - Added image extraction function
   - Integrated ranked projects display
   - Enhanced UI with AI-generated insights

2. **`analyze_projects.py`**
   - Fetches all projects from GitHub
   - Analyzes README content with Gemini
   - Generates comprehensive project metadata
   - Caches results in JSON

### 📊 Data Structure

#### Ranked Project Schema
```json
{
  "name": "project-name",
  "path": "project-path",
  "score": 92,
  "summary": "AI-generated summary",
  "highlights": ["key feature 1", "key feature 2"],
  "tech_stack": ["Python", "React", "Docker"],
  "strengths": "What makes this project stand out",
  "use_case": "Real-world applications",
  "last_commit": "2026-04-15T10:30:00Z",
  "analyzed_at": "2026-05-09T08:00:00Z"
}
```

### 🎨 UI/UX Improvements

#### Project Cards
- Star rating badges for AI-scored projects
- Tech stack pills display
- "Last updated" timestamps
- Hover animations and transitions

#### Project Modal
- Cleaner, architecture-focused layout
- Large architecture diagram display
- AI-generated highlights section
- Direct GitHub link button

#### Visual Hierarchy
- Primary focus on architecture diagrams
- Prominent AI score display
- Color-coded badges for quick scanning
- Responsive grid layout

### 🚀 Usage

#### For End Users
1. Visit portfolio homepage
2. Scroll to "Projects" section
3. Click any project card to view architecture
4. Architecture diagram loads automatically
5. Markdown content renders below image

#### For Developers
1. Set up Python environment:
   ```bash
   cd api
   python -m venv venv
   source venv/bin/activate  # or `venv\Scripts\activate` on Windows
   pip install -r requirements.txt
   ```

2. Configure Gemini API:
   ```bash
   cp .env.example .env
   # Add your GEMINI_API_KEY to .env
   ```

3. Run analysis:
   ```bash
   python analyze_projects.py
   ```

4. Rankings are automatically cached and used by frontend

### 📝 Configuration

#### GitHub Repository
- Owner: `Reberog`
- Repo: `AI-PROJECTS`
- Branch: `main`

#### Environment Variables
```bash
GEMINI_API_KEY=your_api_key_here
```

### 🔄 Architecture Image Support

The component now automatically extracts images from architecture.md using:

```markdown
![Architecture Diagram](./diagram.png)
![System Flow](https://example.com/flow.png)
```

Supported formats:
- Relative paths: `./image.png`, `images/arch.png`
- Absolute URLs: `https://...`
- Data URIs: `data:image/png;base64,...`

### 🛠️ Scripts Added

1. **`setup_analyzer.sh`** - Quick setup script for Python environment
2. **`SETUP_GUIDE.md`** - Comprehensive setup instructions
3. **`TESTING_NOTES.md`** - Testing and troubleshooting guide
4. **`QUICK_REFERENCE.md`** - Quick command reference

### 📦 Dependencies Added

#### Python
- `google-generativeai` - Gemini AI SDK
- `python-dotenv` - Environment variable management
- `requests` - HTTP client for GitHub API

#### Frontend (already present)
- `@tanstack/react-query` - Data fetching
- `framer-motion` - Animations
- `react-markdown` - Markdown rendering

### 🐛 Bug Fixes
- Fixed image loading for relative paths
- Improved error handling for missing files
- Better fallback UI when rankings unavailable

### 🎯 Future Enhancements
- [ ] Add caching layer for GitHub API responses
- [ ] Implement webhook for automatic re-analysis
- [ ] Add filtering/sorting options
- [ ] Include code quality metrics
- [ ] Add project comparison feature
- [ ] Generate architecture diagrams automatically from code

### 📚 Documentation
- Added comprehensive setup guides
- Included example configurations
- Created troubleshooting documentation
- Added inline code comments

---

## How to Update Rankings

```bash
# From project root
cd api
source venv/bin/activate  # Activate virtual environment
python analyze_projects.py  # Re-analyze all projects
```

The frontend will automatically use the new rankings on next page load.

## Notes
- Rankings are cached to avoid API rate limits
- Re-run analysis when projects are updated
- Gemini API key required for analysis
- Frontend gracefully falls back if rankings unavailable
