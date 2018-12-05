(use-package go-mode
  :init
  (add-hook 'before-save-hook 'gofmt-before-save))
