# Functional Architecture

This document describes the **functional architecture** of the portfolio application, focusing on user interactions, data flows, and system behavior from a high-level perspective.

---

## Overview

The portfolio is a self-updating, AI-powered web application that showcases projects and skills. It consists of three main functional areas:

1. **User-Facing Portfolio** - Public website displaying projects and information
2. **Auto-Update System** - Background process that syncs with GitHub and generates AI summaries
3. **Deployment Pipeline** - Automated CI/CD that builds and deploys the site

---

## System Flow Diagram

```mermaid
flowchart TD
    %% User Interaction Flow
    A[User Visits Portfolio] --> B{Load Website}
    B --> C[Fetch Projects Data]
    B --> D[Fetch Skills Data]
    C --> E[Display Projects with AI Summaries]
    D --> F[Display Categorized Skills]
    E --> G[User Browses Projects]
    F --> G
    
    %% Update System Flow
    H[Developer Commits to GitHub] --> I[Update Script Triggered]
    I --> J{Fetch GitHub Data}
    J --> K[Get Latest Commits]
    K --> L{New Commits?}
    L -->|Yes| M[Fetch README Files]
    L -->|No| N[Skip Update]
    M --> O[Send to Gemini AI]
    O --> P[Generate Summaries]
    P --> Q[Extract Tech Stack]
    Q --> R[Categorize Skills]
    R --> S[Update JSON Files]
    S --> T[Commit & Push Changes]
    
    %% Deployment Flow
    T --> U[GitHub Actions Triggered]
    H --> U
    U --> V[Install Dependencies]
    V --> W[Run Build Process]
    W --> X[Generate Static Site]
    X --> Y[Create .nojekyll]
    Y --> Z[Deploy to GitHub Pages]
    Z --> AA[Live Site Updated]
    AA --> A
    
    %% Styling
    classDef userAction fill:#e1f5ff,stroke:#01579b,stroke-width:2px
    classDef dataProcess fill:#fff3e0,stroke:#e65100,stroke-width:2px
    classDef aiProcess fill:#f3e5f5,stroke:#4a148c,stroke-width:2px
    classDef deployment fill:#e8f5e9,stroke:#1b5e20,stroke-width:2px
    
    class A,G,H userAction
    class C,D,J,K,M,Q,R,S,T dataProcess
    class O,P aiProcess
    class U,V,W,X,Y,Z,AA deployment
```

---

## Functional Components

### 1. User-Facing Portfolio

**Purpose:** Present professional profile, projects, and skills to visitors

**Key Features:**
- Responsive hero section with personal information
- Dynamic project cards with AI-generated summaries
- Categorized skills display
- Experience timeline
- Certificates showcase
- Contact information and social links

**User Journey:**
```mermaid
flowchart LR
    A[Land on Homepage] --> B[Read Hero Section]
    B --> C[Scroll to About]
    C --> D[View Experience]
    D --> E[Browse Projects]
    E --> F[Check Skills]
    F --> G[See Certificates]
    G --> H[View Contact Info]
    
    E --> I[Click Project Link]
    I --> J[Visit GitHub Repo]
    
    H --> K[Click Email/LinkedIn]
    K --> L[Initiate Contact]
    
    classDef browse fill:#e3f2fd,stroke:#1565c0
    classDef action fill:#fce4ec,stroke:#c2185b
    
    class A,B,C,D,E,F,G,H browse
    class I,J,K,L action
```

**Data Sources:**
- `public/api/project_rankings.json` - Project data with AI summaries
- `public/api/skills.json` - Categorized skills
- `src/routes/index.tsx` - Static content (experience, education, certificates)

---

### 2. Auto-Update System

**Purpose:** Keep project information current without manual intervention

**Workflow:**

```mermaid
sequenceDiagram
    participant Dev as Developer
    participant GH as GitHub API
    participant Script as Update Script
    participant Gemini as Gemini AI
    participant FS as File System
    
    Dev->>Script: Run `npm run update`
    Script->>GH: Fetch commits from AI-PROJECTS repo
    GH-->>Script: Return commit data
    
    Script->>Script: Compare with stored hashes
    
    alt New commits found
        loop For each project
            Script->>GH: Fetch README.md
            GH-->>Script: Return README content
            Script->>Gemini: Send README for analysis
            Gemini-->>Script: Return summary, highlights, tech_stack
            Script->>Script: Categorize skills
        end
        Script->>FS: Update project_rankings.json
        Script->>FS: Update skills.json
        Script-->>Dev: ✅ Projects updated!
    else No new commits
        Script-->>Dev: ℹ️ No updates needed
    end
```

