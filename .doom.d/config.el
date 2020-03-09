(setq doom-localleader-key ",")
(setq display-line-numbers-type 'relative)
(setq doom-theme 'doom-one)
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

(setq company-idle-delay 0.1)
(setq company-minimum-prefix-length 3)

(setq user-full-name "Tony Ampomah"
      user-mail-address "tony@arksolutions.it"

      doom-font (font-spec :family "Fira Code" :size 14)
      doom-big-font (font-spec :family "Fira Code" :size 14)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 14)

      which-key-idle-delay 0.40
      lsp-ui-sideline-enable nil
      lsp-ui-doc-enable nil
      dart-format-on-save t
      web-mode-markup-indent-offset 2
      web-mode-code-indent-offset 2
      web-mode-css-indent-offset 2
      js-indent-level 2
      typescript-indent-level 2
      json-reformat:indent-width 2
      prettier-js-args '("--single-quote")
      dired-dwim-target t
      css-indent-offset 2)

(auth-source-pass-enable)
(setq auth-sources '((:source "~/.authinfo.gpg")))
(setq lsp-enable-file-watchers nil)

(when IS-LINUX
  (font-put doom-font :weight 'semi-light))
(when IS-MAC
  (setq ns-use-thin-smoothing t)
  (add-hook 'window-setup-hook #'toggle-frame-maximized))

;; keybindings
(map! :m "M-j" #'multi-next-line
      :m "M-k" #'multi-previous-line
      :m "<f5>" #'open-agenda
      :m "§" #'my-org-super-agenda-today

      ;; Easier window movement
      :n "C-h" #'evil-window-left
      :n "C-j" #'evil-window-down
      :n "C-k" #'evil-window-up
      :n "C-l" #'evil-window-right
      "s-r" #'counsel-imenu
      "s-p" #'+ivy/projectile-find-file
      "s-S-p" #'counsel-projectile-switch-project
      "s-S-f" #'+default/search-project

      (:map evil-treemacs-state-map
        "C-h" #'evil-window-left
        "C-l" #'evil-window-right)

      (:when IS-LINUX
        "s-x" #'execute-extended-command
        "s-;" #'eval-expression
        ;; use super for window/frame navigation/manipulation
        "s-w" #'delete-window
        "s-W" #'delete-frame
        "s-n" #'+default/new-buffer
        "s-N" #'make-frame
        "s-q" (if (daemonp) #'delete-frame #'evil-quit-all)
        ;; Restore OS undo, save, copy, & paste keys (without cua-mode, because
        ;; it imposes some other functionality and overhead we don't need)
        "s-z" #'undo
        "s-c" (if (featurep 'evil) #'evil-yank #'copy-region-as-kill)
        "s-v" #'yank
        "s-s" #'save-buffer
        ;; Buffer-local font scaling
        "s-+" #'doom/reset-font-size
        "s-=" #'doom/increase-font-size
        "s--" #'doom/decrease-font-size
        ;; Conventional text-editing keys
        "s-a" #'mark-whole-buffer
        :gi [s-return]    #'+default/newline-below
        :gi [s-S-return]  #'+default/newline-above
        :gi [s-backspace] #'doom/backward-kill-to-bol-and-indent)

      :leader
      (:prefix "f"
        "t" #'+tonyampomah/find-in-dotfiles
        "T" #'+tonyampomah/browse-dotfiles)
      (:prefix "o"
        "m" #'mu4e
        "." #'+pass/edit-entry)
      (:prefix "n"
        "m" #'+tonyampomah/find-notes-for-major-mode
        "p" #'+tonyampomah/find-notes-for-project))

;; lang/php keybinding
(map! :localleader
      :map php-mode-map
      "i" #'phpactor-import-class
      "m" #'phpactor-move-class

      :prefix "f"
      "r" #'lsp-find-references
      "d" #'lsp-describe-thing-at-point

      :prefix "g"
      "d" #'phpactor-goto-definition
      "i" #'phpactor-find-references

      :prefix "t"
      "p" #'phpunit-current-project
      "c" #'phpunit-current-class
      "t" #'phpunit-current-test)
(map! :n "C-]" #'lsp-find-definition)
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))

;; Org Mode Configuration
(after! org
  (add-to-list 'org-modules 'org-habit t))
(setq org-directory "~/Dropbox/org")
(setq org-agenda-files (quote ("~/Dropbox/org/todo.org"
                               "~/Dropbox/org/inbox.org"
                               "~/Dropbox/org/goals.org"
                               "~/Dropbox/org/calendar/gcal.org")))
;; org capture templates
(setq org-capture-templates
      '(("t" "Task" entry (file "~/Dropbox/org/inbox.org")
         "* TODO %?\n")
        ("p" "Project" entry (file+headline "~/Dropbox/org/todo.org" "Projects")
         (file "~/Dropbox/org/templates/newprojecttemplate.org"))
        ("s" "Goals" entry (file+headline "~/Dropbox/org/goals.org" "Goals")
         "* SOMEDAY %?\n")
        ("l" "Log" entry (file+olp+datetree "~/Dropbox/org/log.org" "Log")
         (file "~/Dropbox/org/templates/logtemplate.org"))))

(setq org-agenda-inhibit-startup nil
      org-agenda-start-on-weekday nil
      org-agenda-skip-deadline-if-done t
      org-agenda-skip-scheduled-if-done t)

(setq-default flycheck-phpcs-standard "PSR2")

;; projectile
(setq projectile-project-search-path '("~/Desktop"
                                       "~/Downloads"
                                       "~/Repo/2Areas"
                                       "~/Repo/1Projects"))

;; ledger
(setq ledger-post-amount-alignment-column 70)

;; configure email
(setq +mu4e-backend 'offlineimap)
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu/mu4e")
(set-email-account! "arksolutions.it"
                    '((mu4e-sent-folder       . "/arksolutions.it/Sent")
                      (mu4e-drafts-folder     . "/arksolutions.it/Drafts")
                      (mu4e-trash-folder      . "/arksolutions.it/Trash")
                      (mu4e-refile-folder     . "/arksolutions.it/INBOX")
                      (smtpmail-smtp-user     . "tony@arksolutions.it")
                      (user-mail-address      . "tony@arksolutions.it")
                      (mu4e-compose-signature . "---\nTony Ampomah"))
                    t)
(after! mu4e
  ;; load package to be able to capture emails for GTD
  (require 'org-mu4e)
  ;; do not use rich text emails
  (remove-hook! 'mu4e-compose-mode-hook #'org-mu4e-compose-org-mode)

  ;; configure mu4e options
  (setq mu4e-confirm-quit nil ; quit without asking
        mu4e-attachment-dir "~/Downloads"
        mu4e-get-mail-command "offlineimap"
        mu4e-user-mail-address-list (list "tony@arksolutions.it" "tony.ampomah@netsells.co.uk"))

  (setq mu4e-bookmarks
        '( ("flag:unread AND NOT flag:trashed"                "Unread messages"        ?u)
           ("date:today..now"                                 "Today's messages"       ?t)
           ("date:7d..now"                                    "Last 7 days"            ?w)
           ("maildir:/sent"                                   "sent"                   ?s)
           ("maildir:/arksolutions.it/INBOX AND date:7d..now" "Personal Last 7 days"   ?p)
           ("maildir:/netsells.co.uk/INBOX AND date:7d..now"  "Work Last 7 days"       ?n)
           ("mime:image/*"                                    "Messages with images"   ?i)))

  (setq mu4e-maildir-shortcuts
        '( ("/netsells.co.uk/INBOX" . ?w)
           ("/arksolutions.it/INBOX"       . ?p)
           ("/sent"            . ?s)))

  (setq message-send-mail-function 'smtpmail-send-it
        smtpmail-stream-type 'starttls
        smtpmail-default-smtp-server "smtp.gmail.com"
        smtpmail-smtp-server "smtp.gmail.com"
        smtpmail-smtp-service 587)
  ;; add custom actions for messages
  (add-to-list 'mu4e-view-actions
	             '("View in browser" . mu4e-action-view-in-browser) t))
