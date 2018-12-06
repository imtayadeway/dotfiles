(use-package paredit
  :diminish
  :hook ((cider-mode emacs-lisp-mode lisp-mode) . paredit-mode))
