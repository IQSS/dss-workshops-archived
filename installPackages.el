; -*- eval: (load-file (buffer-file-name)) -*-

(message "%s" "Please wait wile we check for required packages...")

;; install required emacs packages if not already installed
(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

; list the packages you want
(setq package-list '(ess htmlize markdown-mode org-plus-contrib exec-path-from-shell))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available 
(when (not package-archive-contents)
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

; activate all the packages (in particular autoloads)
(package-initialize)

;; fix path on mac
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(message "%s" "Done, your system meets the requirements.")
