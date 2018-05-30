;; use projectile everywhere
(projectile-global-mode)

(setq projectile-tags-command "ctags-exuberant -Re -f \"%s\" --languages=-javascript --exclude=.git --exclude=tmp --exclude=log")

;; persp-projectile
(persp-mode)
(require 'persp-projectile)
(define-key projectile-mode-map (kbd "s-s") 'projectile-persp-switch-project)

;; use projectile-rails if it's a rails project
(add-hook 'projectile-mode-hook 'projectile-rails-on)
