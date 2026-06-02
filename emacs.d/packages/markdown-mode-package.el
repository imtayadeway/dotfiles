(use-package markdown-mode
  :diminish "M⬇️"
  :init
  (setq markdown-fontify-code-blocks-natively t)
  :config
  (add-hook 'before-save-hook 'tw/fix-quotation-marks)
  :mode "\\.md$")
