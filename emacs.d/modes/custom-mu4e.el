(setq mu4e-mu-binary "/usr/local/bin/mu")
(setq mu4e-maildir "~/mail")
(setq mu4e-attachment-dir "~/Desktop")
(setq mu4e-view-show-images t)
(setq mu4e-get-mail-command "offlineimap")
(setq mu4e-update-interval 300)

;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

(require 'smtpmail)

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-auth-credentials (expand-file-name "~/.authinfo.gpg")
      smtpmail-debug-info t)

(setq mu4e-contexts
      `(,(make-mu4e-context
          :name "Personal"
          :enter-func (lambda () (mu4e-message "Entering Personal context"))
          :leave-func (lambda () (mu4e-message "Leaving Personal context"))
          :match-func (lambda (msg)
                        (when msg
                          (string-prefix-p "/personal" (mu4e-message-field msg :maildir))))
          :vars '( ( user-mail-address      . "hello@timjwade.com"  )
                   ( user-full-name         . "Tim Wade" )
                   ( mu4e-compose-signature . nil)
                   ( mu4e-sent-folder       . "/personal/INBOX.Sent")
                   ( mu4e-drafts-folder     . "/personal/INBOX.Drafts")
                   ( mu4e-trash-folder      . "/personal/INBOX.Trash")
                   ( mu4e-refile-folder     . "/personal/INBOX.Archive")
                   ( smtpmail-smtp-server   . "smtp.fastmail.com")
                   ( smtpmail-smtp-service  . 465)
                   ( smtpmail-stream-type   . ssl)))
        ,(make-mu4e-context
          :name "Work"
          :enter-func (lambda () (mu4e-message "Entering Work context"))
          :leave-func (lambda () (mu4e-message "Leaving Work context"))
          :match-func (lambda (msg)
                        (when msg
                          (string-prefix-p "/redhat" (mu4e-message-field msg :maildir))))
          :vars '( ( user-mail-address             . "twade@redhat.com" )
                   ( user-full-name                . "Tim Wade" )
                   ( mu4e-compose-signature        . "\nTim Wade\n\nSoftware Developer\n\nhttps://redhat.com")
                   ( mu4e-sent-folder              . "/redhat/[Gmail].Sent Mail" )
                   ( mu4e-drafts-folder            . "/redhat/Drafts" )
                   ( mu4e-trash-folder             . "/redhat/Trash" )
                   ( mu4e-refile-folder            . "/redhat/Archives")
                   ( starttls-use-gnutls           . t)
                   ( smtpmail-starttls-credentials . '(("smtp.gmail.com" 587 nil nil)))
                   ( smtpmail-auth-credentials     . (expand-file-name "~/.authinfo.gpg"))
                   ( smtpmail-default-smtp-server  . "smtp.gmail.com")
                   ( smtpmail-smtp-server          . "smtp.gmail.com")
                   ( smtpmail-smtp-service         . 587)
                   ( smtpmail-stream-type          . starttls)))))

(setq mu4e-context-policy 'pick-first)

;; Refile will set mail to All Mail (basically archiving them). I want this to
;; auto-mark them as read, so I redefine refile to remove the u flag.
(setq mu4e-marks (assq-delete-all 'refile mu4e-marks))
(push '(refile :char ("r" . "▶")
               :prompt "refile"
               :dyn-target (lambda (target msg) (mu4e-get-refile-folder msg))
               :action
               (lambda (docid msg target)
                 (mu4e~proc-move docid (mu4e~mark-check-target target) "-u-N")))
      mu4e-marks)
