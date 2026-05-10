"""
GitHub Project Analyzer using Gemini AI
Analyzes README files and ranks projects based on technical depth, innovation, and impact.
"""

import os
import json
import requests
from datetime import datetime
from typing import List, Dict, Optional
from dotenv import load_dotenv
import google.generativeai as genai

# Load environment variables
load_dotenv()

# Configure Gemini
genai.configure(api_key=os.getenv("GEMINI_API_KEY"))
model = genai.GenerativeModel('gemini-1.5-flash-latest')

# GitHub configuration
GH_OWNER = "Reberog"
GH_REPO = "AI-PROJECTS"
GH_BRANCH = "main"
GH_API_BASE = "https://api.github.com"


def fetch_folders() -> List[Dict[str, str]]:
    """Fetch all project folders from the GitHub repository."""
    url = f"{GH_API_BASE}/repos/{GH_OWNER}/{GH_REPO}/contents/"
    headers = {"Accept": "application/vnd.github.v3+json"}
    
    response = requests.get(url, headers=headers)
    response.raise_for_status()
    
    data = response.json()
    folders = [
        {"name": item["name"], "path": item["path"], "url": item["url"]}
        for item in data
        if item["type"] == "dir" and not item["name"].startswith(".")
    ]
    
    return folders


def fetch_readme_content(folder_path: str) -> Optional[str]:
    """Fetch README.md content from a project folder."""
    readme_variants = ["README.md", "readme.md", "Readme.md"]
    
    for readme_name in readme_variants:
        url = f"https://raw.githubusercontent.com/{GH_OWNER}/{GH_REPO}/{GH_BRANCH}/{folder_path}/{readme_name}"
        response = requests.get(url)
        
        if response.status_code == 200:
            return response.text
    
    return None


def fetch_last_commit_date(folder_path: str) -> Optional[str]:
    """Fetch the last commit date for a specific folder."""
    url = f"{GH_API_BASE}/repos/{GH_OWNER}/{GH_REPO}/commits"
    headers = {"Accept": "application/vnd.github.v3+json"}
    params = {"path": folder_path, "per_page": 1}
    
    try:
        response = requests.get(url, headers=headers, params=params)
        response.raise_for_status()
        
        commits = response.json()
        if commits:
            commit_date = commits[0]["commit"]["committer"]["date"]
            return commit_date
        
    except Exception as e:
        print(f"Error fetching commit date for {folder_path}: {e}")
    
    return None


def analyze_project_with_gemini(project_name: str, readme_content: str) -> Dict:
    """
    Use Gemini AI to analyze a project and provide scoring.
    
    Returns a dict with:
    - score: 0-100
    - summary: brief description
    - highlights: key features
    - tech_stack: identified technologies
    """
    
    prompt = f"""
You are an expert software engineer and technical evaluator. Analyze the following GitHub project README and provide a comprehensive assessment.

Project Name: {project_name}

README Content:
{readme_content}

Please evaluate this project based on:
1. **Technical Complexity & Innovation** (0-30 points): Advanced algorithms, novel approaches, sophisticated architecture
2. **Practical Impact & Use Case** (0-30 points): Real-world applicability, problem-solving value, business impact
3. **Implementation Quality** (0-20 points): Code structure, best practices, documentation quality
4. **Technology Stack** (0-20 points): Modern tools, relevant frameworks, cutting-edge tech

Provide your response in the following JSON format (respond ONLY with valid JSON, no additional text):

{{
  "score": <total score 0-100>,
  "summary": "<2-3 sentence project summary>",
  "highlights": [
    "<key feature 1>",
    "<key feature 2>",
    "<key feature 3>"
  ],
  "tech_stack": ["<tech1>", "<tech2>", "<tech3>"],
  "strengths": "<brief description of main strengths>",
  "use_case": "<primary use case or application>"
}}

Be objective and focus on technical merit, innovation, and real-world value.
"""
    
    try:
        response = model.generate_content(prompt)
        result_text = response.text.strip()
        
        # Clean up markdown code blocks if present
        if result_text.startswith("```json"):
            result_text = result_text[7:]
        if result_text.startswith("```"):
            result_text = result_text[3:]
        if result_text.endswith("```"):
            result_text = result_text[:-3]
        
        result = json.loads(result_text.strip())
        return result
        
    except Exception as e:
        print(f"Error analyzing project {project_name}: {e}")
        return {
            "score": 0,
            "summary": "Analysis failed",
            "highlights": [],
            "tech_stack": [],
            "strengths": "Unable to analyze",
            "use_case": "Unknown"
        }


