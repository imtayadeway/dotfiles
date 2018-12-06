(use-package wrap-region
  :config
  (wrap-region-global-mode t)
  (wrap-region-add-wrapper "/" "/" nil 'ruby-mode)
  (wrap-region-add-wrapper "`" "`" nil '(markdown-mode ruby-mode))
  :diminish)
