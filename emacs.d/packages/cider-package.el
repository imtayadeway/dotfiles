(use-package cider
  :hook clojure-mode
  :init
  (setq nrepl-hide-special-buffers t)
  :requires clojure)
