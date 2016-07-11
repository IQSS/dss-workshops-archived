(require 'ess-site)
  (set (make-local-variable 'org-babel-stata-command) "stata -q")
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
  
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)

;; present all output in blocks
(set (make-local-variable 'org-babel-min-lines-for-block-output) 0)

;; do not re-evaluate source code on export
(setq-local org-babel-default-header-args
      (cons '(:eval . "never-export")
            (assq-delete-all :noweb org-babel-default-header-args)))

;; add license note at the bottom of the page
(setq-local org-html-postamble
            "<p><span xmlns:dct='http://purl.org/dc/terms/' property='dct:title'> These workshop notes </span> by <a xmlns:cc='http://creativecommons.org/ns#' href='http://dss.iq.harvard.edu' property='cc:attributionName' rel='cc:attributionURL'>Harvard University</a> are licensed <a rel='license' href='http://creativecommons.org/licenses/by-sa/4.0/'><img alt='Creative Commons License' style='border-width:0' src='https://i.creativecommons.org/l/by-sa/4.0/80x15.png' /></a>. Presented by <a href='http://dss.iq.harvard.edu'>Data Science Services</a> at <a href='http://iq.harvard.edu'> IQSS</a></p>")

;; no section numbers
(setq-local org-export-with-section-numbers nil)
