;; Minimal, reproducible Org Publish setup for "solderandsignal"
;; Usage (from repo root): emacs -Q --batch -l publish.el --eval "(org-publish-all t)"
(require 'ox-publish)

(setq org-export-with-sub-superscripts '{})

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
