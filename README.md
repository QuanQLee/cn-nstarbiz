# 北极星工作室官网

北极星工作室面向企业、创业团队和独立项目，提供定制软件系统、网站与移动端、AI 应用、智能硬件联调以及部署维护服务。

当前版本是无需构建工具的纯静态官网，可直接部署到 Nginx、对象存储静态网站或 CDN。

## 文件说明

- `index.html`：首页结构和中文文案
- `styles.css`：桌面端与移动端响应式样式
- `main.js`：移动端导航、需求摘要生成和复制功能
- `privacy.html`：隐私政策
- `robots.txt`：搜索引擎抓取规则
- `sitemap.xml`：站点地图，正式域名为 `https://cn.nstarbiz.com`
- `assets/brand/`：北极星工作室 Logo 与品牌标识
- `assets/hero-connected-development.webp`：首页软硬件协同开发场景图
- `assets/case-website-hero-v2.jpg`：企业官网多端案例展示图
- `assets/case-dashboard-clean.png`：业务系统与数据看板案例展示图
- `assets/case-ai-hardware-clean.png`：AI 与智能硬件联调案例展示图
- `assets/case-detail-*.webp`：场景案例详细展示图
- `assets/wecom-contact-qr.png`：企业微信联系二维码
- `deploy/nginx-cn-static.conf.example`：Nginx 配置示例
- `docs/domestic-deployment.md`：国内部署准备清单

## 本地预览

直接用浏览器打开 `index.html` 即可预览。也可以在项目目录启动本地静态服务器：

```powershell
python -m http.server 4173 --bind 127.0.0.1
```

然后访问 `http://127.0.0.1:4173/index.html`。

## 咨询流程

首页表单只在浏览器中整理并复制一段微信沟通内容，不会自动上传或提交个人信息。

页面右下角提供在线咨询入口，按需加载 `https://app.cn.nstarbiz.com/chat-widget.html`。访客主动发送后，姓名、手机号或邮箱及咨询内容会进入云客 CRM，形成线索、沟通记录和后续跟进任务。公开页面不保存 CRM API 密钥。

当前联系方式：

- 云客 CRM 在线咨询
- 微信 / 企业微信优先
- 电话/微信：`18173933209`
- 备用邮箱：`contact@nstarbiz.com`

联系区已接入企业微信二维码，客户可扫码添加项目负责人；电话和邮箱继续作为备用联系方式。

## 上线前确认

- `contact@nstarbiz.com` 已开通并完成收发测试
- `cn.nstarbiz.com` 已解析到正式服务器或静态托管服务
- HTTPS 证书有效，HTTP 自动跳转 HTTPS
- `https://app.cn.nstarbiz.com/chat-widget.html` 可正常访问，主站在线咨询可发送并进入 CRM
- ICP 备案号与实际备案主体、域名一致
- 当前案例图片均可公开展示，不包含客户隐私或未授权品牌
- 已上传 `index.html`、`privacy.html`、`styles.css`、`main.js`、`robots.txt`、`sitemap.xml` 和完整 `assets/` 目录

公安联网备案和访问统计可在正式上线后继续补充。
