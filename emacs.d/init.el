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

;; use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(setq use-package-verbose t)
(setq use-package-always-ensure t)

(require 'use-package)

(use-package ace-window
  :init
  (setq aw-keys '(?a ?r ?s ?t ?d ?h ?n ?e ?i ?o)))

(use-package ag
  :init
  (setq ag-highlight-search t))

(use-package aggressive-indent
  :hook ((cider-mode emacs-lisp-mode lisp-mode) . aggressive-indent-mode))

(use-package alchemist)

(use-package avy
  :init
  (setq avy-keys '(?a ?r ?s ?t ?d ?h ?n ?e ?i ?o))
  (setq avy-style 'at-full)
  (setq avy-background t)
  (setq avy-all-windows nil))

(use-package bundler)

(use-package chruby
  :config
  (chruby "ruby-2.5.1"))

(use-package cider
  :hook clojure-mode
  :init
  (setq nrepl-hide-special-buffers t)
  :requires clojure)

(use-package clojure-mode)

(use-package coffee-mode
  :init
  (setq coffee-tab-width 2))

(use-package css-mode
  :init
  (setq css-indent-offset 2))

(use-package diminish)

(use-package dired
  :ensure nil
  :init
  (add-hook 'dired-mode-hook 'rspec-dired-mode)
  (setq-default dired-listing-switches "-lAhv --group-directories-first"))

(use-package eldoc
  :hook ((cider-mode emacs-lisp-mode lisp-mode) . eldoc-mode))

(use-package elixir-mode)

(use-package ember-mode)
(use-package evil)
(use-package exec-path-from-shell)
(use-package expand-region)
(use-package feature-mode)

(use-package flx-ido
  :config
  (flx-ido-mode 1))

(use-package flycheck)

(use-package flyspell
  :hook ((markdown-mode) . flyspell-mode))

(use-package git-timemachine)

(use-package go-mode
  :init
  (add-hook 'before-save-hook 'gofmt-before-save))

(use-package graphql-mode)

(use-package haml-mode
  :init
  (add-hook 'haml-mode-hook (lambda () (setq indent-tabs-mode nil)))
  (add-to-list 'auto-mode-alist '("\\.hamlc$" . haml-mode)))

(use-package ido
  :config
  (ido-everywhere 1)
  (ido-mode 1)
  :init
  ;; disable ido faces to see flx highlights.
  (setq ido-use-faces nil))

(use-package ido-vertical-mode
  :config
  (ido-vertical-mode 1))

(use-package inf-clojure)
(use-package inf-mongo)

(use-package inf-ruby
  :after ruby-mode)

(use-package js
  :init
  (setq js-indent-level 2))

(use-package json-mode)
(use-package kibit-helper)
(use-package less-css-mode)

(use-package lisp-mode
  :ensure nil)

(use-package lorem-ipsum)
(use-package magit)

(use-package markdown-mode
  :init
  (setq markdown-fontify-code-blocks-natively t)
  (add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode)))

(use-package minitest
  :init
  (setq minitest-use-zeus-when-possible nil)
  (setq minitest-keymap-prefix (kbd "C-c .")))

(use-package multi-term
  :bind (:map term-raw-map
              ("M-o" . other-window)
              ("C-y" . term-paste))
  :init
  (setq multi-term-program "/bin/bash")
  (setq multi-term-program-switches "--login")
  (setq yas-dont-activate t)
  (add-hook 'term-exec-hook
            (function
             (lambda ()
               (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix)))))

(use-package paredit
  :hook ((cider-mode emacs-lisp-mode lisp-mode) . paredit-mode))

(use-package perspective
  :config
  (persp-mode))

(use-package persp-projectile
  :bind (:map projectile-mode-map
              ("s-s" . projectile-persp-switch-project)))

(use-package projectile
  :config
  (projectile-global-mode)
  (require 'persp-projectile)
  :hook projectile-rails-on
  :init
  (setq projectile-tags-command "ctags-exuberant -Re -f \"%s\" --languages=-javascript --exclude=.git --exclude=tmp --exclude=log"))

(use-package projectile-rails)

(use-package python
  :hook yas-minor-mode
  :init
  (setq python-indent 2))

(use-package rainbow-delimiters
  :hook ((cider-mode emacs-lisp-mode lisp-mode) . rainbow-delimiters-mode))

(use-package rainbow-mode
  :hook ((css-mode haml-mode scss-mode web-mode) . rainbow-mode))

(use-package rake)
(use-package restclient)

(use-package rspec-mode
  :init
  (setq rspec-use-rake-when-possible nil)
  (setq rspec-use-opts-file-when-available nil)
  (setq rspec-use-zeus-when-possible nil)
  (setq rspec-use-spring-when-possible nil)
  (setq rspec-command-options "--format progress"))

(use-package rubocop)
(use-package ruby-end)
(use-package ruby-hash-syntax)

(use-package ruby-mode
  :mode ("\\.rake$"
         "\\.gemspec$"
         "\\Capfile$"
         "\\Gemfile$"
         "\\Guardfile$"
         "\\Rakefile$")
  :bind (:map ruby-mode-map ("C-c C-c" . xmp))
  :init
  (add-hook 'ruby-mode-hook
            (lambda ()
              (setq ruby-insert-encoding-magic-comment nil)
              (yas-minor-mode)
              (ruby-end-mode)
              (flycheck-mode)
              (rubocop-mode)
              (projectile-rails-on)
              (global-set-key (kbd "C-c h") 'ruby-toggle-hash-syntax)
              (local-set-key "\r" 'newline-and-indent)
              (define-key ruby-mode-map (kbd "C-c C-c") 'xmp)))
  :requires rcodetools)

(use-package rust-mode)
(use-package sass-mode)

(use-package scss-mode
  :mode "\\.scss\\'"
  :init
  (setq scss-compile-at-save nil))

(use-package smex)
(use-package toggle-quotes)
(use-package typescript-mode)
(use-package undo-tree)

(use-package web-mode
  :hook rspec-mode
  :init
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  :mode ("\\.erb$" "\\.html$\\'" "\\.rhtml$\\'" "\\.hbs$"))

(use-package wrap-region)
(use-package writegood-mode)

(use-package yaml-mode
  :mode "\\.yml$")

(use-package yasnippet)

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
  (sleep-for 0.1)
  (org-agenda nil "a")
  (delete-other-windows)
  (switch-to-buffer "*mu4e-main*")
  (split-window-horizontally)
  (other-window 1)
  (switch-to-buffer "*Org Agenda*")
  (other-window 1)
  (mu4e))
