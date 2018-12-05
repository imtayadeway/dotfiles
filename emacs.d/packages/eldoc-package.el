(use-package eldoc
  :diminish
  :hook ((cider-mode emacs-lisp-mode lisp-mode) . eldoc-mode))
