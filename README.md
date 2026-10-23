# 北极星工作室官网

北极星工作室面向企业、创业团队和独立项目，提供定制软件系统、网站与移动端、AI 应用、智能硬件联调以及部署维护服务。

当前版本是无需构建工具的纯静态官网，可直接部署到 Nginx、对象存储静态网站或 CDN。

2026-10-23 产品入口版本已部署至 `https://cn.nstarbiz.com/`。新增首页产品入口，CRM 可进入商户登录，ERP 显示敬请期待。本次不发布本地 CRM 介绍页草稿，保留线上现有业务入口。发布与回滚记录见 `docs/releases/2026-10-23-product-entry.md`；上版记录见 `docs/releases/2026-10-20-homepage.md`。

## 文件说明

- `index.html`：国内官网首页结构和中文文案
- `home.css`：首页独立响应式样式，不影响 CRM 与隐私页
- `home.js`：首页项目方向折叠、服务选择与导航增强
- `styles.css`：隐私页与原版页面的共用样式
- `main.js`：导航、在线咨询与需求摘要生成和复制功能
- `privacy.html`：隐私政策
- `robots.txt`：搜索引擎抓取规则
- `sitemap.xml`：站点地图，国内站主域名为 `https://cn.nstarbiz.com`
- `assets/brand/`：北极星工作室 Logo 与品牌标识
- `assets/icons/`：本地 Lucide 图标与许可证，不依赖外部图标 CDN
- `assets/hero-connected-development.webp`：首页软硬件协同开发场景图
- `assets/case-website-hero-v2.jpg`：企业官网多端案例展示图
- `assets/case-dashboard-clean.png`：业务系统与数据看板案例展示图
- `assets/case-ai-hardware-clean.png`：AI 与智能硬件联调案例展示图
- `assets/case-detail-*.webp`：场景案例详细展示图
- `assets/wecom-contact-qr.png`：企业微信联系二维码
- `crm/`：本地保留的 CRM 介绍页草稿，本次首页发布不包含此目录，不替换线上 CRM 业务系统
- `deploy/nginx-cn-static.conf.example`：Nginx 配置示例
- `docs/domestic-deployment.md`：国内部署准备清单
- `tools/deploy-homepage.ps1`：白名单打包、校验、备份与静态官网原子发布

## 本地预览

直接用浏览器打开 `index.html` 即可预览。也可以在项目目录启动本地静态服务器：

```powershell
python -m http.server 4173 --bind 127.0.0.1
```

然后访问 `http://127.0.0.1:4173/index.html`。

## 咨询流程

本次发布保留服务器已有的 `/crm/` 业务路由。顶部“产品入口”导航通往首页独立入口区：CRM 提供产品介绍锚点和独立域名商户登录，ERP 只提供产品计划，不提供未开放的登录链接。首页 CRM 模块继续提供需求咨询，不将本地介绍页作为已上线页面展示。

首页表单只在浏览器中整理并复制一段微信沟通内容，不会自动上传或提交个人信息。

页面右下角提供在线咨询入口，按需加载 `https://crm.cn.nstarbiz.com/chat-widget.html`。访客主动发送后，姓名、手机号或邮箱及咨询内容会进入云客 CRM，形成线索、沟通记录和后续跟进任务。公开页面不保存 CRM API 密钥。

当前联系方式：

- 云客 CRM 在线咨询
- 企业微信优先
- 备用邮箱：`contact@nstarbiz.com`

联系区已接入企业微信二维码，客户可扫码添加项目负责人；在线咨询和邮箱继续作为补充联系方式。

## 上线前确认

- `contact@nstarbiz.com` 已开通并完成收发测试
- `cn.nstarbiz.com` 已解析到正式服务器或静态托管服务
- `crm.cn.nstarbiz.com` 已解析到云客 CRM 服务并配置有效 HTTPS 证书
- 官网 HTTPS 证书有效，HTTP 自动跳转到 `https://cn.nstarbiz.com`
- `https://crm.cn.nstarbiz.com/chat-widget.html` 可正常访问，主站在线咨询可发送并进入 CRM
- ICP 备案号与实际备案主体、域名一致
- 当前案例图片均可公开展示，不包含客户隐私或未授权品牌
- 已上传 `index.html`、`home.css`、`home.js`、`privacy.html`、`styles.css`、`main.js`、`robots.txt`、`sitemap.xml` 和完整 `assets/` 目录

公安联网备案和访问统计可在正式上线后继续补充。
