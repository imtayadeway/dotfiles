(setq auto-mode-alist
      (cons '("\\.md$" . markdown-mode) auto-mode-alist))

(setq markdown-fontify-code-blocks-natively t)

(add-hook 'markdown-mode-hook
(lambda ()
            (flyspell-mode)))
