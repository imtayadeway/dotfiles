(setq org-directory "~/Documents/org")
(setq notes-directory "~/Documents/notes")

(defun construct-filename (directory filename)
  (concat (file-name-as-directory directory) filename))

(add-hook 'org-mode-hook
          (lambda ()
            (flyspell-mode)
            (local-set-key (kbd "C-x s")
                           'org-insert-src-block)
            (local-set-key (kbd "C-c v")
                           'org-show-todo-tree)))

(defun org-file-path (filename)
  "Return the absolute address of an org file, given its relative name."
  (construct-filename org-directory filename))

;; derive the agenda from every file in the org directory, minus the archive
(setq org-agenda-files (remove (org-file-path "archive.org")
                               (file-expand-wildcards (org-file-path "*.org"))))

(setq org-archive-location
      (concat (org-file-path "archive.org") "::* From %s"))

(defun open-index-file ()
  "Open the master org TODO list."
  (interactive)
  (find-file (org-file-path "index.org"))
  (end-of-buffer))


;; display prefs
(setq org-hide-leading-stars t)

(setq org-capture-templates
      '(("a" "Article/video to read/watch"
         entry
         (file (org-file-path "articles.org"))
         "* %?\n")

        ("b" "Blog idea"
         entry
         (file (org-file-path "blog-ideas.org"))
         "* TODO %?\n")

        ("g" "Groceries"
         checkitem
         (file (org-file-path "groceries.org")))

        ("q" "Media queues")

        ("qf" "Films"
         entry
         (file (construct-filename notes-directory "media-films.org"))
         "* %?\n")

        ("qm" "Music"
         entry
         (file (construct-filename notes-directory "media-music.org"))
         "* %?\n")

        ("qr" "Reading"
         entry
         (file (construct-filename notes-directory "media-reading.org"))
         "* %?\n")

        ("qt" "Television"
         entry
         (file (construct-filename notes-directory "media-tv.org"))
         "* %?\n")

        ("s" "Memorable snippet, word, or fact"
         entry
         (file (construct-filename notes-directory "remember.org"))
         "* %?\n")

        ("t" "Todo"
         entry
         (file (org-file-path "index.org"))
         "* TODO %?\n")

        ("T" "Todo with tags"
         entry
         (file (org-file-path "index.org"))
         "* TODO %? %^g\n")))

(defun mark-done-and-archive ()
  "Mark the state of an org-mode item as DONE and archive it."
  (interactive)
  (org-todo 'done)
  (org-archive-subtree))

(defun org-capture-todo ()
  (interactive)
  (org-capture :keys "t"))

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)
(define-key global-map "\C-c\C-x\C-s" 'mark-done-and-archive)

(setq org-log-done t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (ruby . t)))

(defun org-insert-src-block (src-code-type)
  "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
  (interactive
   (let ((src-code-types
          '("emacs-lisp" "python" "C" "sh" "java" "js" "clojure" "C++" "css"
            "calc" "asymptote" "dot" "gnuplot" "ledger" "lilypond" "mscgen"
            "octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
            "haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
            "scheme" "sqlite")))
     (list (ido-completing-read "Source code type: " src-code-types))))
  (progn
    (newline-and-indent)
    (insert (format "#+BEGIN_SRC %s\n" src-code-type))
    (newline-and-indent)
    (insert "#+END_SRC\n")
    (previous-line 2)
    (org-edit-src-code)))

(setq org-confirm-babel-evaluate nil)