**AI Processing:**
- **Input:** Project README.md content
- **Processing:** Gemini 1.5 Flash analyzes content
- **Output:**
  - `summary`: Brief project description (2-3 sentences)
  - `highlights`: Key features/achievements (array)
  - `tech_stack`: Technologies used (array)

**Skill Categorization:**
The system automatically categorizes technologies into:
- Languages (Python, JavaScript, TypeScript, etc.)
- AI/ML (TensorFlow, PyTorch, LangChain, etc.)
- Web Frameworks (React, Next.js, FastAPI, etc.)
- Databases (MongoDB, PostgreSQL, etc.)
- Cloud & DevOps (AWS, Docker, Kubernetes, etc.)
- Data Tools (Pandas, NumPy, etc.)
- Other (uncategorized)

---

### 3. Deployment Pipeline

**Purpose:** Automatically build and deploy updates

**Trigger Conditions:**
- Push to `main` branch
- Manual workflow dispatch

**Deployment Flow:**

```mermaid
flowchart TD
    A[Code Push to Main] --> B[GitHub Actions Triggered]
    B --> C{Build Job}
    
    C --> D[Checkout Code]
    D --> E[Setup Node.js 22]
    E --> F[Install Dependencies]
    F --> G[Run Vite Build]
    
    G --> H{Build Successful?}
    H -->|No| I[❌ Fail Pipeline]
    H -->|Yes| J[Prepare dist/ Folder]
    
    J --> K[Copy API Data to dist/]
    K --> L[Copy Public Assets]
    L --> M[Create .nojekyll]
    M --> N[Verify index.html Exists]
    N --> O[Verify Asset Paths]
    
    O --> P{Verification Pass?}
    P -->|No| Q[❌ Fail Deployment]
    P -->|Yes| R[Upload Pages Artifact]
    
    R --> S{Deploy Job}
    S --> T[Deploy to GitHub Pages]
    T --> U[Update DNS]
    U --> V[✅ Site Live!]
    
    V --> W[Available at reberog.github.io]
    
    classDef trigger fill:#fff3e0,stroke:#e65100
    classDef build fill:#e3f2fd,stroke:#1565c0
    classDef verify fill:#f3e5f5,stroke:#6a1b9a
    classDef deploy fill:#e8f5e9,stroke:#2e7d32
    classDef error fill:#ffebee,stroke:#c62828
    
    class A,B trigger
    class D,E,F,G,J,K,L build
    class M,N,O,P verify
    class R,S,T,U,V,W deploy
    class I,Q error
```

**Key Steps:**
1. **Checkout & Setup:** Get code, configure Node.js 22
2. **Build:** Run `npm run build` to create static site
3. **Prepare:** 
   - Copy API data from `public/api/` to `dist/api/`
   - Copy other public assets (CNAME, etc.)
   - Create `.nojekyll` to bypass Jekyll processing
4. **Verify:**
   - Check `dist/index.html` exists
   - Verify asset paths are correct (`/assets/`)
5. **Deploy:** Upload artifact and deploy to GitHub Pages

---

## Data Flow

### Project Data Flow

```mermaid
flowchart LR
    A[GitHub Repo:<br/>AI-PROJECTS] --> B[Update Script]
    B --> C[Gemini AI API]
    C --> D[Generated Data]
    D --> E[public/api/<br/>project_rankings.json]
    E --> F[Vite Build]
    F --> G[dist/api/<br/>project_rankings.json]
    G --> H[GitHub Pages]
    H --> I[User Browser]
    I --> J[React Component]
    J --> K[Rendered Project Cards]
    
    classDef source fill:#e1f5ff,stroke:#01579b
    classDef process fill:#fff3e0,stroke:#e65100
    classDef storage fill:#f3e5f5,stroke:#6a1b9a
    classDef output fill:#e8f5e9,stroke:#2e7d32
    
    class A source
    class B,C,D,F process
    class E,G storage
    class H,I,J,K output
```

