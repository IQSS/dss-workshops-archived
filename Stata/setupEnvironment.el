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
(set (make-local-variable 'org-export-babel-evaluate) nil)

;; add license note at the bottom of the page
(setq-local org-html-postamble
            "<p><a rel='license' href='http://creativecommons.org/licenses/by-sa/4.0/'><img alt='Creative Commons License' style='border-width:0' src='https://i.creativecommons.org/l/by-sa/4.0/80x15.png' /></a><span xmlns:dct='http://purl.org/dc/terms/' property='dct:title'> These statistical software workshop materials</span> by <a xmlns:cc='http://creativecommons.org/ns#' href='http://dss.iq.harvard.edu' property='cc:attributionName' rel='cc:attributionURL'>Harvard University</a> are licensed under a <a rel='license' href='http://creativecommons.org/licenses/by-sa/4.0/'>Creative Commons Attribution-ShareAlike 4.0 International License</a>.</p> <p> Presented by <a href='http://dss.iq.harvard.edu'>Data Science Services</a> at <br></br> <a href='http://iq.harvard.edu'><img style='margin-left: auto; margin-right: auto;' alt='The Institute for Quantitative Social Science' title='IQSS logo' src='http://static.projects.iq.harvard.edu/files/styles/os_files_small/public/rtc/files/iqsslogo-2014_0.png'></img></a></p>")

;; no section numbers
(setq-local org-export-with-section-numbers nil)
