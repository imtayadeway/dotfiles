(setq lispy-mode-hooks
      '(clojure-mode-hook
        emacs-lisp-mode-hook
        lisp-mode-hook))

(dolist (hook lispy-mode-hooks)
  (add-hook hook (lambda ()
                   (paredit-mode)
                   (aggressive-indent-mode)
                   (eldoc-mode)
                   (rainbow-delimiters-mode))))
