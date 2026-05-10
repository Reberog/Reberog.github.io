# 🚨 QUICK FIX - Run These Commands in Mac Terminal

## ⚠️ IMPORTANT: Use Mac Terminal App, NOT VS Code Terminal!

The git repository needs to be accessed from your native Mac Terminal.

---

## 🔧 Step-by-Step Fix

### 1. Open Mac Terminal
- Press `Cmd + Space`
- Type "Terminal"
- Press Enter

### 2. Navigate to your project
```bash
cd /Users/arpananand/Documents/Portfolio/portfolio-project
```

### 3. Check current git status
```bash
git status
```

### 4. Remove node_modules from staging
```bash
git reset HEAD node_modules/
git rm -r --cached node_modules/ 2>/dev/null || true
```

### 5. Make sure .gitignore has node_modules
```bash
cat .gitignore | grep node_modules
```
(Should show `node_modules/`)

### 6. Re-add only source files
```bash
git add .gitignore
git add src/
git add package.json tsconfig.json vite.config.ts
git add .github/
git add README.md 2>/dev/null || true
```

### 7. Check what will be committed
```bash
git status
```
(Should NOT show any node_modules files)

### 8. Commit the changes
```bash
git commit -m "Deploy portfolio - exclude node_modules"
```

### 9. Push to GitHub (with force if needed)
```bash
git push -u origin main --force
```

---

## ✅ Verification

After pushing, check:

1. **GitHub Repository Size:**
   - Go to: https://github.com/reberog/reberog.github.io
   - Should be < 50MB

2. **GitHub Actions:**
   - Go to: https://github.com/reberog/reberog.github.io/actions
   - Should start building automatically

3. **Your Site:**
   - Wait for build to complete
   - Visit: https://reberog.github.io

---

## 🆘 If It Still Fails

If you still get the "files over 100MB" error, you need a complete reset:

### Complete Reset (Nuclear Option)

```bash
cd /Users/arpananand/Documents/Portfolio/portfolio-project

# Backup your source files first!
mkdir -p ~/Desktop/portfolio-backup
cp -r src ~/Desktop/portfolio-backup/
cp -r .github ~/Desktop/portfolio-backup/
cp package.json tsconfig.json vite.config.ts ~/Desktop/portfolio-backup/

# Delete .git folder
rm -rf .git

# Initialize fresh repo
git init
git branch -M main

# Add only necessary files
git add .gitignore
git add src/ .github/ package.json tsconfig.json vite.config.ts README.md

# Commit
git commit -m "Initial commit: Portfolio project"

# Add remote and force push
git remote add origin https://github.com/reberog/reberog.github.io.git
git push -u origin main --force
```

---

## 📝 What This Does

- ✅ Removes ALL node_modules from git
- ✅ Only commits your source code
- ✅ Keeps .gitignore so future commits ignore node_modules
- ✅ GitHub Actions will install dependencies during build
- ✅ Ensures no 100MB+ files are pushed

---

## 🎯 Expected Result

After running these commands:
- ✅ Git push succeeds
- ✅ No large file errors
- ✅ GitHub Actions builds your site
- ✅ Site live at https://reberog.github.io

Good luck! 🚀
