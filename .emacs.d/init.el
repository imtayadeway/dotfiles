;; whitespace
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)

;; pair character completion
(electric-pair-mode 1)

;; ruby mode
(add-to-list 'auto-mode-alist
             '("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("\\(Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))

;; color-theme and choco
(add-to-list 'load-path "~/.emacs.d/themes/choco")
(require 'color-theme)
(require 'color-theme-choco)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-choco)))

;; delete trailing white space
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; load snippets
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;; put autosaves in temp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; line numbers
(global-linum-mode 1)

;; ido
(require 'ido)
(ido-mode t)
(custom-set-variables
 '(ido-enable-flex-matching t)
 '(ido-mode (quote both) nil (ido)))
(custom-set-faces)

;; rvm.el
(add-to-list 'load-path "~/.emacs.d/elisp/external/rvm.el")
(require 'rvm)
(rvm-use-default)
(add-hook 'ruby-mode-hook
          (lambda () (rvm-activate-corresponding-ruby)))

;; windows
(windmove-default-keybindings)
(winner-mode 1)

;; rinari
(add-to-list 'load-path "~/.emacs.d/elisp/external/rinari")
(require 'rinari)

;; haml-mode
(add-to-list 'load-path "~/.emacs.d/modes/haml-mode")
(require 'haml-mode)

;; yaml-mode
(add-to-list 'load-path "~/.emacs.d/modes/yaml-mode")
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; scss-mode
(add-to-list 'load-path "~/.emacs.d/modes/scss-mode")
(require 'scss-mode)
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

;; coffee-mode
(add-to-list 'load-path "~/.emacs.d/modes/coffee-mode")
(require 'coffee-mode)
(custom-set-variables
 '(coffee-tab-width 2)
 '(coffee-args-compile '("-c" "--bare")))

(eval-after-load "coffee-mode"
  '(progn
     (define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer)
     (define-key coffee-mode-map (kbd "C-j") 'coffee-newline-and-indent)))

;; inf-ruby
(add-to-list 'load-path "~/.emacs.d/elisp/external/inf-ruby")
(autoload 'inf-ruby-minor-mode "inf-ruby" "Run an inferior Ruby process" t)
(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)

;; rspec-mode
(add-to-list 'load-path "~/.emacs.d/modes/rspec-mode")
(require 'rspec-mode)
(eval-after-load 'rspec-mode
 '(rspec-install-snippets))
