import { useEffect, useState } from 'react';
import { Code2, Brain, Database, Cloud, Package, Wrench, Sparkles } from 'lucide-react';

interface SkillsData {
  last_updated: string;
  total_skills: number;
  categories: {
    [category: string]: string[];
  };
}

// Base skill categories with descriptions and manual additions
const baseSkills = [
  { 
    Icon: Brain, 
    label: "Gen AI & LLMs", 
    baseSkills: ["LangChain", "RAG", "NL-to-SQL", "LoRA"],
    category: "AI/ML"
  },
  { 
    Icon: Sparkles, 
    label: "Machine Learning", 
    baseSkills: ["XGBoost", "NLP", "Deep Learning"],
    category: "AI/ML"
  },
  { 
    Icon: Database, 
    label: "Data", 
    baseSkills: ["Python", "SQL", "PySpark", "Informatica"],
    category: "Languages"
  },
  { 
    Icon: Cloud, 
    label: "Cloud & DevOps", 
    baseSkills: ["Azure", "Jenkins", "Docker", "MongoDB"],
    category: "Cloud & DevOps"
  },
];

export default function Skills() {
  const [projectSkills, setProjectSkills] = useState<SkillsData | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch('/api/skills.json')
      .then((res) => res.json())
      .then((data) => {
        setProjectSkills(data);
        setLoading(false);
      })
      .catch((err) => {
        console.error('Failed to load skills:', err);
        setLoading(false);
      });
  }, []);

  if (loading) {
    return (
      <div className="space-y-4">
        {baseSkills.map(({ Icon, label, baseSkills: skills }) => (
          <div key={label} className="rounded-xl border border-border bg-card p-4">
            <div className="flex items-center gap-2 text-primary">
              <Icon className="h-4 w-4" />
              <span className="font-mono text-xs uppercase tracking-widest">{label}</span>
            </div>
            <p className="mt-2 text-sm">{skills.join(' · ')}</p>
          </div>
        ))}
      </div>
    );
  }

  // Merge base skills with project skills
  const mergedSkills = baseSkills.map(({ Icon, label, baseSkills: manual, category }) => {
    const allSkills = new Set(manual);
    
    // Add skills from projects that match this category
    if (projectSkills?.categories[category]) {
      projectSkills.categories[category].forEach((skill: string) => {
        allSkills.add(skill);
      });
    }
    
    return {
      Icon,
      label,
      skills: Array.from(allSkills)
    };
  });

  return (
    <div className="space-y-4">
      {mergedSkills.map(({ Icon, label, skills }) => (
        <div key={label} className="rounded-xl border border-border bg-card p-4">
          <div className="flex items-center gap-2 text-primary">
            <Icon className="h-4 w-4" />
            <span className="font-mono text-xs uppercase tracking-widest">{label}</span>
          </div>
          <p className="mt-2 text-sm">{skills.join(' · ')}</p>
        </div>
      ))}
    </div>
  );
}
