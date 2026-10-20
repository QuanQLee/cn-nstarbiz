# Domestic Homepage Design QA

Date: 2026-10-20. Scope: domestic homepage release; existing CRM remains unchanged.

## Production Release Acceptance

- Published URL: https://cn.nstarbiz.com/.
- Release: `site-20261020-homepage-r1`. A private previous-version archive exists
  and the old release directory remains available for rollback.
- Screenshots: `artifacts/deployment-20261020/live-desktop.png`,
  `live-mobile.png`, and `live-chat-mobile.png`; opened and inspected after release.
- Results: `artifacts/deployment-20261020/live-results.json`. The homepage and
  27 public resource responses have SHA256 values matching the local release.
- Live 1440x900 and 390x844, image loading, mobile menu, consultation selection,
  local-only summary generation, role-only contact text, HTTPS, and HTTP redirect
  passed. The real chat iframe/form loads without console or JavaScript errors.
- No live chat message or email was sent. Physical QR scanning and receipt of
  messages were not tested by automation.
- Removed the unpublished CRM marketing route from sitemap. The homepage now
  offers CRM consultation and separate merchant login without replacing `/crm/`.
- Production CRM files and Nginx configuration hashes did not change.
- Release record: `docs/releases/2026-10-20-homepage.md`.

## Color And Density Revision

The user approved a brighter blue-green action color, blue CRM module, mint
software module, charcoal AI module, and restrained warm hardware/gold details.
Only homepage `index.html` and `home.css` changed in this revision; homepage
JavaScript, CRM files, shared styles, privacy page, and raster assets are unchanged.

- Before/after hero evidence: `artifacts/home-color-refresh/hero-before-after.png`.
- Focused module evidence: `artifacts/home-color-refresh/services-before-after.png`.
- Both comparisons were opened and inspected. Desktop captures use identical
  1440x900 CSS viewports at deviceScaleFactor 1. Element captures hide sticky UI
  only for the comparison image, not in the real page or interaction tests.
- Brand logo and body copy remain intact. The hero image has a modest CSS
  contrast/saturation adjustment, not an asset replacement or resolution upgrade.
- The CRM module is 630px high, down from 754px; the two adjacent service modules
  are 338px and 274px, down from 400px and 336px. Preview crop keeps the source
  screenshot intact, with a tested link to its complete original image.
- First contrast scan flagged small labels/caption on the new pale backgrounds.
  Text colors were darkened separately from action fills; post-fix desktop/mobile
  axe WCAG 2/2.1 A/AA scans report zero violations.
- Final regression run: eight viewport sizes, nine interaction checks, zero
  browser JavaScript errors or failed requests. Rechecked the full-image link.
- Phone, full-page, menu, disclosure, form, and chat screenshots under
  `artifacts/home-redesign/` were regenerated after the final changes.
- Preview remains local at http://127.0.0.1:4173/. No production action occurred.

## Design Target

The user approved a combination of editorial hierarchy, bento service modules,
and disclosure interactions, while retaining Northstar branding and real services.
The supplied images are catalogs of different design styles, not a same-content
website mockup. This is an adaptation of the selected direction, not a pixel clone.
The catalog's purple glass, collage imagery, and fictitious metrics were not copied.

## Evidence

All paths below are relative to `D:/SAAS/cn-nstarbiz/`.

- Source: `artifacts/home-redesign/reference-layouts.png`, 1186 x 915 pixels.
- Source: `artifacts/home-redesign/reference-editorial.png`, 1063 x 835 pixels.
- Local URL: http://127.0.0.1:4173/
- Desktop: `artifacts/home-redesign/home-1440.png`, 1440 x 900 pixels.
- Full desktop: `artifacts/home-redesign/home-1440-full.png`, 1440 x 4749 pixels.
- Mobile: `artifacts/home-redesign/home-390.png`, 390 x 844 pixels.
- Small mobile: `artifacts/home-redesign/home-320.png`, 320 x 640 pixels.
- Full-view art-direction comparison: `artifacts/home-redesign/reference-comparison.png`.
- Focused bento comparison: `artifacts/home-redesign/bento-comparison.png`.
- Focused product capture: `artifacts/home-redesign/bento-desktop.png`, 1224 x 1077 pixels.
- Contact and result: `artifacts/home-redesign/contact-mobile.png` and `contact-result-desktop.png`.
- Disclosure and menu: `artifacts/home-redesign/directions-desktop.png` and `mobile-menu.png`.
- Browser: local, isolated headless Microsoft Edge, authorized by the user.
- Captures use deviceScaleFactor 1; viewport CSS and screenshot pixels match.
- Composite boards scale sources proportionally to 620 pixels wide and desktop
  captures to 960 pixels wide. They compare art direction, not equal-content geometry.
