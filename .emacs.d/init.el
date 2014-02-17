(add-to-list 'auto-mode-alist
             '("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("\\(Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))

(add-to-list 'load-path "~/.emacs.d/themes/")
(require 'color-theme)
(require 'color-theme-choco)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-choco)))
