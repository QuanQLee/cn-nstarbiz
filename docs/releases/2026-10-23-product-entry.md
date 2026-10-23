# Product Entry Release - 2026-10-23

## Published Scope

- Production: https://cn.nstarbiz.com/#product-entry.
- Release: `site-20261023-homepage-r1`.
- Website root: `/opt/nstarbiz-site/current`.
- Current target: `/opt/nstarbiz-site/releases/site-20261023-homepage-r1`.
- Previous target: `/opt/nstarbiz-site/releases/site-20261020-homepage-r1`.
- Private backup: `/opt/nstarbiz-site/backups/site-20261023-homepage-r1-previous.tar.gz`.
- Homepage SHA256: `3948591ccc6ec438548aad67ed28b2378940d63a7c4eac305df8ff94e7708c47`.

The homepage now has an explicit product-entry section linked from the primary
navigation. CRM links to its homepage introduction and merchant login at
`https://crm.cn.nstarbiz.com/login.html`. ERP remains an upcoming product, with
a link to its plan and no inactive or placeholder login link. AI and custom
development remain service offerings, not open product portals.

Public changes are limited to `index.html`, `home.css`, and the homepage lastmod
in `sitemap.xml`. Other static resources were preserved. The local CRM marketing
draft, production CRM/ERP services, and Nginx configuration are outside this release.

## Verification

- Preflight: all 48 existing public files matched the previous release archive.
- Local: eight viewports and eleven interaction checks passed without JavaScript
  errors or failed requests. Automated desktop/mobile axe scans reported zero
  WCAG 2/2.1 A/AA violations in their tested scope.
- CRM application and Nginx file hashes match this release's preflight baseline.
  No business-system files or routing configuration were deployed.
- Production: all 48 public file responses matched local SHA256 values, including
  robots, sitemap, and the unchanged Baidu verification file.
- Desktop 1440x900 and mobile 390x844 entry screenshots were opened and inspected.
  Navigation, product-introduction anchors, and the ERP plan link passed without
  horizontal overflow or homepage JavaScript/console errors.
- An actual mobile click reached the existing CRM login and its visible password
  field. The existing `/crm/` sales platform and real chat form also loaded.
  HTTP returns 301 to HTTPS. No credentials, chat message, or email were submitted.
- The full-page test harness initially used an ambiguous password selector and
  waited for the login page's full load event. The selectors and readiness
  condition were corrected; focused follow-up verification passed. The earlier
  diagnostic output is retained locally rather than discarded.

Production resource/layout evidence is in `live-results.json` and the entry PNGs;
the successful focused flow report is `crm-inspection.json` in the evidence folder.
Actual account authentication and recipient delivery remain outside this check.

Evidence is stored locally in ignored `artifacts/deployment-20261023/`, with upload
checksums under `artifacts/site-20261023-homepage-r1/`. These are not public files.

## Rollback

On the server, restore the preserved previous release atomically:

```sh
test -d /opt/nstarbiz-site/releases/site-20261020-homepage-r1
ln -s /opt/nstarbiz-site/releases/site-20261020-homepage-r1 /opt/nstarbiz-site/.rollback-20261023-homepage-r1
mv -Tf /opt/nstarbiz-site/.rollback-20261023-homepage-r1 /opt/nstarbiz-site/current
```

The temporary rollback link must not already exist. No directory deletion or
Nginx reload is required.
