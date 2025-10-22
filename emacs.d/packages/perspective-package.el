(use-package perspective
  :bind (:map perspective-map ("m" . twj/go-to-main))
  :config
  (persp-mode)
  :custom
  (persp-mode-prefix-key (kbd "C-c M-p"))
  :preface
  (defun twj/go-to-main ()
    (interactive)
    (persp-switch "main")))
