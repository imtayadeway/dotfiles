(use-package python
  :hook (python-mode . (lambda () (setq mode-name "🐍")))
  :init
  (setq python-indent 2))
