(package-initialize)

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; hack for toggling fullscreen after init
(run-with-idle-timer 0.1 nil 'toggle-frame-fullscreen)

;; welcome screen
(setq inhibit-startup-message t)

;; don't use dialogs
(setq use-dialog-box nil)

;; yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; fonts
(when (member "Symbola" (font-family-list))
  (set-fontset-font t 'unicode "Symbola" nil 'prepend))

;; split windows
(setq split-height-threshold nil)
(setq split-width-threshold 160)

;; keys
(setq x-alt-keysym 'meta)

;; put autosaves in temp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Auto refresh buffers
(global-auto-revert-mode 1)

;; package.el
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))
(unless (assoc-default "org" package-archives)
  (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t))

;; use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(setq use-package-verbose t)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/packages")
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e/")

(require 'use-package)

(mapcar (lambda (mode-file-name) (load mode-file-name))
        (directory-files "~/.emacs.d/packages/" nil ".el"))

;; exec path
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
(setq exec-path (append exec-path '("/usr/local/bin" "/usr/local/go/bin")))

;; allow 20MB of memory (instead of 0.76MB) before calling GC
(setq gc-cons-threshold 20000000)

;; increase undo limit
(setq undo-limit 3600)

;; tab-width
(setq default-tab-width 4)

;; treat camelcase as separate words
(add-hook 'prog-mode-hook 'subword-mode)

(delete-selection-mode t)

;; color-themes and choco
(use-package solarized-theme)
(use-package zenburn-theme)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(if (display-graphic-p)
    (progn
      (load-theme 'choco t))
  (load-theme 'zenburn t))

;; pair character completion
(electric-pair-mode 1)

;; show matching parens
(show-paren-mode 1)

(load "utils.el")
(load "keybindings.el")
(load "hide-modes.el")

(setq confirm-kill-emacs 'y-or-n-p)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; inf-ruby
(add-hook 'after-init-hook 'inf-ruby-switch-setup) ;; for using pry in rspec mode

;; compilation mode
;; prevent comilation buffers paging with less
(setenv "PAGER" "cat")

;; set up windows in main perspective
(progn
  (interactive)
  (mu4e)
  (sleep-for 0.1)
  (org-agenda nil "a")
  (delete-other-windows)
  (switch-to-buffer "*mu4e-main*")
  (split-window-horizontally)
  (other-window 1)
  (switch-to-buffer "*Org Agenda*")
  (other-window 1)
  (mu4e))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(with-editor zenburn-theme yasnippet yaml-mode writegood-mode wrap-region web-mode use-package undo-tree typescript-mode toggle-quotes solarized-theme smex scss-mode sass-mode rust-mode ruby-hash-syntax ruby-end rubocop rspec-mode restclient rainbow-mode rainbow-delimiters projectile-rails persp-projectile paredit multi-term minitest markdown-mode magit lorem-ipsum kibit-helper json-mode inf-mongo inf-clojure ido-vertical-mode graphql-mode go-mode git-timemachine flycheck flx-ido feature-mode expand-region exec-path-from-shell ember-mode diminish coffee-mode cider chruby bundler alchemist aggressive-indent ag ace-window))
 '(warning-suppress-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
