"""
Flask API to serve project rankings
"""

from flask import Flask, jsonify
from flask_cors import CORS
import json
import os

app = Flask(__name__)
CORS(app)

RANKINGS_FILE = os.path.join(os.path.dirname(__file__), "project_rankings.json")


@app.route('/api/projects/top', methods=['GET'])
def get_top_projects():
    """Get top 3 ranked projects."""
    try:
        if not os.path.exists(RANKINGS_FILE):
            return jsonify({
                "error": "Rankings not yet generated. Run analyze_projects.py first."
            }), 404
        
        with open(RANKINGS_FILE, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        return jsonify({
            "success": True,
            "last_updated": data["last_updated"],
            "projects": data["top_3"]
        })
    
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route('/api/projects/all', methods=['GET'])
def get_all_projects():
    """Get all ranked projects."""
    try:
        if not os.path.exists(RANKINGS_FILE):
            return jsonify({
                "error": "Rankings not yet generated. Run analyze_projects.py first."
            }), 404
        
        with open(RANKINGS_FILE, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        return jsonify({
            "success": True,
            "last_updated": data["last_updated"],
            "total_projects": data["total_projects"],
            "projects": data["projects"]
        })
    
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route('/api/health', methods=['GET'])
def health_check():
    """Health check endpoint."""
    rankings_exist = os.path.exists(RANKINGS_FILE)
    return jsonify({
        "status": "healthy",
        "rankings_available": rankings_exist
    })


if __name__ == '__main__':
    print("🚀 Starting Project Rankings API...")
    print(f"📊 Rankings file: {RANKINGS_FILE}")
    print("🌐 API will be available at http://localhost:5000")
    print("\nEndpoints:")
    print("  GET /api/projects/top  - Get top 3 projects")
    print("  GET /api/projects/all  - Get all ranked projects")
    print("  GET /api/health        - Health check")
    
    app.run(debug=True, port=5000)
