const homeHeader = document.querySelector("[data-header]");
const homeNavToggle = document.querySelector(".nav-toggle");
const homeNav = document.querySelector(".site-nav");

function closeHomeNav(returnFocus = false) {
  if (!homeNavToggle) return;
  const wasOpen = homeNavToggle.getAttribute("aria-expanded") === "true";
  homeNavToggle.setAttribute("aria-expanded", "false");
  homeNavToggle.setAttribute("aria-label", "打开导航");
  homeNavToggle.title = "打开导航";
  homeNav?.classList.remove("is-open");
  homeHeader?.classList.remove("is-open");
  document.body.classList.remove("nav-open");
  if (returnFocus && wasOpen) homeNavToggle.focus();
}

homeNavToggle?.addEventListener("click", () => {
  const isOpen = homeNavToggle.getAttribute("aria-expanded") === "true";
  const label = isOpen ? "关闭导航" : "打开导航";
  homeNavToggle.setAttribute("aria-label", label);
  homeNavToggle.title = label;
  if (isOpen) window.requestAnimationFrame(() => homeNav?.querySelector("a")?.focus());
});

homeNav?.addEventListener("click", (event) => {
  if (event.target instanceof Element && event.target.closest("a")) closeHomeNav();
});

document.addEventListener("keydown", (event) => {
  if (event.key === "Escape") closeHomeNav(true);
});

document.addEventListener("click", (event) => {
  if (event.target instanceof Node && !homeHeader?.contains(event.target)) closeHomeNav();
});

window.matchMedia("(min-width: 801px)").addEventListener("change", (event) => {
  if (event.matches) closeHomeNav();
});

document.querySelectorAll("[data-exclusive-details]").forEach((group) => {
  group.addEventListener("toggle", (event) => {
    const current = event.target;
    if (!(current instanceof HTMLDetailsElement) || !current.open) return;
    group.querySelectorAll("details[open]").forEach((item) => {
      if (item !== current) item.open = false;
    });
  }, true);
});

document.querySelectorAll("[data-interest]").forEach((button) => {
  button.addEventListener("click", () => {
    const field = document.querySelector('[data-lead-form] select[name="interest"]');
    const contact = document.querySelector("#contact");
    if (!(field instanceof HTMLSelectElement) || !contact) return;
    field.value = button.dataset.interest;
    field.dispatchEvent(new Event("change", { bubbles: true }));
    contact.scrollIntoView({ behavior: window.matchMedia("(prefers-reduced-motion: reduce)").matches ? "instant" : "smooth" });
    field.focus({ preventScroll: true });
  });
});

// The contact section already has a chat button; don't cover its form with a second one.
const homeContact = document.querySelector("#contact");
const homeChat = document.querySelector("[data-crm-chat]");
const homeChatPanel = document.querySelector("[data-crm-chat-panel]");
if (homeContact && homeChat && homeChatPanel && "IntersectionObserver" in window) {
  new IntersectionObserver(([entry]) => {
    homeChat.classList.toggle("is-over-contact", entry.isIntersecting);
  }).observe(homeContact);
  const visibleIntroSections = new Set();
  const introObserver = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) visibleIntroSections.add(entry.target);
      else visibleIntroSections.delete(entry.target);
    });
    homeChat.classList.toggle("is-over-intro", visibleIntroSections.size > 0);
  });
  document.querySelectorAll(".hero, .service-index").forEach((section) => introObserver.observe(section));
  new MutationObserver(() => {
    if (homeChatPanel.hidden && homeChat.classList.contains("is-over-contact")) {
      homeContact.querySelector("[data-crm-chat-open]")?.focus({ preventScroll: true });
    } else if (homeChatPanel.hidden && homeChat.classList.contains("is-over-intro") && window.matchMedia("(max-width: 560px)").matches) {
      document.querySelector(".hero-actions .button")?.focus({ preventScroll: true });
    }
  }).observe(homeChatPanel, { attributes: true, attributeFilter: ["hidden"] });
}
