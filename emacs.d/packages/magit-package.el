(use-package magit
  :config
  (remove-hook 'magit-refs-sections-hook 'magit-insert-tags))
