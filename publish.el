;; Minimal, reproducible Org Publish setup for "solderandsignal"
;; Usage (from repo root): emacs -Q --batch -l publish.el --eval "(org-publish-all t)"
(require 'ox-publish)

(setq org-export-with-sub-superscripts '{})
;; 1) Prefer relative file paths in links (prevents file:///)
(setq org-link-file-path-type 'relative)
(setq org-html-link-use-abs-url nil)

(defvar s&s-site-prefix (or (getenv "SITE_PREFIX") "")
  "Prefix for absolute asset links. \"\" for custom domain, \"/solderandsignal\" for project pages.")

(defun s&s-rewrite-asset-uris (html backend info)
  "Rewrite file:///assets/* to proper web paths, with optional prefix."
  (let* ((re-file-src "src=\\\"file:///assets/")
         (re-file-href "href=\\\"file:///assets/")
         (re-web-src  (format "src=\\\"%s/assets/" s&s-site-prefix))
         (re-web-href (format "href=\\\"%s/assets/" s&s-site-prefix)))
    (setq html (replace-regexp-in-string re-file-src  re-web-src  html))
    (setq html (replace-regexp-in-string re-file-href re-web-href html))
    html))

(add-to-list 'org-export-filter-final-output-functions #'s&s-rewrite-asset-uris)

(setq org-publish-project-alist
      '(("solderandsignal-org"
         :base-directory "./content"
         :publishing-directory "./docs"
         :recursive t
         :with-author nil
         :with-creator nil
         :with-date t
         :with-toc t
         :section-numbers t
         :time-stamp-file nil
         :html-doctype "html5"
         :html-html5-fancy t
         :html-head "<link rel=\"stylesheet\" href=\"/assets/css/lab.css\"/>"
         :html-head-include-default-style nil
         :html-head-include-scripts nil
         :auto-sitemap t
         :sitemap-filename "sitemap.org"
         :sitemap-title "Solder & Signal"
         :sitemap-sort-files anti-chronologically)
        ("solderandsignal-static"
         :base-directory "./static"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|svg\\|ico\\|mp3\\|mp4\\|pdf"
         :publishing-directory "./docs/assets"
         :recursive t
         :publishing-function org-publish-attachment)
        ("solderandsignal" :components ("solderandsignal-org" "solderandsignal-static"))))
