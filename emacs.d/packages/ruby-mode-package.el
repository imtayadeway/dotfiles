(use-package ruby-mode
  :bind (:map ruby-mode-map
              ("C-c C-c" . xmp)
              ("C-c h" . ruby-toggle-hash-syntax)
              ("\r" . newline-and-indent))
  :config
  (require 'rcodetools)
  :hook (ruby-mode . (lambda () (setq mode-name "💎")))
  :mode ("\\.rake$"
         "\\.gemspec$"
         "\\Capfile$"
         "\\Gemfile$"
         "\\Guardfile$"
         "\\Rakefile$")
  :init
  (setq ruby-insert-encoding-magic-comment nil))
