(use-package whitespace
  :config
  (setq-default indent-tabs-mode nil)
  (setq whitespace-style '(face empty tabs lines-tail trailing))
  (setq require-final-newline t)
  (setq whitespace-line-column 80)
  (global-whitespace-mode t)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  :diminish (whitespace-mode
             global-whitespace-mode))
