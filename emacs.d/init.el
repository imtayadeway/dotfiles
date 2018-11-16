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
  (chruby "ruby-2.5.3"))

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
  :diminish
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

(use-package flycheck
  :init
  (add-hook 'ruby-mode-hook 'flycheck-mode)
  :diminish)

(use-package flyspell
  :diminish
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
(use-package magit
  :config
  (remove-hook 'magit-refs-sections-hook 'magit-insert-tags))

(use-package markdown-mode
  :init
  (setq markdown-fontify-code-blocks-natively t)
  :mode "\\.md$")

(use-package minitest
  :init
  (setq minitest-use-zeus-when-possible nil)
  (setq minitest-keymap-prefix (kbd "C-c .")))

(use-package mu4e
  :config
  (require 'smtpmail)
  (setq mu4e-mu-binary "/usr/local/bin/mu")
  (setq mu4e-maildir "~/mail")
  (setq mu4e-attachment-dir "~/Desktop")
  (setq mu4e-view-show-images t)
  (setq mu4e-get-mail-command "offlineimap")
  (setq mu4e-update-interval 300)

  ;; use imagemagick, if available
  (when (fboundp 'imagemagick-register-types)
    (imagemagick-register-types))

  (setq message-send-mail-function 'smtpmail-send-it
        smtpmail-auth-credentials (expand-file-name "~/.authinfo.gpg")
        smtpmail-debug-info t)

  (setq auth-sources '("~/.authinfo.gpg"))

  (setq mu4e-contexts
        `(,(make-mu4e-context
            :name "Personal"
            :enter-func (lambda () (mu4e-message "Entering Personal context"))
            :leave-func (lambda () (mu4e-message "Leaving Personal context"))
            :match-func (lambda (msg)
                          (when msg
                            (string-prefix-p "/personal" (mu4e-message-field msg :maildir))))
            :vars '( ( user-mail-address      . "hello@timjwade.com"  )
                     ( user-full-name         . "Tim Wade" )
                     ( mu4e-compose-signature . nil)
                     ( mu4e-sent-folder       . "/personal/INBOX.Sent")
                     ( mu4e-drafts-folder     . "/personal/INBOX.Drafts")
                     ( mu4e-trash-folder      . "/personal/INBOX.Trash")
                     ( mu4e-refile-folder     . "/personal/INBOX.Archive")
                     ( smtpmail-smtp-server   . "smtp.fastmail.com")
                     ( smtpmail-smtp-service  . 465)
                     ( smtpmail-stream-type   . ssl)))))

  (setq mu4e-context-policy 'pick-first)

  ;; Refile will set mail to All Mail (basically archiving them). I want this to
  ;; auto-mark them as read, so I redefine refile to remove the u flag.
  (setq mu4e-marks (assq-delete-all 'refile mu4e-marks))
  (push '(refile :char ("r" . "▶")
                 :prompt "refile"
                 :dyn-target (lambda (target msg) (mu4e-get-refile-folder msg))
                 :action
                 (lambda (docid msg target)
                   (mu4e~proc-move docid (mu4e~mark-check-target target) "-u-N")))
        mu4e-marks)
  :ensure nil)

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

(use-package org
  :init
  (setq org-directory "~/org")
  (setq notes-directory "~/notes")

  (defun construct-filename (directory filename)
    (concat (file-name-as-directory directory) filename))

  (add-hook 'org-mode-hook
            (lambda ()
              (flyspell-mode)
              (local-set-key (kbd "C-x s")
                             'org-insert-src-block)
              (local-set-key (kbd "C-c v")
                             'org-show-todo-tree)))

  (defun org-file-path (filename)
    "Return the absolute address of an org file, given its relative name."
    (construct-filename org-directory filename))

  ;; derive the agenda from every file in the org directory, minus the archive
  (setq org-agenda-files (remove (org-file-path "archive.org")
                                 (file-expand-wildcards (org-file-path "*.org"))))

  (setq org-archive-location
        (concat (org-file-path "archive.org") "::* From %s"))

  (defun open-index-file ()
    "Open the master org TODO list."
    (interactive)
    (persp-switch "org")
    (find-file (org-file-path "index.org"))
    (end-of-buffer))


  ;; display prefs
  (setq org-hide-leading-stars t)

  (setq org-capture-templates
        '(("a" "Article/video to read/watch"
           entry
           (file (org-file-path "articles.org"))
           "* %?\n")

          ("b" "Blog idea"
           entry
           (file (org-file-path "blog-ideas.org"))
           "* TODO %?\n")

          ("g" "Groceries"
           checkitem
           (file (org-file-path "groceries.org")))

          ("j" "Journal"
           entry
           (file (construct-filename notes-directory "journal.org"))
           "* %<%A %Y-%m-%d>\n  - %?")

          ("m" "Media queues")

          ("mf" "Films"
           entry
           (file (construct-filename notes-directory "media-films.org"))
           "* %?\n")

          ("mm" "Music"
           entry
           (file (construct-filename notes-directory "media-music.org"))
           "* %?\n")

          ("mr" "Reading"
           entry
           (file (construct-filename notes-directory "media-reading.org"))
           "* %?\n")

          ("mt" "Television"
           entry
           (file (construct-filename notes-directory "media-tv.org"))
           "* %?\n")

          ("s" "Memorable snippet, word, or fact"
           entry
           (file (construct-filename notes-directory "remember.org"))
           "* %?\n")

          ("t" "Todo"
           entry
           (file (org-file-path "index.org"))
           "* TODO %?\n")

          ("T" "Todo with tags"
           entry
           (file (org-file-path "index.org"))
           "* TODO %? %^g\n")))

  (defun mark-done-and-archive ()
    "Mark the state of an org-mode item as DONE and archive it."
    (interactive)
    (org-todo 'done)
    (org-archive-subtree))

  (defun org-capture-todo ()
    (interactive)
    (org-capture :keys "t"))

  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (define-key global-map "\C-cc" 'org-capture)
  (define-key global-map "\C-c\C-x\C-s" 'mark-done-and-archive)

  (setq org-log-done t)

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (sh . t)
     (ruby . t)))

  (defun org-insert-src-block (src-code-type)
    "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
    (interactive
     (let ((src-code-types
            '("emacs-lisp" "python" "C" "sh" "java" "js" "clojure" "C++" "css"
              "calc" "asymptote" "dot" "gnuplot" "ledger" "lilypond" "mscgen"
              "octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
              "haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
              "scheme" "sh" "sqlite")))
       (list (ido-completing-read "Source code type: " src-code-types))))
    (progn
      (newline-and-indent)
      (insert (format "#+BEGIN_SRC %s\n" src-code-type))
      (newline-and-indent)
      (insert "#+END_SRC\n")
      (previous-line 2)
      (org-edit-src-code)))

  (setq org-confirm-babel-evaluate nil))

(use-package paredit
  :hook ((cider-mode emacs-lisp-mode lisp-mode) . paredit-mode))

(use-package perspective
  :bind (:map perspective-map ("m" . twj/go-to-main))
  :config
  (persp-mode)
  :preface
  (defun twj/go-to-main ()
    (interactive)
    (persp-switch "main")))

(use-package persp-projectile
  :bind (:map projectile-mode-map
              ("s-s" . projectile-persp-switch-project)))

(use-package projectile
  :config
  (projectile-global-mode)
  (require 'persp-projectile)
  :diminish
  :init
  (setq projectile-tags-command "ctags-exuberant -Re -f \"%s\" --languages=-javascript --exclude=.git --exclude=tmp --exclude=log"))

(use-package projectile-rails
  :config
  (projectile-rails-global-mode))

(use-package python
  :init
  (setq python-indent 2))

(use-package rainbow-delimiters
  :hook ((cider-mode emacs-lisp-mode lisp-mode) . rainbow-delimiters-mode))

(use-package rainbow-mode
  :hook ((css-mode haml-mode scss-mode web-mode) . rainbow-mode))

(use-package rake)
(use-package restclient)

(use-package rspec-mode
  :config
  (setq rspec-use-rake-when-possible nil)
  (setq rspec-use-opts-file-when-available nil)
  (setq rspec-use-zeus-when-possible nil)
  (setq rspec-use-spring-when-possible nil)
  (setq rspec-command-options "--format progress"))

(use-package rubocop
  :init
  (add-hook 'ruby-mode-hook 'rubocop-mode))

(use-package ruby-end
  :diminish
  :init
  (add-hook 'ruby-mode-hook 'ruby-end-mode))

(use-package ruby-hash-syntax)

(use-package ruby-mode
  :bind (:map ruby-mode-map
              ("C-c C-c" . xmp)
              ("C-c h" . ruby-toggle-hash-syntax)
              ("\r" . newline-and-indent))
  :config
  (require 'rcodetools)
  :mode ("\\.rake$"
         "\\.gemspec$"
         "\\Capfile$"
         "\\Gemfile$"
         "\\Guardfile$"
         "\\Rakefile$")
  :init
  (setq ruby-insert-encoding-magic-comment nil))

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
  :init
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  :mode ("\\.erb$" "\\.html$\\'" "\\.rhtml$\\'" "\\.hbs$"))

(use-package whitespace
  :config
  (setq-default indent-tabs-mode nil)
  (setq whitespace-style '(face empty tabs lines-tail trailing))
  (setq require-final-newline t)
  (setq whitespace-line-column 80)
  (global-whitespace-mode t)
  (add-hook 'before-save-hook 'delete-trailing-whitespace)
  :diminish (whitespace-mode
             global-whitespace-mode))

(use-package wrap-region
  :diminish)

(use-package writegood-mode
  :hook ((markdown-mode) . writegood-mode))

(use-package yaml-mode
  :mode "\\.yml$")

(use-package yasnippet
  :diminish
  :hook ((python-mode ruby-mode rspec-mode) . yas-minor-mode))

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

(delete-selection-mode t)

;; color-theme and choco
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'choco t)

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
