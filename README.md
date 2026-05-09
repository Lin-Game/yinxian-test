# 引线生产管理系统

基于 Vue 3 + Element Plus + Supabase + Cloudflare Pages 的现代生产管理系统。

## 功能特性

- ✅ 生产记录管理（增删改查）
- ✅ Excel 导入/导出
- ✅ 数据统计图表（Chart.js）
- ✅ 深色/浅色主题
- ✅ 响应式设计
- ✅ Supabase 数据库存储
- ✅ Cloudflare Pages 部署

## 本地开发

### 1. 启动本地服务器

```bash
cd "D:\yinxian web"
python -m http.server 8080
```

### 2. 访问系统

打开浏览器访问：`<A HREF="http://localhost:8080/login.html">http://localhost:8080/login.html</A>`

### 3. 登录

使用在 Supabase Authentication 中创建的用户登录。

---

## Supabase 配置

### 1. 创建数据表

在 Supabase Dashboard → SQL Editor 中执行 `setup-supabase.sql` 文件内容。

### 2. 创建登录用户

在 Supabase Dashboard → Authentication → Users 中添加用户。

### 3. 配置环境变量

在 `login.html` 和 `admin.html` 中更新：
```javascript
const SUPABASE_URL = 'https://oosktyjqqcgjvtjxyony.supabase.co';
const SUPABASE_ANON_KEY = 'your-anon-key';
```

---

## Cloudflare Pages 部署

### 方法 A：连接 GitHub

1. 将代码推送到 GitHub 仓库
2. 登录 [Cloudflare Dashboard](https://dash.cloudflare.com)
3. Pages → Create a project → Connect to Git
4. 配置：
   - **Build command**：（留空）
   - **Build output directory**：`/`
5. 点击 **Save and Deploy**

### 方法 B：直接上传

1. 登录 [Cloudflare Dashboard](https://dash.cloudflare.com)
2. Pages → Upload assets
3. 拖拽 `D:\yinxian web` 文件夹
4. 点击 **Deploy**

---

## 项目结构

```
yinxian-web/
├── login.html          # 登录页面
├── admin.html          # 主管理页面
├── favicon.svg        # 网站图标
├── setup-supabase.sql # 数据库初始化脚本
├── README.md          # 项目说明文档
└── (其他静态资源)
```

---

## 技术栈

- **前端框架**：Vue 3 (CDN)
- **UI 组件库**：Element Plus (CDN)
- **数据库**：Supabase (PostgreSQL)
- **身份认证**：Supabase Auth
- **图表**：Chart.js (CDN)
- **Excel 处理**：SheetJS (CDN)
- **部署**：Cloudflare Pages

---

## 常见问题

### 1. 登录后卡在"正在检查登录状态"

**解决方法**：
- 清除浏览器缓存（`Ctrl + Shift + Delete`）
- 检查 Supabase 配置是否正确
- 在浏览器控制台执行：
  ```javascript
  localStorage.setItem('isLoggedIn', 'true');
  localStorage.setItem('username', 'admin');
  location.reload();
  ```

### 2. Excel 导入失败

**检查项**：
- Excel 文件列名是否匹配（录入日期、流转单号、物料代码等）
- 文件格式是否为 `.xlsx` 或 `.xls`

### 3. 图表不显示

**解决方法**：
- 确保有数据记录
- 检查浏览器控制台是否有错误
- 切换到"数据统计"页面查看

---

##  License

MIT License

---

## 作者

Senior Developer (高级开发工程师)

如需帮助，请提交 Issue 或联系开发者。
