# 🚀 Deployment Guide - Fixing Large Files Issue

## The Problem
Your git repository has large binary files from `node_modules/@cloudflare/workerd-*` packages that exceed GitHub's 100MB file limit. These files should never be committed.

## ✅ Solution Options

### Option 1: Quick Fix (Try First)
Use this if you just want to remove node_modules from staging:

```bash
cd /Users/arpananand/Documents/Portfolio/portfolio-project
bash fix-large-files.sh
```

This will:
- Remove node_modules from git staging
- Specifically target the large Cloudflare binaries
- Re-stage only necessary files
- Show you what will be committed

After running, commit and push:
```bash
git commit -m "Deploy portfolio - remove large files"
git push -u origin main
```

If push fails, try force push:
```bash
git push -u origin main --force
```

---

### Option 2: Complete Reset (Recommended)
Use this for a clean start if Option 1 doesn't work:

```bash
cd /Users/arpananand/Documents/Portfolio/portfolio-project
bash reset-and-deploy.sh
```

This will:
- **Delete the .git folder completely** (fresh start)
- Initialize a new repository
- Add ONLY necessary source files (no node_modules)
- Create an initial commit
- Force push to GitHub

**⚠️ Warning:** This will overwrite your GitHub repository history!

---

## 📋 What Gets Committed

Only these files are needed:
- ✅ `src/` - Your source code
- ✅ `.github/workflows/` - Deployment workflow
- ✅ `package.json` - Dependencies list
- ✅ `tsconfig.json` - TypeScript config
- ✅ `vite.config.ts` - Build config
- ✅ Other config files (.gitignore, README, etc.)

**NOT committed:**
- ❌ `node_modules/` - Dependencies (will be installed by GitHub Actions)
- ❌ `dist/` - Build output (will be generated during deployment)
- ❌ Large binaries or temporary files

---

## 🔍 After Running

1. **Check your commit size:**
   ```bash
   git ls-files | xargs ls -lh | awk '{total += $5} END {print total/1024/1024 " MB"}'
   ```
   Should be < 50MB total

2. **Verify GitHub Actions:**
   - Go to: https://github.com/reberog/reberog.github.io/actions
   - Watch the workflow run
   - Should complete successfully

3. **Check your site:**
   - Visit: https://reberog.github.io
   - Should load your portfolio

---

## 🆘 Still Having Issues?

If you still get errors about large files:

1. Check what's staged:
   ```bash
   git diff --cached --name-only
   ```

2. See file sizes:
   ```bash
   git ls-files | xargs ls -lh | sort -k5 -rh | head -20
   ```

3. Manually remove a specific file:
   ```bash
   git rm --cached path/to/large/file
   ```

4. Or use the complete reset (Option 2)

---

## 📝 Next Steps After Successful Push

1. ✅ GitHub Actions will automatically:
   - Install dependencies
   - Build your project
   - Deploy to GitHub Pages

2. ✅ Your site will be live at: https://reberog.github.io

3. ✅ Future updates: Just commit your source changes, GitHub Actions handles the rest!

---

## 🎯 Quick Reference

**Try Option 1 first:**
```bash
cd /Users/arpananand/Documents/Portfolio/portfolio-project
bash fix-large-files.sh
git commit -m "Deploy portfolio"
git push -u origin main --force
```

**If that fails, use Option 2:**
```bash
cd /Users/arpananand/Documents/Portfolio/portfolio-project
bash reset-and-deploy.sh
```

That's it! 🎉
