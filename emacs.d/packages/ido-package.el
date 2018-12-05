(use-package ido
  :config
  (ido-everywhere 1)
  (ido-mode 1)
  :init
  ;; disable ido faces to see flx highlights.
  (setq ido-use-faces nil))
