const header = document.querySelector("[data-header]");
const navToggle = document.querySelector(".nav-toggle");
const siteNav = document.querySelector(".site-nav");
const leadForm = document.querySelector("[data-lead-form]");
const formOutput = document.querySelector("[data-form-output]");

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

leadForm?.addEventListener("submit", (event) => {
  event.preventDefault();

  const formData = new FormData(leadForm);
  const company = String(formData.get("company") || "未填写企业/个人名称").trim();
  const contact = String(formData.get("contact") || "未填写联系方式").trim();
  const stage = String(formData.get("stage") || "未选择项目阶段").trim();
  const interest = String(formData.get("interest") || "未选择方向").trim();
  const message = String(formData.get("message") || "未填写需求描述").trim();

  formOutput.textContent = `需求摘要已整理：\n名称：${company}\n联系方式：${contact}\n项目阶段：${stage}\n关注方向：${interest}\n需求：${message}\n\n你可以将这段摘要发送至 contact@nstarbiz.com，或拨打 18173933209 沟通项目范围、周期和协作方式。`;
  formOutput.classList.add("is-visible");
});
