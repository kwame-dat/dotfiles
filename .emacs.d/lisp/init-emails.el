;;; init-emails.el --- Emacs
;;; Commentary:
;;; Code:
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu/mu4e")
(require 'mu4e)
(require 'smtpmail)

(setq mu4e-get-mail-command "offlineimap"
      mu4e-maildir (expand-file-name "~/.mail")
      mu4e-update-interval 180
      message-kill-buffer-on-exit t
      mu4e-headers-skip-duplicates t
      mu4e-compose-signature-auto-include nil
      mu4e-view-show-images t
      mu4e-view-show-addresses t
      mu4e-attachment-dir "~/Downloads"
      mu4e-use-fancy-chars t
      mu4e-headers-auto-update t
      ;; message-signature-file "~/.emacs.d/.signature"
      mu4e-compose-signature-auto-include nil
      mu4e-view-prefer-html t
      mu4e-compose-in-new-frame t
      mu4e-change-filenames-when-moving t
      message-send-mail-function 'smtpmail-send-it
      starttls-use-gnutls t
      smtpmail-stream-type 'starttls
      ;;mu4e-html2text-command "w3m -T text/html"
      )

(setq mu4e-context-policy 'pick-first)
(setq mu4e-compose-context-policy 'always-ask)
(setq mu4e-contexts
      (list
       (make-mu4e-context
    :name "personal"
    :enter-func (lambda () (mu4e-message "Entering personal context"))
    :leave-func (lambda () (mu4e-message "Leaving personal context"))
    :match-func (lambda (msg)
              (when msg
            (mu4e-message-contact-field-matches
             msg '(:from :to :cc :bcc) "tony@arksolutions.it")))
    :vars '((user-mail-address . "tony@arksolutions.it")
        (user-full-name . "Tony Ampomah")
        (mu4e-sent-folder . "/arksolutions.it/Sent")
        (mu4e-drafts-folder . "/arksolutions.it/Drafts")
        (mu4e-trash-folder . "/arksolutions.it/Trash")
        (mu4e-refile-folder . "/arksolutions.it/4Archives")
        (smtpmail-queue-dir . "~/.email/arksolutions.it/queue/cur")
        (smtpmail-smtp-user . "tony@arksolutions.it")
        (smtpmail-starttls-credentials . (("tony@arksolutions.it" 587 nil nil)))
        (smtpmail-auth-credentials . (expand-file-name "~/.authinfo.gpg"))
        (smtpmail-default-smtp-server . "smtp.zoho.com")
        (smtpmail-smtp-server . "smtp.zoho.com")
        (smtpmail-smtp-service . 587)
        (mu4e-sent-messages-behavior . sent)
        (mu4e-maildir-shortcuts . ( ("/arksolutions.it/INBOX"    . ?i)
                        ("/arksolutions.it/Sent"     . ?s)
                        ("/arksolutions.it/Trash"    . ?t)
                        ("/arksolutions.it/4Archives" . ?a)
                        ("/arksolutions.it/Drafts"   . ?d)
                        ))))

       (make-mu4e-context
    :name "work"
    :enter-func (lambda () (mu4e-message "Entering work context"))
    :leave-func (lambda () (mu4e-message "Leaving work context"))
    :match-func (lambda (msg)
              (when msg
            (mu4e-message-contact-field-matches
             msg '(:from :to :cc :bcc) "tony.ampomah@netsells.co.uk")))
    :vars '((user-mail-address . "tony.ampomah@netsells.co.uk")
        (user-full-name . "Tony Ampomah")
        (mu4e-sent-folder . "/netsells.co.uk/[Gmail]/Sent Mail")
        (mu4e-drafts-folder . "/netsells.co.uk/[Gmail]/Drafts")
        (mu4e-trash-folder . "/netsells.co.uk/[Gmail]/Trash")
        (mu4e-refile-folder . "/netsells.co.uk/4Archives")
        (smtpmail-queue-dir . "~/.email/netsells.co.uk/queue/cur")
        (smtpmail-smtp-user . "tony.ampomah@netsells.co.uk")
        (smtpmail-starttls-credentials . (("smtp.gmail.com" 587 nil nil)))
        (smtpmail-auth-credentials . (expand-file-name "~/.authinfo.gpg"))
        (smtpmail-default-smtp-server . "smtp.gmail.com")
        (smtpmail-smtp-server . "smtp.gmail.com")
        (smtpmail-smtp-service . 587)
        (mu4e-sent-messages-behavior . delete)
        (mu4e-maildir-shortcuts . ( ("/netsells.co.uk/INBOX"                        . ?i)
                        ("/netsells.co.uk/[Gmail]/Sent Mail" . ?s)
                        ("/netsells.co.uk/[Gmail]/Trash"            . ?t)
                        ("/netsells.co.uk/4Archives"    . ?a)
                        ("/netsells.co.uk/[Gmail]/Drafts"           . ?d)
                        ))))))

;;; Bookmarks
(setq mu4e-bookmarks
      `(
    ("flag:unread AND NOT flag:trashed" "Unread messages" ?u)
    ("flag:unread" "new messages" ?n)
        ("date:today..now" "Today's messages" ?t)
        ("date:7d..now" "Last 7 days" ?w)
        ("mime:image/*" "Messages with images" ?p)
        ))

(require 'mu4e-contrib)
(use-package evil-mu4e)
(use-package mu4e-alert)


(add-to-list 'mu4e-view-actions '("ViewInBrowser" . mu4e-action-view-in-browser) t)
(mu4e-alert-set-default-style 'growl)
(define-key mu4e-view-mode-map (kbd "C-c C-o") 'mu4e~view-browse-url-from-binding)
(add-hook 'after-init-hook #'mu4e-alert-enable-notifications)
(add-hook 'message-mode-hook 'turn-on-orgtbl)
(add-hook 'message-mode-hook 'turn-on-orgstruct++)
(add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display)

(require 'org-mu4e)
(setq org-mu4e-convert-to-html t)

(use-package org-mime
  :ensure t)

(provide 'init-emails)
;;; init-emails.el ends here
