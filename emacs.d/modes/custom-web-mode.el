(setq web-mode-code-indent-offset 2)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(add-to-list 'auto-mode-alist '("\\.erb$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html$\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.rhtml$\\'" . web-mode))

(add-hook 'web-mode-hook 'rainbow-mode)
(add-hook 'web-mode-hook 'rspec-mode)