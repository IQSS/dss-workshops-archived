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