def analyze_all_projects() -> List[Dict]:
    """Analyze all projects and return ranked results."""
    print("🔍 Fetching projects from GitHub...")
    folders = fetch_folders()
    print(f"Found {len(folders)} projects\n")
    
    analyzed_projects = []
    
    for idx, folder in enumerate(folders, 1):
        project_name = folder["name"]
        project_path = folder["path"]
        
        print(f"[{idx}/{len(folders)}] Analyzing: {project_name}")
        
        # Fetch README
        readme_content = fetch_readme_content(project_path)
        if not readme_content:
            print(f"  ⚠️  No README found, skipping...")
            continue
        
        print(f"  📄 README found ({len(readme_content)} chars)")
        
        # Fetch last commit date
        last_commit = fetch_last_commit_date(project_path)
        
        # Analyze with Gemini
        print(f"  🤖 Analyzing with Gemini AI...")
        analysis = analyze_project_with_gemini(project_name, readme_content)
        
        project_data = {
            "name": project_name,
            "path": project_path,
            "score": analysis["score"],
            "summary": analysis["summary"],
            "highlights": analysis["highlights"],
            "tech_stack": analysis["tech_stack"],
            "strengths": analysis["strengths"],
            "use_case": analysis["use_case"],
            "last_commit": last_commit,
            "analyzed_at": datetime.now().isoformat()
        }
        
        analyzed_projects.append(project_data)
        print(f"  ✅ Score: {analysis['score']}/100\n")
    
    # Sort by score (descending)
    analyzed_projects.sort(key=lambda x: x["score"], reverse=True)
    
    return analyzed_projects


def save_rankings(projects: List[Dict], output_file: str = "project_rankings.json"):
    """Save project rankings to a JSON file."""
    data = {
        "last_updated": datetime.now().isoformat(),
        "total_projects": len(projects),
        "projects": projects,
        "top_3": projects[:3]
    }
    
    output_path = os.path.join(os.path.dirname(__file__), output_file)
    with open(output_path, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2, ensure_ascii=False)
    
    print(f"💾 Rankings saved to {output_path}")
    return output_path


def main():
    """Main execution function."""
    print("=" * 60)
    print("🚀 GitHub Project Analyzer with Gemini AI")
    print("=" * 60)
    print()
    
    if not os.getenv("GEMINI_API_KEY"):
        print("❌ Error: GEMINI_API_KEY not found in environment variables")
        print("Please create a .env file with your Gemini API key")
        return
    
    try:
        # Analyze all projects
        projects = analyze_all_projects()
        
        # Save rankings
        save_rankings(projects)
        
        # Display top 3
        print("\n" + "=" * 60)
        print("🏆 TOP 3 PROJECTS")
        print("=" * 60)
        
        for idx, project in enumerate(projects[:3], 1):
            print(f"\n#{idx} - {project['name']}")
            print(f"   Score: {project['score']}/100")
            print(f"   Summary: {project['summary']}")
            print(f"   Tech Stack: {', '.join(project['tech_stack'][:5])}")
            if project.get('last_commit'):
                commit_date = datetime.fromisoformat(project['last_commit'].replace('Z', '+00:00'))
                print(f"   Last Updated: {commit_date.strftime('%B %d, %Y')}")
        
        print("\n" + "=" * 60)
        print("✨ Analysis complete!")
        
    except Exception as e:
        print(f"\n❌ Error during analysis: {e}")
        raise


if __name__ == "__main__":
    main()
