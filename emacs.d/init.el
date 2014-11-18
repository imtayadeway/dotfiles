;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; full screen
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

;; welcome screen
(setq inhibit-startup-message t)

;; don't use dialogs
(setq use-dialog-box nil)

;; windows
(windmove-default-keybindings)
(winner-mode 1)

;; put autosaves in temp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Also auto refresh dired, but be quiet about it
;; (setq global-auto-revert-non-file-buffers t)
;; (setq auto-revert-verbose nil)

;; pallet
(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/custom")

(setq exec-path (append exec-path '("/usr/local/bin")))

(require 'multi-term)

;; allow 20MB of memory (instead of 0.76MB) before calling GC
(setq gc-cons-threshold 20000000)

;; treat camelcase as separate words
(add-hook 'prog-mode-hook 'subword-mode)

;; mode-specific configuration
(mapcar (lambda (mode-file-name) (load mode-file-name))
        (directory-files "~/.emacs.d/custom/" nil ".el"))

(delete-selection-mode t)

;; color-theme and choco
(add-to-list 'load-path "~/.emacs.d/themes/choco")
(require 'color-theme)
(require 'color-theme-choco)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-choco)))

;; whitespace
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq-default indent-tabs-mode nil)
(setq require-final-newline t)

;; snippets
(setq yas-snippet-dirs '("~/.emacs.d/snippets/text-mode"))
(yas-global-mode 1)

;; use projectile everywhere
(projectile-global-mode)

;; wrap region
(wrap-region-global-mode t)
(wrap-region-add-wrapper "/" "/" nil 'ruby-mode)
(wrap-region-add-wrapper "`" "`" nil '(markdown-mode ruby-mode))

;; pair character completion
(electric-pair-mode 1)

;; show matching parens
(show-paren-mode 1)

;; line numbers
(global-linum-mode 1)

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

;; (add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
;; (require 'mu4e)

(setq confirm-kill-emacs 'y-or-n-p)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
