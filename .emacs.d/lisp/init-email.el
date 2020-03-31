;;; init-email.el --- Emacs
;;; Commentary:
;;; Code:
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu/mu4e")

(require 'mu4e)

;; I want my format=flowed thank you very much
;; mu4e sets up visual-line-mode and also fill (M-q) to do the right thing
;; each paragraph is a single long line; at sending, emacs will add the
;; special line continuation characters.
(setq mu4e-compose-format-flowed t)

;; give me ISO(ish) format date-time stamps in the header list
(setq mu4e-headers-date-format "%Y-%m-%d %H:%M")

;; show full addresses in view message (instead of just names)
;; toggle per name with M-RET
(setq mu4e-view-show-addresses 't)

;; path to my mail directory
(setq mu4e-maildir "~/.mail")

;; path to saving attachments
(setq mu4e-attachment-dir "~/Downloads")

;; the next are relative to `mu4e-maildir'
;; instead of strings, they can be functions too, see
;; their docstring or the chapter 'Dynamic folders'
(setq mu4e-sent-folder   "/Sent"
      mu4e-drafts-folder "/Drafts"
      mu4e-trash-folder  "/Trash")

;; the maildirs you use frequently; access them with 'j' ('jump')
(setq   mu4e-maildir-shortcuts
    '(("/Archive"     . ?a)
      ("/INBOX"       . ?i)
      ("/Sent"        . ?s)))

;; the list of all of my e-mail addresses
(setq mu4e-user-mail-address-list '("tony@arksolutions.it"
                                    "tony.ampomah@netsells.co.uk"
                                    "tony.ampomah.jw@gmail.com"))

;; the headers to show in the headers list -- a pair of a field
;; and its width, with `nil' meaning 'unlimited'
;; (better only use that for the last field.
;; These are the defaults:
(setq mu4e-headers-fields
    '( (:date          .  25)    ;; alternatively, use :human-date
       (:flags         .   6)
       (:from          .  22)
       (:subject       .  nil))) ;; alternatively, use :thread-subject

;; program to get mail; alternatives are 'fetchmail', 'getmail'
;; isync or your own shellscript. called when 'U' is pressed in
;; main view.

;; If you get your mail without an explicit command,
;; use "true" for the command (this is the default)
;; when I press U in the main view, or C-c C-u elsewhere,
;; this command is called, followed by the mu indexer
(setq mu4e-get-mail-command "offlineimap")

;; not using smtp-async yet
;; some of these variables will get overridden by the contexts
(setq
 send-mail-function 'smtpmail-send-it
 message-send-mail-function 'smtpmail-send-it
 smtpmail-smtp-server "smtp.gmail.com"
 smtpmail-smtp-service 465
 smtpmail-stream-type 'ssl
 )

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)
;; (add-hook 'mu4e-header-)
(add-hook 'mu4e-headers-mode truncate-lines nil)

;; here come the contexts
;; each context can set any number of variables (see :vars)
;; for example below here I'm using two different SMTP servers depending on identity
(setq mu4e-contexts
      `( ,(make-mu4e-context
           :name "p tony@arksolutions.it"
           :enter-func (lambda () (mu4e-message "Enter tony@arksolutions.it context"))
           :leave-func (lambda () (mu4e-message "Leave tony@arksolutions.it context"))
           ;; we match based on the contact-fields of the message (that we are replying to)
           ;; https://www.djcbsoftware.nl/code/mu/mu4e/What-are-contexts.html#What-are-contexts
           :match-func (lambda (msg)
                         (when msg
                           (mu4e-message-contact-field-matches msg
                                                               :to "tony@arksolutions.it")))
           :vars '( ( user-mail-address      . "tony@arksolutions.it"  )
                    ( user-full-name         . "Tony Ampomah" )
                    ( smtpmail-smtp-server   . "smtp.zoho.com" )
                    ( mu4e-refile-folder . "/arksolutions.it/4Archives")
                    ( mu4e-compose-signature .
                                             (concat
                                              "Many thanks\n"
                                              "Tony\n"))))

         ,(make-mu4e-context
           :name "w tony.ampomah@netsells.co.uk"
           :enter-func (lambda () (mu4e-message "Enter tony.ampomah@netsells.co.uk context"))
           ;; no leave-func
           ;; we match based on the contact-fields of the message
           :match-func (lambda (msg)
                         (when msg
                           (mu4e-message-contact-field-matches msg
                                                               :to "tony.ampomah@netsells.co.uk")))
           :vars '( ( user-mail-address       . "tony.ampomah@netsells.co.uk" )
                    ( user-full-name          . "Tony Ampomah" )
                    ( smtpmail-smtp-server    . "smtp.gmail.com" )
                    ( mu4e-refile-folder . "/netsells.co.uk/4Archives")
                    ( mu4e-compose-signature  .
                                              (concat
                                               "Tony Ampomah\n"
                                               "PHP Developer :: Netsells\n"
                                               "https://netsells.co.uk/\n"))))

         ))

;; start with the first (default) context;
(setq mu4e-context-policy 'pick-first)

;; compose with the current context if no context matches;
(setq mu4e-compose-context-policy nil)

;; no need to ask
(setq mu4e-confirm-quit nil)


;; Use fancy icons
(setq mu4e-headers-has-child-prefix '("+" . "")
      mu4e-headers-empty-parent-prefix '("-" . "")
      mu4e-headers-first-child-prefix '("\\" . "")
      mu4e-headers-duplicate-prefix '("=" . "")
      mu4e-headers-default-prefix '("|" . "")
      mu4e-headers-draft-mark '("D" . "")
      mu4e-headers-flagged-mark '("F" . "")
      mu4e-headers-new-mark '("N" . "")
      mu4e-headers-passed-mark '("P" . "")
      mu4e-headers-replied-mark '("R" . "")
      mu4e-headers-seen-mark '("S" . "")
      mu4e-headers-trashed-mark '("T" . "")
      mu4e-headers-attach-mark '("a" . "")
      mu4e-headers-encrypted-mark '("x" . "")
      mu4e-headers-signed-mark '("s" . "")
      mu4e-headers-unread-mark '("u" . ""))

;; these are the standard mu4e search bookmarks
;; I've only added the fourth one to pull up flagged emails in my inbox
;; I sometimes use this to shortlist emails I need to get around to ASAP
(setq mu4e-bookmarks
  `( ,(make-mu4e-bookmark
       :name  "Unread messages"
       :query "flag:unread AND NOT flag:trashed"
       :key ?u)
     ,(make-mu4e-bookmark
       :name "Today's messages"
       :query "date:today..now"
       :key ?t)
     ,(make-mu4e-bookmark
       :name "Last 7 days"
       :query "date:7d..now"
       :key ?w)
     ,(make-mu4e-bookmark
       :name "Flagged in INBOX"
       :query "maildir:\"/INBOX\" and flag:flagged"
       :key ?f)))

;; use org structures and tables in message mode
(add-hook 'message-mode-hook 'turn-on-orgstruct++)
(add-hook 'message-mode-hook 'visual-fill-column-mode)

;; view HTML email in browser
(add-to-list 'mu4e-view-actions '("ViewInBrowser" . mu4e-action-view-in-browser) t)

;; display unread email on mode line
;; (add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display)

(provide 'init-email)
;;; init-email.el ends here
