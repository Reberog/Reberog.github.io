# GitHub Pages Troubleshooting

## Issue: Site works locally but shows blank on GitHub Pages

### Verified:
- ✅ Local build works (`npm run build` + `npm run preview`)
- ✅ Base path is correct (`/`)
- ✅ All assets are in `dist/`
- ✅ API files are copied
- ❌ GitHub Pages shows blank page

### Possible Causes:

1. **Browser Caching**: GitHub Pages is serving the old blank version
2. **GitHub Pages Cache**: CDN hasn't refreshed yet
3. **Missing files in deployment**: GitHub Actions might not be uploading everything

### Solutions to Try:

#### 1. Hard Refresh (Try This First!)
- Visit: https://reberog.github.io
- Press: `Cmd + Shift + R` (Mac) or `Ctrl + Shift + R` (Windows)
- Or: Open in Incognito/Private window

#### 2. Check GitHub Pages Settings
1. Go to: https://github.com/Reberog/Reberog.github.io/settings/pages
2. Verify:
   - Source: **GitHub Actions** (not "Deploy from a branch")
   - Custom domain: Empty (or set correctly)

#### 3. Check Latest Deployment
- Go to: https://github.com/Reberog/Reberog.github.io/deployments
- Click the latest deployment
- Check the deployed URL

#### 4. Wait for CDN
- GitHub Pages uses a CDN that can take 5-10 minutes to update
- Even after build completes, CDN may show old content

#### 5. Check Workflow Logs
- Go to: https://github.com/Reberog/Reberog.github.io/actions
- Click the latest "Deploy to GitHub Pages" workflow
- Check the "Upload artifact" step - ensure it uploaded files

### Next Deploy:
We've added console logs to help debug. Once the next deployment completes:
1. Visit: https://reberog.github.io
2. Open Console (F12)
3. Check for any error messages

The site **definitely works** - we just need GitHub Pages to serve the new version!
