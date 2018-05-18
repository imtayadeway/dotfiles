(package-initialize)

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (typescript-mode irfc graphql-mode yasnippet yaml-mode writegood-mode wrap-region web-mode toggle-quotes smex scss-mode sass-mode rust-mode ruby-hash-syntax ruby-end ruby-compilation rubocop rspec-mode rhtml-mode restclient rainbow-mode rainbow-delimiters projectile-rails persp-projectile paredit pallet multi-term minitest markdown-mode lorem-ipsum less-css-mode kibit-helper jump json-mode inf-mongo inf-clojure ido-vertical-mode gitignore-mode gitconfig-mode git-timemachine flycheck flx-ido feature-mode expand-region exec-path-from-shell evil ember-mode diminish color-theme coffee-mode cider chruby bundler alchemist aggressive-indent ag ace-window))))
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

;; keys
(setq x-alt-keysym 'meta)

;; windows
(winner-mode 1)

;; put autosaves in temp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Auto refresh buffers
(global-auto-revert-mode 1)

;; pallet
(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/modes")

;; exec path
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
(setq exec-path (append exec-path '("/usr/local/bin" "/usr/local/go/bin")))

(require 'multi-term)
(require 'mu4e)
(require 'evil)

;; allow 20MB of memory (instead of 0.76MB) before calling GC
(setq gc-cons-threshold 20000000)

;; increase undo limit
(setq undo-limit 3600)

;; tab-width
(setq default-tab-width 4)

;; treat camelcase as separate words
(add-hook 'prog-mode-hook 'subword-mode)

;; mode-specific configuration
(mapcar (lambda (mode-file-name) (load mode-file-name))
        (directory-files "~/.emacs.d/modes/" nil ".el"))

(delete-selection-mode t)

;; color-theme and choco
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'choco t)

;; whitespace
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq-default indent-tabs-mode nil)
(setq require-final-newline t)
(setq whitespace-line-column 120)

;; snippets
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(yas-global-mode 1)

;; wrap region
(wrap-region-global-mode t)
(wrap-region-add-wrapper "/" "/" nil 'ruby-mode)
(wrap-region-add-wrapper "`" "`" nil '(markdown-mode ruby-mode))

;; pair character completion
(electric-pair-mode 1)

;; show matching parens
(show-paren-mode 1)

;; ido
(require 'flx-ido)
(ido-mode 1)
(ido-vertical-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-use-faces nil) ;; disable ido faces to see flx highlights.

(load "utils.el")
(load "keybindings.el")
(load "hide-modes.el")

(setq confirm-kill-emacs 'y-or-n-p)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; inf-ruby
(add-hook 'after-init-hook 'inf-ruby-switch-setup) ;; for using pry in rspec mode

;; compilation mode
;; prevent comilation buffers paging with less
(setenv "PAGER" "cat")

;; set up windows in main perspective
(progn
  (interactive)
  (mu4e)
  (org-agenda nil "a")
  (delete-other-windows)
  (switch-to-buffer "*mu4e-main*")
  (split-window-horizontally)
  (other-window 1)
  (switch-to-buffer "*Org Agenda*")
  (other-window 1)
  (mu4e))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
