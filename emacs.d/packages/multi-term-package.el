(use-package multi-term
  :init
  (setq multi-term-program "/bin/bash")
  (setq multi-term-program-switches "--login")
  (setq yas-dont-activate t)
  (add-hook 'term-mode-hook
            (lambda ()
              (define-key term-raw-map (kbd "M-o") 'other-window)
              (define-key term-raw-map (kbd "C-y") 'term-paste)))
  (add-hook 'term-exec-hook
            (function
             (lambda ()
               (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix)))))
