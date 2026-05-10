# Arpan Anand - Portfolio

[![Deploy to GitHub Pages](https://github.com/Reberog/Reberog.github.io/actions/workflows/deploy.yml/badge.svg)](https://github.com/Reberog/Reberog.github.io/actions/workflows/deploy.yml)
[![Node.js CI](https://img.shields.io/badge/node-22.x-brightgreen.svg)](https://nodejs.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> Modern, AI-powered portfolio showcasing data science and machine learning projects

🌐 **Live Site:** [reberog.github.io](https://reberog.github.io/)

---

## 📌 Overview

A self-updating portfolio that automatically fetches GitHub projects, generates AI-powered summaries using Google Gemini, and deploys via GitHub Actions. Built with React, TanStack, and Tailwind CSS.

---

## ✨ Features

- 🤖 **Auto-updating Projects** - Continuously syncs with GitHub repositories
- 🧠 **AI-Powered Summaries** - Gemini API generates intelligent project descriptions
- 🔧 **Dynamic Skills** - Automatically categorizes and aggregates tech stack
- 📊 **Real-time Stats** - Displays commit history and project activity
- 🎨 **Modern Design** - Responsive, accessible UI with smooth animations
- 🚀 **CI/CD Pipeline** - Automated deployment on every push
- 📱 **Mobile-First** - Optimized for all screen sizes
- ⚡ **Fast Loading** - Vite-powered builds with code splitting

---

## 🛠️ Tech Stack

### Frontend
- **Framework:** React 18 + TanStack Start
- **Styling:** Tailwind CSS 4 + Radix UI
- **Build Tool:** Vite
- **Routing:** TanStack Router
- **Animations:** Framer Motion
- **Icons:** Lucide React

### Backend & Tools
- **AI:** Google Gemini API
- **Data Source:** GitHub REST API
- **Deployment:** GitHub Pages
- **CI/CD:** GitHub Actions
- **Package Manager:** npm

---

## 🚀 Quick Start

### Prerequisites
- Node.js 22+
- npm or yarn
- (Optional) Google Gemini API key for project updates

### Installation

```bash
# Clone the repository
git clone https://github.com/Reberog/Reberog.github.io.git
cd Reberog.github.io

# Install dependencies
npm install

# Create environment file
cp .env.example .env
# Add your GEMINI_API_KEY to .env

# Run development server
npm run dev
```

The app will be available at `http://localhost:5173`

---

## 📝 Available Scripts

```bash
# Development
npm run dev              # Start dev server with hot reload
npm run dev:fresh        # Update projects + start dev server

# Building
npm run build            # Production build
npm run build:dev        # Development build
npm run preview          # Preview production build

# Maintenance
npm run update           # Update project data from GitHub
npm run lint             # Run ESLint
npm run format           # Format code with Prettier
```

---

## 🔄 Auto-Update System

The portfolio features an intelligent update system that keeps your projects current:

### How It Works

1. **Fetches Commits** - Queries GitHub API for latest commits in `AI-PROJECTS` repo
2. **Detects Changes** - Compares commit hashes to identify new work
3. **Reads READMEs** - Extracts project documentation
4. **AI Analysis** - Gemini API generates:
   - Project summary
   - Key highlights
   - Tech stack analysis
5. **Skill Aggregation** - Categorizes technologies across all projects
6. **Updates Data** - Writes to `public/api/*.json`
7. **Frontend Display** - React components render the latest data

### Running Updates

```bash
# Manual update
npm run update

# Or run with dev server
npm run dev:fresh
```

### Configuring the Update Script

Edit `update-projects.cjs`:
```javascript
const GH_OWNER = 'YourGitHubUsername';
const GH_REPO = 'YourProjectsRepo';
```

---

## 📁 Project Structure

```
portfolio/
├── .github/
│   └── workflows/
│       └── deploy.yml           # GitHub Actions deployment
├── public/
│   ├── api/
│   │   ├── project_rankings.json # Project data + AI summaries
│   │   └── skills.json          # Categorized skills
│   ├── .nojekyll                # Disable GitHub Jekyll
│   └── CNAME                    # Custom domain (optional)
├── src/
│   ├── assets/                  # Images, static files
│   ├── components/
│   │   ├── GitHubProjects.tsx   # Project display
│   │   ├── Skills.tsx           # Skills grid
│   │   └── ui/                  # Reusable UI components (Radix)
│   ├── hooks/                   # Custom React hooks
│   ├── lib/                     # Utils, helpers
│   └── routes/
│       ├── __root.tsx           # Root layout
│       └── index.tsx            # Homepage
├── api/                         # Optional Python API server
├── update-projects.cjs          # Project update script
├── vite.config.ts               # Vite configuration
├── tailwind.config.js           # Tailwind configuration
├── package.json                 # Dependencies
└── README.md                    # This file
```

---

## 🌍 Deployment

### Automatic Deployment

Pushes to `main` branch automatically trigger deployment via GitHub Actions:

1. **Checkout** code
2. **Install** dependencies (Node 22)
3. **Build** static site (`npm run build`)
4. **Prepare** dist folder:
   - Copy API data
   - Create `.nojekyll` file
   - Verify build integrity
5. **Upload** artifact
6. **Deploy** to GitHub Pages

### Manual Deployment

```bash
# Build locally
npm run build

# Verify build
npm run preview

# Push to trigger deployment
git push origin main
```

### Environment Variables

For GitHub Actions, add secrets in your repo settings:

- `GEMINI_API_KEY` - (Optional) For AI-powered updates

---

## 🎨 Customization

### Update Personal Info

Edit `src/routes/index.tsx`:
```tsx
// Update profile information
const name = "Your Name";
const title = "Your Title";
const bio = "Your bio...";
```

### Add Projects

Projects are auto-fetched from your GitHub repo. To manually add:

Edit `public/api/project_rankings.json`:
```json
{
  "projects": [
    {
      "name": "Your Project",
      "description": "Project description",
      "tech_stack": ["React", "TypeScript"],
      "highlights": ["Feature 1", "Feature 2"]
    }
  ]
}
```

### Modify Skills

Edit `update-projects.cjs` to customize skill categories:
```javascript
const SKILL_CATEGORIES = {
  'Languages': ['Python', 'JavaScript'],
  'AI/ML': ['TensorFlow', 'PyTorch'],
  // Add your categories...
};
```

---

## 📊 Architecture

For detailed architecture documentation, see:
- [Functional Architecture](./ARCHITECTURE.md) - User flows and data interactions
- [Technical Architecture](./TECHNICAL_ARCHITECTURE.md) - System design and deployment

---

## 🐛 Troubleshooting

### Build Fails

```bash
# Clear cache and reinstall
rm -rf node_modules package-lock.json
npm install
npm run build
```

### GitHub Pages Shows README Instead of Site

Ensure `.nojekyll` exists in the `dist/` folder (handled automatically by workflow).

### Projects Not Updating

```bash
# Check API key
echo $GEMINI_API_KEY

# Run update manually with verbose output
node update-projects.cjs
```

---

## 🤝 Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 📧 Contact

**Arpan Anand**

- 📧 Email: [arpananand1903@gmail.com](mailto:arpananand1903@gmail.com)
- 💼 LinkedIn: [@arpananand](https://linkedin.com/in/arpananand)
- 🐙 GitHub: [@Reberog](https://github.com/Reberog)
- 🌐 Portfolio: [reberog.github.io](https://reberog.github.io/)

---

<div align="center">
  <p>Built with ❤️ by Arpan Anand</p>
  <p>⭐ Star this repo if you found it helpful!</p>
</div>

## License

MIT © Arpan Anand
