  (set (make-local-variable 'org-babel-stata-command) "stata -q")

  (set (make-local-variable 'org-latex-listings) 'minted)
  (set (make-local-variable 'org-latex-minted-options) '(("fontsize" "\\footnotesize")))
  (set (make-local-variable 'org-latex-pdf-process) '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f" 
                                "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
  (set (make-local-variable 'LaTeX-command) "pdflatex -shell-escape")
  (set (make-local-variable 'org-latex-image-default-option) "")
  (set (make-local-variable 'org-babel-min-lines-for-block-output) 0)
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

  (add-to-list 'org-latex-minted-langs '(stata "c"))
  
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
  
  (defun my-latex-fixed-width-start (fixed-width backend info)
    (when (org-export-derived-backend-p backend 'latex)
      (replace-regexp-in-string
       "\\(begin{verbatim\\)}"
       "vspace{-.5em}
  \\\\begin{columns}
  \\\\column{.95\\\\linewidth}
  \\\\begin{block}{}
  \\\\begin{minted}[linenos=false, fontsize=\\\\footnotesize]{c" fixed-width nil nil 1)))
  
  (defun my-latex-fixed-width-end (fixed-width backend info)
    (when (org-export-derived-backend-p backend 'latex)
      (replace-regexp-in-string
       "\\(end\\){\\(verbatim\\)}"
       "minted}
  \\\\end{block}
  \\\\end{columns}
  \\\\vspace{.5em" fixed-width nil nil 2)))
  
  (make-local-variable 'org-export-filter-final-output-functions)
  
  (add-to-list 'org-export-filter-final-output-functions
               'my-latex-fixed-width-start)
  (add-to-list 'org-export-filter-final-output-functions
               'my-latex-fixed-width-end)
