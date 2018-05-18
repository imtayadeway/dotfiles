(chruby "ruby-2.4.4")
(require 'rcodetools)

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

(setq files-in-ruby-mode
      '("\\.rake$"
        "\\.gemspec$"
        "\\Capfile$"
        "\\Gemfile$"
        "\\Guardfile$"
        "\\Rakefile$"))

(dolist (file-regexp files-in-ruby-mode)
  (add-to-list 'auto-mode-alist `(,file-regexp . ruby-mode)))
