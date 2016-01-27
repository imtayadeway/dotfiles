(setq python-indent 2)

(add-hook 'python-mode-hook
          (lambda ()
            (yas-minor-mode)))
