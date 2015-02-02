(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "C-c s") 'multi-term)
(global-set-key (kbd "C-c m") 'mu4e)
(global-set-key (kbd "C-c d") 'date)
(global-set-key (kbd "C-c i") 'open-index-file)
(global-set-key (kbd "C-c j") 'ace-jump-mode)
(global-set-key (kbd "C-c t") 'time)
(global-set-key (kbd "C-c w") 'ace-window)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-M-\\") 'tidy-region)
(global-set-key (kbd "C-M-|") 'tidy-buffer)
(global-set-key (kbd "M-;") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "M-#") 'sort-lines)
(global-set-key (kbd "M-/") 'hippie-expand)

;; switch to new window on split
(global-set-key (kbd "C-x 2") 'split-window-below-and-switch)
(global-set-key (kbd "C-x 3") 'split-window-right-and-switch)

;; change font size
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C-=") 'text-scale-increase)
(define-key global-map (kbd "C-_") 'text-scale-decrease)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; org-mode
(global-set-key (kbd "M-n") 'org-capture-todo)

;; expand-region
(global-set-key (kbd "C-'") 'er/expand-region)

;; toggle quotes
(global-set-key (kbd "C-\"") 'toggle-quotes)
