#!/usr/bin/env node

/**
 * Update Script - Checks GitHub for new commits and updates project rankings
 * Run with: node update-projects.js
 */

const https = require('https');
const fs = require('fs');
const path = require('path');

// Configuration
const GH_OWNER = 'Reberog';
const GH_REPO = 'AI-PROJECTS';
const RANKINGS_PATH = path.join(__dirname, 'public/api/project_rankings.json');

console.log('🔄 Checking for project updates...\n');

function httpsGet(url) {
  return new Promise((resolve, reject) => {
    https.get(url, { headers: { 'User-Agent': 'Portfolio-Updater' } }, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => {
        if (res.statusCode === 200) {
          try {
            resolve(JSON.parse(data));
          } catch (e) {
            reject(new Error('Failed to parse JSON'));
          }
        } else {
          reject(new Error(`HTTP ${res.statusCode}`));
        }
      });
    }).on('error', reject);
  });
}

async function getLatestCommit(projectPath) {
  const encodedPath = projectPath.split('/').map(encodeURIComponent).join('/');
  const url = `https://api.github.com/repos/${GH_OWNER}/${GH_REPO}/commits?path=${encodedPath}&per_page=1`;
  
  try {
    const commits = await httpsGet(url);
    if (commits && commits.length > 0) {
      return {
        sha: commits[0].sha,
        date: commits[0].commit.author.date,
        message: commits[0].commit.message
      };
    }
  } catch (error) {
    console.error(`   ❌ Error fetching commits: ${error.message}`);
  }
  
  return null;
}

async function updateProjects() {
  // Read current rankings
  if (!fs.existsSync(RANKINGS_PATH)) {
    console.error('❌ Rankings file not found:', RANKINGS_PATH);
    process.exit(1);
  }

  const rankings = JSON.parse(fs.readFileSync(RANKINGS_PATH, 'utf8'));
  let hasUpdates = false;
  const updatedProjects = [];

  console.log(`📊 Checking ${rankings.projects.length} project(s)...\n`);

  for (const project of rankings.projects) {
    console.log(`🔍 ${project.name}`);
    console.log(`   Path: ${project.path}`);
    
    const latestCommit = await getLatestCommit(project.path);
    
    if (!latestCommit) {
      console.log(`   ⚠️  Could not fetch commit info\n`);
      continue;
    }

    const currentSHA = project.last_commit_sha;
    const latestSHA = latestCommit.sha;

    console.log(`   Current SHA: ${currentSHA ? currentSHA.substring(0, 8) : 'none'}`);
    console.log(`   Latest SHA:  ${latestSHA.substring(0, 8)}`);
    
    if (currentSHA !== latestSHA) {
      console.log(`   ✅ NEW COMMIT DETECTED!`);
      console.log(`   📝 Message: "${latestCommit.message}"`);
      console.log(`   📅 Date: ${new Date(latestCommit.date).toLocaleString()}`);
      
      // Update commit info
      project.last_commit = latestCommit.date;
      project.last_commit_sha = latestSHA;
      
      updatedProjects.push(project.name);
      hasUpdates = true;
    } else {
      console.log(`   ℹ️  No changes`);
    }
    console.log('');
  }

  if (hasUpdates) {
    // Update last_check timestamp
    rankings.last_check = new Date().toISOString();
    rankings.last_updated = new Date().toISOString();
    
    // Save updated rankings
    fs.writeFileSync(RANKINGS_PATH, JSON.stringify(rankings, null, 2));
    
    console.log('━'.repeat(50));
    console.log('✅ UPDATE COMPLETE!');
    console.log('━'.repeat(50));
    console.log(`📦 Updated projects (${updatedProjects.length}):`);
    updatedProjects.forEach(name => console.log(`   • ${name}`));
    console.log(`\n💾 Saved to: ${RANKINGS_PATH}`);
    console.log(`🕐 Last check: ${rankings.last_check}`);
    console.log('\n🎉 Refresh your browser to see the changes!\n');
  } else {
    console.log('━'.repeat(50));
    console.log('✅ All projects are up to date!');
    console.log('━'.repeat(50));
    console.log(`🕐 Last check: ${new Date().toISOString()}\n`);
  }

  return {
    success: true,
    hasUpdates,
    updatedProjects,
    timestamp: new Date().toISOString()
  };
}

// Run the update
updateProjects()
  .then(() => process.exit(0))
  .catch(error => {
    console.error('\n❌ FATAL ERROR:', error);
    process.exit(1);
  });
