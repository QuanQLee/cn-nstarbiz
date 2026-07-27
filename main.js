const header = document.querySelector("[data-header]");
const navToggle = document.querySelector(".nav-toggle");
const siteNav = document.querySelector(".site-nav");
const leadForm = document.querySelector("[data-lead-form]");
const formOutput = document.querySelector("[data-form-output]");
const mailAction = document.querySelector("[data-mail-action]");
const crmChat = document.querySelector("[data-crm-chat]");
const crmChatPanel = document.querySelector("[data-crm-chat-panel]");
const crmChatLauncher = document.querySelector("[data-crm-chat-launcher]");
const crmChatClose = document.querySelector("[data-crm-chat-close]");
const crmChatFrame = document.querySelector("[data-crm-chat-frame]");
const crmChatLabel = document.querySelector("[data-crm-chat-label]");
const crmChatOpenButtons = document.querySelectorAll("[data-crm-chat-open]");

function syncHeaderState() {
  if (!header) {
    return;
  }

  header.classList.toggle("is-scrolled", window.scrollY > 12);
}

syncHeaderState();
window.addEventListener("scroll", syncHeaderState, { passive: true });

navToggle?.addEventListener("click", () => {
  const isOpen = navToggle.getAttribute("aria-expanded") === "true";
  navToggle.setAttribute("aria-expanded", String(!isOpen));
  siteNav?.classList.toggle("is-open", !isOpen);
  header?.classList.toggle("is-open", !isOpen);
  document.body.classList.toggle("nav-open", !isOpen);
});

siteNav?.addEventListener("click", (event) => {
  if (!(event.target instanceof HTMLAnchorElement)) {
    return;
  }

  navToggle?.setAttribute("aria-expanded", "false");
  siteNav.classList.remove("is-open");
  header?.classList.remove("is-open");
  document.body.classList.remove("nav-open");
});

function setCRMChatOpen(isOpen, returnFocus = false) {
  if (!crmChat || !crmChatPanel || !crmChatLauncher) {
    return;
  }

  if (isOpen && crmChatFrame && !crmChatFrame.getAttribute("src")) {
    crmChatFrame.src = crmChatFrame.dataset.src || "";
  }

  crmChatPanel.hidden = !isOpen;
  crmChat.classList.toggle("is-open", isOpen);
  crmChatLauncher.setAttribute("aria-expanded", String(isOpen));

  if (crmChatLabel) {
    crmChatLabel.textContent = isOpen ? "收起咨询" : "在线咨询";
  }

  if (isOpen) {
    window.requestAnimationFrame(() => crmChatClose?.focus());
  } else if (returnFocus) {
    crmChatLauncher.focus();
  }
}

crmChatLauncher?.addEventListener("click", () => {
  const isOpen = crmChatLauncher.getAttribute("aria-expanded") === "true";
  setCRMChatOpen(!isOpen);
});

crmChatClose?.addEventListener("click", () => {
  setCRMChatOpen(false, true);
});

crmChatOpenButtons.forEach((button) => {
  button.addEventListener("click", () => setCRMChatOpen(true));
});

document.addEventListener("keydown", (event) => {
  if (event.key === "Escape" && crmChatLauncher?.getAttribute("aria-expanded") === "true") {
    setCRMChatOpen(false, true);
  }
});

leadForm?.addEventListener("submit", async (event) => {
  event.preventDefault();

  const formData = new FormData(leadForm);
  const company = String(formData.get("company") || "未填写企业/个人名称").trim();
  const contact = String(formData.get("contact") || "未填写联系方式").trim();
  const stage = String(formData.get("stage") || "未选择项目阶段").trim();
  const interest = String(formData.get("interest") || "未选择方向").trim();
  const message = String(formData.get("message") || "未填写需求描述").trim();

  const summary = `你好，我想咨询北极星工作室项目服务。\n\n名称：${company}\n联系方式：${contact}\n项目阶段：${stage}\n关注方向：${interest}\n需求：${message}`;
  let copyHint = "已生成微信沟通内容，请复制后通过微信 / 企业微信发送给北极星工作室。";

  if (navigator.clipboard?.writeText) {
    try {
      await navigator.clipboard.writeText(summary);
      copyHint = "已生成并复制，可直接粘贴到微信 / 企业微信发送给北极星工作室。";
    } catch {
      copyHint = "已生成微信沟通内容。当前浏览器未允许自动复制，请手动复制下方内容。";
    }
  }

  formOutput.textContent = `${copyHint}\n\n${summary}`;
  formOutput.classList.add("is-visible");

  if (mailAction) {
    const subject = encodeURIComponent(`项目咨询 - ${company}`);
    const body = encodeURIComponent(summary);
    mailAction.href = `mailto:contact@nstarbiz.com?subject=${subject}&body=${body}`;
    mailAction.classList.add("is-visible");
  }
});
