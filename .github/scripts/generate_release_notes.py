import os
import subprocess
from datetime import datetime

def get_git_last_modified(filepath):
    try:
        date_str = subprocess.check_output(
            ["git", "log", "-1", "--format=%cd", "--date=format:%Y-%m-%d %H:%M:%S", filepath]
        ).decode("utf-8").strip()
        return date_str
    except Exception:
        return None

def main():
    repo = os.environ.get("GITHUB_REPOSITORY")
    branch = "master" # Đã sửa thành master cho khớp với file yml của ông
    
    lua_files = []
    
    for root, dirs, files in os.walk("."):
        parts = root.split(os.sep)
        # SỬA LỖI Ở ĐÂY: Bỏ qua thư mục ẩn nhưng không bỏ qua thư mục gốc "."
        if any(part.startswith('.') and part != '.' for part in parts):
            continue
            
        for file in files:
            # Chuyển thành đuôi chữ thường để không bị bỏ sót nếu file lỡ lưu là .Lua hoặc .LUA
            if file.lower().endswith(".lua"):
                full_path = os.path.join(root, file)
                git_path = os.path.relpath(full_path, ".").replace(os.sep, "/")
                
                mod_date = get_git_last_modified(git_path)
                if not mod_date:
                    mod_date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                    
                lua_files.append({
                    "name": file,
                    "path": git_path,
                    "date": mod_date
                })
    
    lua_files.sort(key=lambda x: x["date"], reverse=True)
    
    markdown_lines = []
    markdown_lines.append("# 🚀 Latest Script Loadstrings")
    markdown_lines.append(f"**Global Last Update:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')} (UTC)\n")
    markdown_lines.append("Copy the `loadstring` below and paste it into your Roblox executor:\n")
    
    for f in lua_files:
        raw_url = f"https://raw.githubusercontent.com/{repo}/refs/heads/{branch}/{f['path']}"
        loadstring_code = f'loadstring(game:HttpGet("{raw_url}"))()'
        
        markdown_lines.append(f"### 📄 {f['name']}")
        markdown_lines.append(f"- **Last Updated:** `{f['date']}`")
        markdown_lines.append("```lua")
        markdown_lines.append(loadstring_code)
        markdown_lines.append("```\n")
        
    with open("release_notes.md", "w", encoding="utf-8") as out_file:
        out_file.write("\n".join(markdown_lines))

if __name__ == "__main__":
    main()