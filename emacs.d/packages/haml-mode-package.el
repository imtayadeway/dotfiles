(use-package haml-mode
  :init
  (add-hook 'haml-mode-hook (lambda () (setq indent-tabs-mode nil)))
  (add-to-list 'auto-mode-alist '("\\.hamlc$" . haml-mode)))