### Skills Data Flow

```mermaid
flowchart LR
    A[All Project<br/>Tech Stacks] --> B[Skill Aggregator]
    B --> C[Categorization Logic]
    C --> D[public/api/<br/>skills.json]
    D --> E[Vite Build]
    E --> F[dist/api/<br/>skills.json]
    F --> G[GitHub Pages]
    G --> H[User Browser]
    H --> I[Skills Component]
    I --> J[Categorized<br/>Skill Grid]
    
    classDef source fill:#e1f5ff,stroke:#01579b
    classDef process fill:#fff3e0,stroke:#e65100
    classDef storage fill:#f3e5f5,stroke:#6a1b9a
    classDef output fill:#e8f5e9,stroke:#2e7d32
    
    class A source
    class B,C,E process
    class D,F storage
    class G,H,I,J output
```

---

## Error Handling

### Update Script Errors

```mermaid
flowchart TD
    A[Update Process] --> B{API Rate Limit?}
    B -->|Yes| C[Wait & Retry]
    B -->|No| D{Gemini API Error?}
    
    D -->|Yes| E[Use Cached Summary]
    D -->|No| F{README Not Found?}
    
    F -->|Yes| G[Skip Project]
    F -->|No| H{Invalid JSON?}
    
    H -->|Yes| I[Log Error, Continue]
    H -->|No| J[✅ Success]
    
    C --> A
    E --> K[Mark as Partial Update]
    G --> K
    I --> K
    K --> L[Continue with Other Projects]
    
    classDef error fill:#ffebee,stroke:#c62828
    classDef success fill:#e8f5e9,stroke:#2e7d32
    classDef warning fill:#fff3e0,stroke:#e65100
    
    class B,D,F,H error
    class J success
    class C,E,G,I,K,L warning
```

### Deployment Errors

```mermaid
flowchart TD
    A[Deployment Process] --> B{Build Failed?}
    B -->|Yes| C[Check Node Version]
    C --> D[Check Dependencies]
    D --> E[Review Build Logs]
    
    B -->|No| F{index.html Missing?}
    F -->|Yes| G[Check Vite Config]
    
    F -->|No| H{404 on Assets?}
    H -->|Yes| I[Check Base Path]
    I --> J[Verify .nojekyll Exists]
    
    H -->|No| K{Showing README?}
    K -->|Yes| L[Ensure .nojekyll in dist/]
    L --> M[Remove .nojekyll from root]
    
    K -->|No| N[✅ Deployment OK]
    
    classDef error fill:#ffebee,stroke:#c62828
    classDef success fill:#e8f5e9,stroke:#2e7d32
    classDef fix fill:#e3f2fd,stroke:#1565c0
    
    class B,F,H,K error
    class N success
    class C,D,E,G,I,J,L,M fix
```

---

## Key Functional Requirements

### Performance
- Initial page load < 3 seconds
- Smooth animations (60 FPS)
- Lazy load images
- Code splitting for routes

### Accessibility
- WCAG 2.1 Level AA compliance
- Keyboard navigation support
- Screen reader optimized
- High contrast support

### Reliability
- Graceful degradation if API fails
- Cached data fallback
- Error boundary protection
- Build verification before deploy

### Maintainability
- Automated updates (no manual JSON editing)
- Self-documenting code
- Consistent component patterns
- Comprehensive error logging

---

## Future Enhancements

### Planned Features
1. **Blog Integration** - Markdown-based blog posts
2. **Analytics Dashboard** - Visitor stats and engagement
3. **Dark/Light Theme Toggle** - User preference system
4. **Search Functionality** - Search projects and skills
5. **Project Filtering** - Filter by technology or category
6. **Performance Metrics** - Lighthouse scores in README

### Possible Integrations
- **LinkedIn API** - Auto-sync experience
- **Medium API** - Import blog posts
- **Google Analytics** - Track visitor behavior
- **EmailJS** - Contact form functionality

---

## Conclusion

This functional architecture provides a robust, maintainable, and user-friendly portfolio system. The combination of AI-powered updates, automated deployment, and modern web technologies ensures the site stays current with minimal manual intervention.

For technical implementation details, see [TECHNICAL_ARCHITECTURE.md](./TECHNICAL_ARCHITECTURE.md).
