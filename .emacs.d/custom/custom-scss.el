;; scss-mode
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(setq scss-compile-at-save nil)
(add-hook 'scss-mode-hook 'rainbow-mode)