- Default screenshots: initial scroll position, loaded images, closed menu and chat.

## Findings And Required Surfaces

No actionable P0/P1/P2 findings remain in the tested homepage scope.

- Typography: system Chinese font stack, fixed responsive heading sizes, zero
  letter spacing, one brand H1, and readable service headings. No clipped text
  or horizontal overflow at the eight tested viewport sizes.
- Layout: unframed full-width sections, 8px repeated offer modules, asymmetric
  desktop grid, and stacked mobile modules. The next service band remains visible
  in all tested first viewports. The diagram and interface remain image assets.
- Colors: white/light neutral surfaces, blue-green actions, blue CRM, mint
  software, charcoal AI, restrained gold branding, and muted ERP. Contrast was
  checked again with axe after the color revision.
- Assets: existing original logo, software/hardware scene, CRM demo screenshot,
  website illustration, equipment illustration, and enterprise WeChat QR retained.
  Lucide icons are local, unmodified library SVGs with their license. No runtime
  CDN, new font request, invented customers, or fabricated business metrics.
- Copy: enterprise and personal projects remain supported. ERP explicitly says
  coming soon; project directions are not presented as delivered customer cases.
  The form clearly distinguishes generating a summary from sending an enquiry.
- Motion/accessibility: native disclosures, visible focus, skip link, reduced-motion
  handling, labelled controls, and focus restoration for mobile navigation/chat.

## Comparison History

1. Initial automated layout check found an open disclosure icon extending its
   summary by 5px. Added rotation clearance and reran all layout checks.
2. Visual review found the small-mobile hero hid the next section and desktop
   media cropped device edges. Added viewport-constrained mobile height and
   reframed the scene. Final evidence: `home-320.png` and `home-1440.png`.
3. Contact review found the floating chat control covering mobile form content.
   Hide the duplicate launcher over contact/intro regions while preserving inline
   chat and focus restoration. Final evidence: `contact-mobile.png` and `home-390.png`.
4. Axe found low contrast in two service labels (4.45 and 4.27). Darkened their
   shared color and reran desktop/mobile scans: zero A/AA violations reported.
5. Post-fix full-view and bento comparison boards were opened together with the
   references, and final desktop/mobile region captures were inspected.

## Interaction And Regression Verification

- Eight viewports: 1440x900, 1920x1080, 1024x768, 800x1000, 768x1024,
  390x844, 375x667, and 320x640. No document/text overflow, missing images,
  broken in-page anchors, or header overlap.
- Nine functional checks: complete CRM screenshot, exclusive project disclosures, service-to-form
  selection, clipboard success with mailto generation and no POST, clipboard
  denial fallback, mobile menu including nested icon clicks, FAQ disclosure,
  floating chat, and contact chat with Escape/focus restoration.
- Chat frame requests were intercepted with a local fixture: no production
  enquiry was sent. Live CRM delivery was deliberately not exercised.
- Automated WCAG 2/2.1 A/AA scans at desktop/mobile report zero violations;
  keyboard skip-link and menu Escape focus were also checked. This is not a
  claim of a complete manual accessibility certification.
- Browser JavaScript errors: none. Failed requests in the local tests: none.
- Results: `artifacts/home-redesign/results.json` and `accessibility.json`.
- `crm/index.html`, `crm/styles.css`, `crm/main.js`, `privacy.html`, and the shared
  `styles.css` have the same SHA256 hashes as at this task's start. `main.js`
  was reused without changes. Homepage-only `home.css` and `home.js` isolate styles
  and new interactions from the CRM and privacy pages.
- Existing worktree changes were preserved. Previous homepage QA was copied to
  `artifacts/home-redesign/previous-design-qa.md` before replacing this report.

## Residual Scope

- Physical QR scanning, live email receipt, and live CRM enquiry delivery were
  not tested or changed. Browser coverage is Edge, not Safari or Firefox.
- The references describe multiple styles; exact catalog colors, imagery,
  typography, and component sizes are intentionally not reproduced.
- The local design-iteration observations above precede the production release.
  Only the static homepage release was published; CRM routes were not changed.

final result: passed
