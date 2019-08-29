(setq doom-localleader-key ",")
(setq display-line-numbers-type 'relative)
(setq doom-theme 'doom-one-light)
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

(setq user-full-name "Tony Ampomah"
      user-mail-address "tony@arksolutions.it"

      doom-font (font-spec :family "Dank Mono" :size 14)
      doom-big-font (font-spec :family "Dank Mono" :size 14)
      doom-variable-pitch-font (font-spec :family "Dank Mono" :size 14)

      which-key-idle-delay 0.50
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


(when IS-LINUX
  (font-put doom-font :weight 'semi-light))
(when IS-MAC
  (setq ns-use-thin-smoothing t)
  (add-hook 'window-setup-hook #'toggle-frame-maximized))


;;
;;; Keybinds

(map! :m "M-j" #'multi-next-line
      :m "M-k" #'multi-previous-line
      :m "<f5>" #'open-agenda
      :m "§" #'my-org-super-agenda-today

      ;; Easier window movement
      :n "C-h" #'evil-window-left
      :n "C-j" #'evil-window-down
      :n "C-k" #'evil-window-up
      :n "C-l" #'evil-window-right

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
        "." #'ivy-pass)
      (:prefix "n"
        "m" #'+tonyampomah/find-notes-for-major-mode
        "p" #'+tonyampomah/find-notes-for-project))


;; lang/org
(after! org
  (add-to-list 'org-modules 'org-habit t))
(setq org-agenda-files (quote ("~/org/todo.org"
                               "~/org/agendas.org"
                               "~/org/inbox.org"
                               "~/org/calendar/gcal.org"
                               "~/org/calendar/tcal.org"
                               "~/org/somedaymaybe.org")))

;; org-jira
(setq jiralib-url "https://jira.eandl.co.uk")
(setq org-jira-working-dir "~/Repo/jira")

;; org capture templates
(setq org-capture-templates
      '(("t" "Task" entry (file "~/org/inbox.org")
         "* TODO %?\n")
        ("p" "Project" entry (file+headline "~/org/todo.org" "Projects")
         (file "~/org/templates/newprojecttemplate.org"))
        ("s" "Someday" entry (file+headline "~/org/somedaymaybe.org" "Someday / Maybe")
         "* SOMEDAY %?\n")
        ("m" "Maybe" entry (file+headline "~/org/somedaymaybe.org" "Someday / Maybe")
         "* MAYBE %?\n")
        ("l" "Log" entry (file+olp+datetree "~/org/log.org" "Log")
         (file "~/org/templates/logtemplate.org"))))

(setq org-agenda-inhibit-startup nil
      org-agenda-show-future-repeats nil
      org-agenda-start-on-weekday nil
      org-agenda-skip-deadline-if-done t
      org-agenda-skip-scheduled-if-done t)

;; lang/php
  (map! :localleader
        :map php-mode-map
        "i" #'phpactor-import-class
        "]" #'phpactor-goto-definition
        "fr" #'phpactor-find-references
        :prefix "r"
        "cn" #'phpactor-create-new-class
        "ci" #'phpactor-implement-contracts
        :prefix "t"
        "p" #'phpunit-current-project
        "c" #'phpunit-current-class
        "t" #'phpunit-current-test)

(setq-default flycheck-phpcs-standard "PSR2")

;; Projectile
(setq projectile-project-search-path '("~/Desktop"
                                       "~/Downloads"
                                       "~/Documents/3 Resources"
                                       "~/Documents/2 Areas"
                                       "~/Documents/1 Projects"
                                       "~/Repo"))
;; app email settings
;; Each path is relative to `+email-mu4e-mail-path', which is ~/.mail by default
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu/mu4e")
(setq +mu4e-backend 'offlineimap)
(set-email-account! "arksolutions.it"
    '((mu4e-sent-folder       . "/arksolutions.it/Sent")
      (mu4e-drafts-folder     . "/arksolutions.it/Drafts")
      (mu4e-trash-folder      . "/arksolutions.it/Trash")
      (mu4e-refile-folder     . "/arksolutions.it/INBOX")
      (smtpmail-smtp-user     . "tony@arksolutions.it")
      (user-mail-address      . "tony@arksolutions.it")
      (mu4e-compose-signature . "---\nTony Ampomah"))
    t)

(setq org-gcal-client-id (+pass-get-field "2 Areas/Personal/Emails/gmail.com" "client_id")
      org-gcal-client-secret (+pass-get-field "2 Areas/Personal/Emails/gmail.com" "client_secret")
      org-gcal-file-alist '(((+pass-get-field "2 Areas/Personal/Emails/gmail.com" "tcal").  "~/org/calendar/tcal.org")
                            ((+pass-get-field "2 Areas/Personal/Emails/gmail.com" "gcal").  "~/org/calendar/gcal.org")))
;; Automatically switch to ledger mode for .dat files
(add-to-list 'auto-mode-alist '("\\.dat\\'" . ledger-mode))
