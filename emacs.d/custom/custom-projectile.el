;; use projectile everywhere
(projectile-global-mode)

(setq projectile-tags-command "ctags -Re -f \"%s\" --exclude=.git --exclude=tmp --exclude=log")

;; persp-projectile
(persp-mode)
(require 'persp-projectile)
(define-key projectile-mode-map (kbd "s-s") 'projectile-persp-switch-project)
