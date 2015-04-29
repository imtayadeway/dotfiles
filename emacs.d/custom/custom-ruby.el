(rvm-use-default)
(require 'rcodetools)

(add-hook 'ruby-mode-hook
          (lambda ()
            (rvm-activate-corresponding-ruby)
            (setq ruby-insert-encoding-magic-comment nil)
            (rinari-minor-mode)
            (yas-minor-mode)
            (ruby-end-mode)
            (ruby-refactor-mode)
            (flycheck-mode)
            (global-set-key (kbd "C-c C-f") 'rinari-find-file-in-project)
            (global-set-key (kbd "C-c h") 'ruby-toggle-hash-syntax)
            (setq rinari-tags-file-name "TAGS")
            (projectile-rails-mode)
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
