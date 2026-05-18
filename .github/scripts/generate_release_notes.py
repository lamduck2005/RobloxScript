import os
import subprocess
from datetime import datetime

def get_git_last_modified(filepath):
    try:
        # Lấy ngày giờ của commit cuối cùng tác động đến file này
        date_str = subprocess.check_output(
            ["git", "log", "-1", "--format=%cd", "--date=format:%Y-%m-%d %H:%M:%S", filepath]
        ).decode("utf-8").strip()
        return date_str
    except Exception:
        return None

def main():
    repo = os.environ.get("GITHUB_REPOSITORY") # Tự động lấy "username/repo_name"
    branch = "main" # Đổi thành "master" nếu repo của ông dùng master làm mặc định
    
    lua_files = []
    
    # Quét tất cả các file trong thư mục
    for root, dirs, files in os.walk("."):
        # Bỏ qua các thư mục ẩn hệ thống của git và github
        if any(part.startswith('.') for part in root.split(os.sep)):
            continue
        for file in files:
            if file.endswith(".lua"):
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
    
    # Sắp xếp danh sách file theo ngày cập nhật giảm dần (mới nhất lên đầu)
    lua_files.sort(key=lambda x: x["date"], reverse=True)
    
    # Khởi tạo nội dung Markdown bằng tiếng Anh cho Release
    markdown_lines = []
    markdown_lines.append("# 🚀 Latest Script Loadstrings")
    markdown_lines.append(f"**Global Last Update:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')} (UTC)\n")
    markdown_lines.append("Copy the `loadstring` below and paste it into your Roblox executor:\n")
    
    for f in lua_files:
        # Tạo đường dẫn raw chuẩn của GitHub
        raw_url = f"https://raw.githubusercontent.com/{repo}/refs/heads/{branch}/{f['path']}"
        loadstring_code = f'loadstring(game:HttpGet("{raw_url}"))()'
        
        markdown_lines.append(f"### 📄 {f['name']}")
        markdown_lines.append(f"- **Last Updated:** `{f['date']}`")
        markdown_lines.append("```lua")
        markdown_lines.append(loadstring_code)
        markdown_lines.append("```\n")
        
    # Ghi nội dung ra file tạm để GitHub Action đọc
    with open("release_notes.md", "w", encoding="utf-8") as out_file:
        out_file.write("\n".join(markdown_lines))

if __name__ == "__main__":
    main()