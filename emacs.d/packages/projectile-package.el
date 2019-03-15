(use-package projectile
  :config
  (projectile-global-mode)
  (require 'persp-projectile)
  :diminish
  :init
  (setq projectile-tags-command "ctags-exuberant -Re -f \"%s\" --languages=-javascript --exclude=.git --exclude=tmp --exclude=log")
  (setq projectile-enable-caching t))
