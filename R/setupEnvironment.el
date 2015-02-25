;; make R save and restore instead of using sessions; this gives the input and output as displayed by the R console
(setq-local org-babel-R-command "R --silent --save --restore")

;; don't let orgmode resize images (this means you must set them to the correct size when generating!)
(setq-local org-latex-image-default-option "")

;; add next button at the bottom of the page
(setq-local org-confirm-babel-evaluate nil)
(setq-local org-html-postamble "<p><button onclick=\"clickNextTab()\">Next</button></p>")

;; present all output in blocks
(setq-local org-babel-min-lines-for-block-output 0)

;; do not re-evaluate source code on export
(set (make-local-variable 'org-export-babel-evaluate) nil)

;; enable source code support in orgmode
(org-babel-do-load-languages
 'org-babel-load-languages
 '(;(stata . t) ;; requires custom ob-stata.el
   (emacs-lisp . t)
   (sh . t)
   (R . t)
   (latex . t)
   (octave . t)
   (ditaa . t)
   (org . t)
   (perl . t)
   (python . t)
   (matlab . t)))

;; display images in the orgmode buffer automatically
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)

;; convenience function to export headings to markdown chapters for upload to datacamp
(defun my-exp-to-datacamp (course)
  "Export org mode file to form suitable for upload to datacamp.org."
  (interactive "sEnter course name: ")
  ;; make datacamp directory if it doesn't exist
  (if (file-directory-p "datacamp") nil (make-directory "datacamp"))
  ;; demarcate code blocks on markdown export (needed for datacamp)
  (defun my-md-src-block-replace (text backend info)
    (when (org-export-derived-backend-p backend 'md)
      (concat "```{r eval = FALSE}\n" text "```\n")))
  (add-to-list 'org-export-filter-src-block-functions
	       'my-md-src-block-replace)
  ;; include html comments
  (defun my-md-keyword-replace (text backend info)
    (when (org-export-derived-backend-p backend 'md)
      (replace-regexp-in-string
       "\\(<!-- MD: \\)\\(.*\\)\\(-->\\)"
       "\\2" text nil nil)))
  (make-local-variable 'org-export-filter-keyword-functions)
  (add-to-list 'org-export-filter-keyword-functions
               'my-md-keyword-replace)
  ;; export headings to separate files
  (org-map-entries
   (lambda ()
     ;; some magic I don't understand written by John Kitchin on the orgmode mailing list
     (let ((level (nth 1 (org-heading-components)))
           (title (nth 4 (org-heading-components))))
       (when (= level 1)
	 ;; add meta data to top of each exported file
	 (defun my-md-filter-add-meta-data (text backend info)
	   "Ensure \" \" are properly handled in Md export."
	   (when (org-export-derived-backend-p backend 'md)
	     (concat 
"--- 
courseTitle       : " course "
chapterTitle      : " title "
description       : 
framework         : datamind
mode              : selfcontained
---

" text)))
	 (add-to-list 'org-export-filter-final-output-functions
		      'my-md-filter-add-meta-data)
	 ;; set up export file names and turn of table of contents 
         (org-entry-put (point) "EXPORT_FILE_NAME" (concat "datacamp/" title))
	 (org-entry-put (point) "EXPORT_OPTIONS" "num:nil toc:nil")
	 ;; export each heading
         (org-md-export-to-markdown nil 1 nil)
	 ;; rename files with .Rmd extension
	 (rename-file (concat "datacamp/" title ".md") (concat "datacamp/" title ".Rmd") t)))))
  ;; remove changed settings
  (setq org-export-filter-final-output-functions (delete 'my-md-filter-add-meta-data org-export-filter-final-output-functions))
  (setq org-export-filter-src-block-functions (delete 'my-md-src-block-replace org-export-filter-src-block-functions))
  (setq org-export-filter-keyword-functions (delete 'my-md-keyword-replace org-export-filter-keyword-functions))
  nil nil)
