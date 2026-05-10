# GitHub Project Analyzer API

This API analyzes your GitHub projects using Google's Gemini AI and ranks them based on technical merit, innovation, and impact.

## Setup

1. **Install Python dependencies:**
   ```bash
   cd api
   pip install -r requirements.txt
   ```

2. **Configure environment variables:**
   ```bash
   cp .env.example .env
   # Edit .env and add your Gemini API key
   ```

   Get your Gemini API key from: https://makersuite.google.com/app/apikey

3. **Analyze projects:**
   ```bash
   python analyze_projects.py
   ```

   This will:
   - Fetch all projects from your GitHub repo
   - Download README files
   - Analyze each project with Gemini AI
   - Rank projects by score (0-100)
   - Save results to `project_rankings.json`
   - Display top 3 projects

4. **Start the API server (optional):**
   ```bash
   python server.py
   ```

   API will be available at: http://localhost:5000

## API Endpoints

### Get Top 3 Projects
```
GET /api/projects/top
```

Returns the top 3 ranked projects.

### Get All Projects
```
GET /api/projects/all
```

Returns all analyzed projects ranked by score.

### Health Check
```
GET /api/health
```

Check if the API is running and rankings are available.

## Ranking Criteria

Projects are scored (0-100) based on:
- **Technical Complexity & Innovation** (30 pts): Advanced algorithms, novel approaches
- **Practical Impact & Use Case** (30 pts): Real-world applicability, problem-solving value
- **Implementation Quality** (20 pts): Code structure, best practices, documentation
- **Technology Stack** (20 pts): Modern tools, relevant frameworks

## Output Format

The `project_rankings.json` file contains:
```json
{
  "last_updated": "2026-05-09T10:30:00",
  "total_projects": 10,
  "projects": [...],
  "top_3": [...]
}
```

Each project includes:
- `score`: Overall score (0-100)
- `summary`: Brief project description
- `highlights`: Key features
- `tech_stack`: Technologies used
- `strengths`: Main advantages
- `use_case`: Primary application
- `last_commit`: Last commit date
- `analyzed_at`: Analysis timestamp

## Re-running Analysis

To update rankings (e.g., after adding new projects):
```bash
python analyze_projects.py
```

The analysis takes 30-60 seconds per project depending on README size.
