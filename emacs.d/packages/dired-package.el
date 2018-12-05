(use-package dired
  :ensure nil
  :init
  (add-hook 'dired-mode-hook 'rspec-dired-mode)
  (setq-default dired-listing-switches "-lAhv --group-directories-first"))
