# Claude Code MCP 配置

本目录包含 Claude Code 的配置文件，包括 MCP (Model Context Protocol) 服务器配置。

## 当前已配置的 MCP 服务器

查看已配置的 MCP 服务器：
```bash
claude mcp list
```

当前配置（5 个服务器）：
```
filesystem: npx -y @modelcontextprotocol/server-filesystem /Users/lzh/Documents /Users/lzh/Desktop - ✓ Connected
fetch: npx -y @kazuph/mcp-fetch - ✓ Connected
thinking: npx -y @modelcontextprotocol/server-sequential-thinking - ✓ Connected
memory: npx -y @modelcontextprotocol/server-memory - ✓ Connected
tavily: npx -y tavily-mcp - ✓ Connected
```

---

## 完整 MCP 配置

### 配置文件位置

**`~/.mcp.json`**

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/Users/lzh/Documents",
        "/Users/lzh/Desktop"
      ]
    },
    "fetch": {
      "command": "npx",
      "args": ["-y", "@kazuph/mcp-fetch"]
    },
    "thinking": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
    },
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    },
    "tavily": {
      "command": "npx",
      "args": ["-y", "tavily-mcp"],
      "env": {
        "TAVILY_API_KEY": "你的 Tavily API Key"
      }
    }
  }
}
```

---

## 各 MCP 服务器说明

### 1. Filesystem - 文件系统访问

**包名**: `@modelcontextprotocol/server-filesystem`

**功能**:
- 读写文件
- 创建目录
- 列出目录内容
- 搜索文件
- 获取文件元数据

**允许的路径**: `/Users/lzh/Documents`, `/Users/lzh/Desktop`

**可用工具**:
- `mcp__filesystem__write_file`
- `mcp__filesystem__read_text_file`
- `mcp__filesystem__read_multiple_files`
- `mcp__filesystem__create_directory`
- `mcp__filesystem__list_directory`
- `mcp__filesystem__directory_tree`
- `mcp__filesystem__search_files`
- `mcp__filesystem__get_file_info`

---

### 2. Fetch - 网页获取

**包名**: `@kazuph/mcp-fetch`

**功能**:
- 获取网页内容
- 图片提取（支持 BASE64）
- Markdown 转换

**可用工具**:
- `mcp__fetch__imageFetch`

---

### 3. Thinking - 顺序思考

**包名**: `@modelcontextprotocol/server-sequential-thinking`

**功能**:
- 结构化思考过程
- 问题分解与分析
- 假设生成与验证

**可用工具**:
- `mcp__thinking__sequentialthinking`

---

### 4. Memory - 知识图谱记忆

**包名**: `@modelcontextprotocol/server-memory`

**功能**:
- 存储实体与关系
- 添加观察记录
- 搜索知识图谱

**可用工具**:
- `mcp__memory__create_entities`
- `mcp__memory__create_relations`
- `mcp__memory__add_observations`
- `mcp__memory__search_nodes`
- `mcp__memory__open_nodes`
- `mcp__memory__read_graph`

---

### 5. Tavily - Web 搜索

**包名**: `tavily-mcp`

**功能**:
- Web 搜索
- 内容提取
- 网站爬取
- 网站地图生成

**需要 API Key**: 从 https://tavily.com/ 获取

**可用工具**:
- `mcp__tavily__tavily-search`
- `mcp__tavily__tavily-extract`
- `mcp__tavily__tavily-crawl`
- `mcp__tavily__tavily-map`

---

## 新 Mac 安装步骤

### 1. 安装 Node.js

```bash
# 使用 Homebrew 安装
brew install node

# 验证安装
node --version
npm --version
```

### 2. 创建 MCP 配置文件

```bash
# 创建 ~/.mcp.json
cat > ~/.mcp.json << 'EOF'
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/Users/YOUR_USERNAME/Documents",
        "/Users/YOUR_USERNAME/Desktop"
      ]
    },
    "fetch": {
      "command": "npx",
      "args": ["-y", "@kazuph/mcp-fetch"]
    },
    "thinking": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
    },
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    },
    "tavily": {
      "command": "npx",
      "args": ["-y", "tavily-mcp"],
      "env": {
        "TAVILY_API_KEY": "你的 Tavily API Key"
      }
    }
  }
}
EOF
```

**重要**: 将 `YOUR_USERNAME` 替换为你的用户名，将 `TAVILY_API_KEY` 替换为你的 API Key。

### 3. 获取 Tavily API Key（可选）

如果需要 Web 搜索功能：
1. 访问 https://tavily.com/
2. 注册账号
3. 获取免费 API Key
4. 更新 `~/.mcp.json` 中的 `TAVILY_API_KEY`

### 4. 验证安装

```bash
# 列出已配置的 MCP 服务器
claude mcp list

# 应该看到所有服务器显示 "✓ Connected"
```

### 5. 复制本地配置（可选）

```bash
# 复制 Dotfiles 中的权限配置
mkdir -p ~/Dotfiles/.claude
cp /path/to/this/repo/settings.local.json ~/Dotfiles/.claude/
```

---

## 自定义路径

根据需要修改 Filesystem MCP 的允许路径：

```json
"filesystem": {
  "command": "npx",
  "args": [
    "-y",
    "@modelcontextprotocol/server-filesystem",
    "/path/to/dir1",
    "/path/to/dir2"
  ]
}
```

**注意**: 路径必须是绝对路径。

---

## 配置文件位置总结

| 文件 | 位置 | 作用 | 是否必需 |
|------|------|------|----------|
| MCP 服务器配置 | `~/.mcp.json` | 定义所有 MCP 服务器 | ✅ 必需 |
| Claude 主配置 | `~/.claude.json` | Claude 设置（自动生成） | 自动生成 |
| 本地权限配置 | `~/Dotfiles/.claude/settings.local.json` | 工具权限白名单 | 可选 |
| 用户指令 | `~/Dotfiles/.claude/CLAUDE.md` | 自定义提示词 | 可选 |

---

## 故障排查

### MCP 服务器未连接

```bash
# 检查服务器状态
claude mcp list

# 如果显示 "✗ Disconnected"，检查：
# 1. Node.js 是否已安装
node --version

# 2. 网络连接是否正常
ping registry.npmjs.org

# 3. 手动测试 MCP 包
npx -y @modelcontextprotocol/server-filesystem --help
```

### 权限错误

确保 `settings.local.json` 包含所需权限：

```json
{
  "permissions": {
    "allow": [
      "Bash(*)",
      "mcp__filesystem__*",
      "mcp__fetch__*",
      "mcp__thinking__*",
      "mcp__memory__*",
      "mcp__tavily__*"
    ]
  }
}
```

---

## 参考链接

- MCP 官方文档: https://modelcontextprotocol.io/
- MCP 服务器列表: https://github.com/modelcontextprotocol/servers
- Tavily: https://tavily.com/

---

**更新日期**: 2026-01-15
