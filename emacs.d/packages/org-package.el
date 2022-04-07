(use-package org
  :config
  (setq org-directory "~/org")
  (setq notes-directory "~/notes")

  (setq org-todo-keywords
        '((sequence "TODO" "NEXT" "|" "DONE")
          (sequence "WAITING" "HOLD" "|" "CANCELLED")))

  (setq org-todo-state-tags-triggers
        (quote (("CANCELLED" ("CANCELLED" . t))
                ("WAITING" ("WAITING" . t))
                ("HOLD" ("WAITING") ("HOLD" . t))
                (done ("WAITING") ("HOLD"))
                ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
                ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
                ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

  ;; Do not dim blocked tasks
  (setq org-agenda-dim-blocked-tasks nil)

  ;; Compact the block agenda view
  (setq org-agenda-compact-blocks t)

  ;; Custom agenda command definitions
  (setq org-agenda-custom-commands
        (quote (("N" "Notes" tags "NOTE"
                 ((org-agenda-overriding-header "Notes")
                  (org-tags-match-list-sublevels t)))
                (" " "Agenda"
                 ((agenda "" nil)
                  (tags-todo "-CANCELLED-work/!"
                             ((org-agenda-overriding-header "Stuck Projects")
                              (org-agenda-skip-function 'tw/skip-non-stuck-projects)
                              (org-agenda-sorting-strategy
                               '(category-keep))))
                  (tags-todo "-HOLD-CANCELLED-work/!"
                             ((org-agenda-overriding-header "Projects")
                              (org-agenda-skip-function 'tw/skip-non-projects)
                              (org-tags-match-list-sublevels 'indented)
                              (org-agenda-sorting-strategy
                               '(category-keep))))
                  (tags-todo "-CANCELLED-work/!NEXT"
                             ((org-agenda-overriding-header "Project Next Tasks")
                              (org-agenda-skip-function 'tw/skip-projects-and-habits-and-single-tasks)
                              (org-tags-match-list-sublevels t)
                              (org-agenda-sorting-strategy
                               '(todo-state-down effort-up category-keep))))
                  (tags-todo "-REFILE-CANCELLED-WAITING-HOLD-work-birthday/!"
                             ((org-agenda-overriding-header "Standalone Tasks")
                              (org-agenda-skip-function 'tw/skip-project-tasks)
                              (org-agenda-todo-ignore-scheduled t)
                              (org-agenda-todo-ignore-deadlines t)
                              (org-agenda-todo-ignore-with-date t)
                              (org-agenda-sorting-strategy
                               '(priority-down))))
                  (tags-todo "-CANCELLED-work+WAITING|HOLD/!"
                             ((org-agenda-overriding-header "Waiting and Postponed Tasks")
                              (org-agenda-skip-function 'tw/skip-non-tasks)
                              (org-tags-match-list-sublevels nil))))
                 nil))))

  (defun tw/find-project-task ()
    "Move point to the parent (project) task if any"
    (save-restriction
      (widen)
      (let ((parent-task (save-excursion (org-back-to-heading 'invisible-ok) (point))))
        (while (org-up-heading-safe)
          (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
            (setq parent-task (point))))
        (goto-char parent-task)
        parent-task)))

  (defun tw/is-project-p ()
    "Any task with a todo keyword subtask"
    (save-restriction
      (widen)
      (let ((has-subtask)
            (subtree-end (save-excursion (org-end-of-subtree t)))
            (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
        (save-excursion
          (forward-line 1)
          (while (and (not has-subtask)
                      (< (point) subtree-end)
                      (re-search-forward "^\*+ " subtree-end t))
            (when (member (org-get-todo-state) org-todo-keywords-1)
              (setq has-subtask t))))
        (and is-a-task has-subtask))))

  (defun tw/is-project-subtree-p ()
    "Any task with a todo keyword that is in a project subtree.
Callers of this function already widen the buffer view."
    (let ((task (save-excursion (org-back-to-heading 'invisible-ok)
                                (point))))
      (save-excursion
        (tw/find-project-task)
        (if (equal (point) task)
            nil
          t))))

  (defun tw/is-task-p ()
    "Any task with a todo keyword and no subtask"
    (save-restriction
      (widen)
      (let ((has-subtask)
            (subtree-end (save-excursion (org-end-of-subtree t)))
            (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
        (save-excursion
          (forward-line 1)
          (while (and (not has-subtask)
                      (< (point) subtree-end)
                      (re-search-forward "^\*+ " subtree-end t))
            (when (member (org-get-todo-state) org-todo-keywords-1)
              (setq has-subtask t))))
        (and is-a-task (not has-subtask)))))

  (defvar tw/hide-scheduled-and-waiting-next-tasks t)

  (defun tw/skip-non-stuck-projects ()
    "Skip trees that are not stuck projects"
    (save-restriction
      (widen)
      (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
        (if (tw/is-project-p)
            (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
                   (has-next ))
              (save-excursion
                (forward-line 1)
                (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
                  (unless (member "WAITING" (org-get-tags-at))
                    (setq has-next t))))
              (if has-next
                  next-headline
                nil)) ; a stuck project, has subtasks but no next task
          next-headline))))

  (defun tw/skip-project-tasks ()
    "Show non-project tasks.
Skip project and sub-project tasks, habits, and project related tasks."
    (save-restriction
      (widen)
      (let* ((subtree-end (save-excursion (org-end-of-subtree t))))
        (cond
         ((tw/is-project-p)
          subtree-end)
         ((tw/is-project-subtree-p)
          subtree-end)
         (t
          nil)))))

  (defun tw/skip-non-projects ()
    "Skip trees that are not projects"
    (if (save-excursion (tw/skip-non-stuck-projects))
        (save-restriction
          (widen)
          (let ((subtree-end (save-excursion (org-end-of-subtree t))))
            (cond
             ((tw/is-project-p)
              nil)
             ((and (tw/is-project-subtree-p) (not (tw/is-task-p)))
              nil)
             (t
              subtree-end))))
      (save-excursion (org-end-of-subtree t))))

  (defun tw/skip-non-tasks ()
    "Show non-project tasks.
Skip project and sub-project tasks, habits, and project related tasks."
    (save-restriction
      (widen)
      (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
        (cond
         ((tw/is-task-p)
          nil)
         (t
          next-headline)))))


  (defun tw/skip-projects-and-habits-and-single-tasks ()
    "Skip trees that are projects, tasks that are habits, single non-project tasks"
    (save-restriction
      (widen)
      (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
        (cond
         ((and tw/hide-scheduled-and-waiting-next-tasks
               (member "WAITING" (org-get-tags-at)))
          next-headline)
         ((tw/is-project-p)
          next-headline)
         ((and (tw/is-task-p) (not (tw/is-project-subtree-p)))
          next-headline)
         (t
          nil)))))

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
    (persp-switch "org")
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

          ("j" "Journal"
           entry
           (file (construct-filename notes-directory "journal.org"))
           "* %<%A %Y-%m-%d>\n  - %?")

          ("m" "Media queues")

          ("mf" "Films"
           entry
           (file (construct-filename notes-directory "media-films.org"))
           "* %?\n")

          ("mm" "Music"
           entry
           (file (construct-filename notes-directory "media-music.org"))
           "* %?\n")

          ("mr" "Reading"
           entry
           (file (construct-filename notes-directory "media-reading.org"))
           "* %?\n")

          ("mt" "Television"
           entry
           (file (construct-filename notes-directory "media-tv.org"))
           "* %?\n")

          ("s" "Memorable snippet, word, or fact"
           entry
           (file (construct-filename notes-directory "remember.org"))
           "* %?\n")

          ("t" "Todo"
           entry
           (file "~/org/index.org")
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
     (python . t)
     (shell . t)
     (ruby . t)))

  (defun org-insert-src-block (src-code-type)
    "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
    (interactive
     (let ((src-code-types
            '("emacs-lisp" "python" "C" "sh" "java" "js" "clojure" "C++" "css"
              "calc" "asymptote" "dot" "gnuplot" "ledger" "lilypond" "mscgen"
              "octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
              "haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
              "scheme" "sh" "sqlite")))
       (list (ido-completing-read "Source code type: " src-code-types))))
    (progn
      (newline-and-indent)
      (insert (format "#+BEGIN_SRC %s\n" src-code-type))
      (newline-and-indent)
      (insert "#+END_SRC\n")
      (previous-line 2)
      (org-edit-src-code)))

  (setq org-confirm-babel-evaluate nil))
