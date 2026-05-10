# Arpan Anand - Portfolio

[![Deploy to GitHub Pages](https://github.com/Reberog/Reberog.github.io/actions/workflows/deploy.yml/badge.svg)](https://github.com/Reberog/Reberog.github.io/actions/workflows/deploy.yml)

> Personal portfolio showcasing AI/ML projects and skills

🌐 **Live Site:** [reberog.github.io](https://reberog.github.io/)

---

## Features

- 🤖 **Auto-updating Projects** - Fetches latest commit data from GitHub
- 🧠 **AI-Powered Summaries** - Uses Gemini AI to generate project descriptions
- 🔧 **Dynamic Skills** - Automatically aggregates tech stack from all projects
- 📊 **Real-time Stats** - Shows commit history and project activity
- 🎨 **Modern Design** - Responsive, beautiful UI with smooth animations
- 🚀 **Auto-Deploy** - GitHub Actions deploys on every push

---

## Tech Stack

- **Framework:** React + TanStack Start
- **Styling:** Tailwind CSS
- **Build:** Vite
- **Deployment:** GitHub Pages
- **AI:** Google Gemini API
- **Components:** Radix UI, Lucide Icons

---

## Local Development

```bash
# Install dependencies
npm install

# Run dev server
npm run dev

# Update project data
npm run update

# Build for production
npm run build
```

---

## Auto-Update System

The portfolio automatically updates project information:

1. **Detects new commits** in your GitHub repositories
2. **Fetches README** from each project
3. **Uses Gemini AI** to extract summary, highlights, and tech stack
4. **Merges new skills** with existing ones (no duplicates)
5. **Updates JSON files** in `public/api/`
6. **Frontend displays** latest data automatically

---

## Project Structure

```
├── src/
│   ├── routes/           # Pages
│   ├── components/       # React components
│   └── lib/             # Utilities
├── public/
│   └── api/             # Data files
│       ├── project_rankings.json
│       └── skills.json
├── update-projects.cjs   # Auto-update script
└── .github/
    └── workflows/
        └── deploy.yml    # CI/CD pipeline
```

---

## Deployment

Automatically deploys to GitHub Pages on push to main branch.

**Manual deployment:**
```bash
bash fix-and-deploy.sh
```

---

## Contact

- **Email:** arpananand1903@gmail.com
- **GitHub:** [@Reberog](https://github.com/Reberog)
- **LinkedIn:** [arpananand](https://linkedin.com/in/arpananand)

---

## License

MIT © Arpan Anand
