(use-package whitespace
  :config
  (setq-default indent-tabs-mode nil)
  (setq whitespace-style '(tab-mark))
  (setq require-final-newline t)
  (global-whitespace-mode t)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  :diminish (whitespace-mode
             global-whitespace-mode))
