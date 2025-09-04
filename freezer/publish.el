;;; publish.el --- Org → GitHub Pages for Solder & Signal  -*- lexical-binding: t; -*-
;; Usage:
;;   Custom domain (solderandsignal.com):
;;     SITE_PREFIX= LABCSS_VER=$(git rev-parse --short HEAD) emacs -Q --batch -l publish.el --eval "(org-publish-all t)"
;;   Project pages (billwear.github.io/solderandsignal):
;;     SITE_PREFIX=/solderandsignal LABCSS_VER=$(git rev-parse --short HEAD) emacs -Q --batch -l publish.el --eval "(org-publish-all t)"

(require 'ox-publish)

;; Don’t generate absolute file:// URLs; prefer relative file links in HTML.
(setq org-link-file-path-type 'relative)
(setq org-html-link-use-abs-url nil)
(setq org-html-validation-link nil)

;; Configurable site prefix:
;;  - ""                 when served at domain root (custom domain)
;;  - "/solderandsignal" when served under repo path (project pages)
(defvar s2s-site-prefix (or (getenv "SITE_PREFIX") "")
  "Prefix for absolute asset links. \"\" for custom domain, \"/solderandsignal\" for project pages.")

;; Cache-busting for CSS (optional; set from env or fallback to timestamp)
(defvar s2s-css-version (or (getenv "LABCSS_VER") (format-time-string "%Y%m%d%H%M%S"))
  "Version token appended to CSS link for cache busting.")

;; Build the CSS <link> once and reuse.
(defvar s2s-labcss
  (format "<link rel=\"stylesheet\" href=\"%s/assets/css/lab.css?v=%s\"/>"
          s2s-site-prefix s2s-css-version))

;; Export filter to normalize asset URIs:
;; - Rewrite any file:///assets/* to web paths
;; - Add SITE_PREFIX to leading /assets/* so project pages work
;; Replace your filter with this
(defun s2s-rewrite-asset-uris (html _backend _info)
  "Normalize asset links in final HTML."
  (let* ((p s2s-site-prefix)
         (src-file  "src=\"file:///assets/")
         (href-file "href=\"file:///assets/")
         (src-abs   "src=\"/assets/")
         (href-abs  "href=\"/assets/")
         (src-web   (format "src=\"%s/assets/"  p))
         (href-web  (format "href=\"%s/assets/" p)))
    ;; LITERAL = t avoids backref interpretation in replacements
    (setq html (replace-regexp-in-string src-file  src-web  html nil t))
    (setq html (replace-regexp-in-string href-file href-web html nil t))
    (setq html (replace-regexp-in-string src-abs   src-web  html nil t))
    (setq html (replace-regexp-in-string href-abs  href-web html nil t))
    html))
(add-to-list 'org-export-filter-final-output-functions #'s2s-rewrite-asset-uris)

;; Projects
(setq org-publish-project-alist
      `(
        ;; 1) Org → HTML
        ("solderandsignal-org"
         :base-directory "./content"
         :publishing-directory "./docs"
         :recursive t
         :time-stamp-file nil
         :with-author nil
         :with-creator nil
         :with-date t
         :section-numbers t
         :with-toc t
         :html-doctype "html5"
         :html-html5-fancy t
         :html-head "<meta charset=\"utf-8\">"
         :html-head-include-default-style nil
         :html-head-include-scripts nil
         :html-head-extra ,s2s-labcss
         :auto-sitemap t
         :sitemap-filename "sitemap.org"
         :sitemap-title "Solder & Signal"
         :sitemap-sort-files anti-chronologically)

        ;; 2) Static assets → docs/assets
        ("solderandsignal-static"
         :base-directory "./static"
         :base-extension "css\\|js\\|png\\|jpg\\|jpeg\\|gif\\|svg\\|ico\\|mp3\\|mp4\\|pdf"
         :publishing-directory "./docs/assets"
         :recursive t
         :publishing-function org-publish-attachment)

        ;; 3) Meta project
        ("solderandsignal"
         :components ("solderandsignal-org" "solderandsignal-static"))
        ))

(provide 'publish)
;;; publish.el ends here
