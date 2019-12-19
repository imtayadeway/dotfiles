(use-package yasnippet
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-global-mode 1)
  :hook ((go-mode python-mode ruby-mode rspec-mode sh-mode) . yas-minor-mode)
  :diminish (yas-minor-mode . "✂️"))
