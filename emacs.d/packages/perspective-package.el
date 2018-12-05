(use-package perspective
  :bind (:map perspective-map ("m" . twj/go-to-main))
  :config
  (persp-mode)
  :preface
  (defun twj/go-to-main ()
    (interactive)
    (persp-switch "main")))
