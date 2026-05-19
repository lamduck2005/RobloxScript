import os
import subprocess
from datetime import datetime

def get_git_last_modified(filepath):
    try:
        date_str = subprocess.check_output(
            ["git", "log", "-1", "--format=%cd", "--date=format:%Y-%m-%d %H:%M:%S", filepath]
        ).decode("utf-8").strip()
        return date_str if date_str else None
    except Exception:
        return None

def main():
    repo = os.environ.get("GITHUB_REPOSITORY", "unknown/repo")
    branch = os.environ.get("GITHUB_REF_NAME", "master")
    
    lua_files = []
    
    for root, dirs, files in os.walk("."):
        dirs[:] = [d for d in dirs if not d.startswith('.')]
        
        for file in files:
            if file.lower().endswith(".lua"):
                full_path = os.path.join(root, file)
                git_path = os.path.relpath(full_path, ".").replace(os.sep, "/")
                
                mod_date = get_git_last_modified(git_path)
                if not mod_date:
                    mod_date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                base_name = file[:-4] 
                display_name = base_name.replace("-", " ").replace("_", " ").title()
                
                lua_files.append({
                    "name": display_name, 
                    "path": git_path, 
                    "date": mod_date
                })
    
    lua_files.sort(key=lambda x: x["date"], reverse=True)
    
    print(f"[*] Đã tìm thấy {len(lua_files)} file .lua:")
    for f in lua_files:
        print(f" -> {f['path']} (Sẽ hiển thị thành: {f['name']})")
    
    markdown_lines = []
    markdown_lines.append("# Latest Script Loadstrings")
    markdown_lines.append(f"**Global Last Update:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')} (UTC)\n")
    markdown_lines.append("Copy the `loadstring` below and paste it into your Roblox executor:\n")
    
    if not lua_files:
        markdown_lines.append(">- No `.lua` scripts were found in the repository!")
    
    for f in lua_files:
        raw_url = f"https://raw.githubusercontent.com/{repo}/{branch}/{f['path']}"
        loadstring_code = f'loadstring(game:HttpGet("{raw_url}", true))()'
        
        markdown_lines.append(f"### {f['name']}")
        markdown_lines.append(f"- **Last Updated:** `{f['date']}`")
        markdown_lines.append("```lua")
        markdown_lines.append(loadstring_code)
        markdown_lines.append("```\n")
        
    with open("release_notes.md", "w", encoding="utf-8") as out_file:
        out_file.write("\n".join(markdown_lines))
        print("[*] Đã tạo xong file release_notes.md")

if __name__ == "__main__":
    main()