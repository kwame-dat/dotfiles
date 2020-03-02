;;; init-emails.el --- Emacs
;;; Commentary:
;;; Code:
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu/mu4e")
(use-package evil-mu4e)
(use-package mu4e-alert)
(mu4e-alert-set-default-style 'libnotify)
(add-hook 'after-init-hook #'mu4e-alert-enable-notifications)

(setq mu4e-maildir "~/.mail")

(setq mu4e-headers-include-related nil)

(setq mu4e-confirm-quit nil)

(setq mu4e-compose-context-policy 'pick-first)

(setq mail-user-agent 'mu4e-user-agent)

(add-hook 'message-mode-hook 'turn-on-orgtbl)
(add-hook 'message-mode-hook 'turn-on-orgstruct++)

(setq message-kill-buffer-on-exit t)

(setq mu4e-view-show-addresses t)

(setq mu4e-attachment-dir "~/Downloads")

(define-key mu4e-view-mode-map (kbd "C-c C-o") 'mu4e~view-browse-url-from-binding)

(require 'mu4e-contrib)
(setq mu4e-html2text-command 'mu4e-shr2text
      shr-color-visible-luminance-min 60
      shr-color-visible-distance-min 5
      shr-use-fonts nil
      shr-use-colors nil)
(advice-add #'shr-colorize-region
            :around (defun shr-no-colourise-region (&rest ignore)))

(add-to-list 'mu4e-view-actions '("ViewInBrowser" . mu4e-action-view-in-browser) t)

(require 'starttls)
(require 'smtpmail)

(use-package smtpmail-multi)
(setq smtpmail-multi-accounts
      (quote
       ((personal . ("tony@arksolutions.it"
                     "smtp.zoho.com"
                     587
                     "tony@arksolutions.it"
                     nil nil nil nil))
        (work . ("tony.ampomah@netsells.co.uk"
                 "smtp.gmail.com"
                 587
                 "tony.ampomah@netsells.co.uk"
                 starttls
                 nil nil nil)))))

(setq smtpmail-multi-associations
      (quote
       (("tony.ampomah@netsells.co.uk" work)
        ("tony@arksolutions.co.uk" personal))))

(setq smtpmail-multi-default-account (quote work))
(setq message-send-mail-function 'smtpmail-multi-send-it)

(setq smtpmail-debug-info t)
(setq smtpmail-debug-verbose t)

(setq mu4e-contexts
      `( ,(make-mu4e-context
           :name "Netsells"
           :match-func (lambda (msg) (when msg
                                       (string-prefix-p "/netsells.co.uk" (mu4e-message-field msg :maildir))))
           :vars '(
                   (mu4e-trash-folder . "/netsells.co.uk/[Gmail].Bin")
                   (mu4e-drafts-folder . "/netsells.co.uk/[Gmail].Drafts")
                   (mu4e-sent-folder . "/netsells.co.uk/[Gmail].Sent Mail")
                   (mu4e-refile-folder . "/netsells.co.uk/[Gmail].4Archives")
                   ))
         ,(make-mu4e-context
           :name "Arksolutions"
           :match-func (lambda (msg) (when msg
                                       (string-prefix-p "/artsolutions.it" (mu4e-message-field msg :maildir))))
           :vars '(
                   (mu4e-trash-folder . "/arksolutions.it/Trash")
                   (mu4e-sent-folder . "/arksolutions.it/Sent")
                   (mu4e-drafts-folder ."/arksolutions.it/Drafts")
                   (mu4e-refile-folder . "/arksolutions.it/4Archives")
                   ))
         ))

(setq mu4e-user-mail-address-list (list "tony@arksolutions.it" "tony.ampomah@netsells.co.uk"))

(setq message-kill-buffer-on-exit t)

(setq
 mu4e-view-show-images t
 mu4e-view-image-max-width 800)

(require 'org-mu4e)

(setq org-mu4e-link-query-in-headers-mode nil)
(provide 'init-emails)
;;; init-emails.el ends here
