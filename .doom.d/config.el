(setq doom-localleader-key ",")
(setq user-full-name "Tony Ampomah"
      user-mail-address "tony@arksolutions.it"

      doom-scratch-initial-major-mode 'lisp-interaction-mode
      doom-theme 'doom-one
      treemacs-width 32

      ;; Line numbers are pretty slow all around. The performance boost of
      ;; disabling them outweighs the utility of always keeping them on.
      display-line-numbers-type nil

      company-idle-delay nil

      lsp-ui-sideline-enable nil
      lsp-enable-symbol-highlighting nil
      +lsp-prompt-to-install-server nil


      which-key-idle-delay 0.40
      web-mode-markup-indent-offset 2
      web-mode-code-indent-offset 2
      web-mode-css-indent-offset 2
      js-indent-level 2
      typescript-indent-level 2
      json-reformat:indent-width 2
      css-indent-offset 2
      prettier-js-args '("--single-quote")
      dired-dwim-target t


      ;; More common use-case
      evil-ex-substitute-global t)


;;
;;; UI
;; Prevents some cases of Emacs flickering
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))


;;
;;; Keybinds

(map! :n [tab] (cmds! (and (featurep! :editor fold)
                           (save-excursion (end-of-line) (invisible-p (point))))
                      #'+fold/toggle
                      (fboundp 'evil-jump-item)
                      #'evil-jump-item)
      :v [tab] (cmds! (and (bound-and-true-p yas-minor-mode)
                           (or (eq evil-visual-selection 'line)
                               (not (memq (char-after) (list ?\( ?\[ ?\{ ?\} ?\] ?\))))))
                      #'yas-insert-snippet
                      (fboundp 'evil-jump-item)
                      #'evil-jump-item)

      :g "s-/" #'comment-line
      :g "H-p" #'projectile-find-file
      :g "H-b" #'ivy-switch-buffer
      :g "H-P" #'projectile-switch-project
      :g "H-q" #'save-buffers-kill-emacs
      :g "H-k" #'kill-buffer
      :g "H-x" #'kill-region
      :g "H-s" #'save-buffer


      ;; Easier window movement
      :n "C-h" #'evil-window-left
      :n "C-j" #'evil-window-down
      :n "C-k" #'evil-window-up
      :n "C-l" #'evil-window-right


  ;; (evil-collection-define-key 'normal 'dired-mode-map
  ;;   "h" 'dired-single-up-directory
  ;;   "l" 'dired-single-buffer))

      (:after dired
       :map dired-mode-map
       :n "q" #'quit-window
       :n "v" #'evil-visual-char
       :nv "j" #'dired-next-line
       :nv "k" #'dired-previous-line
       :n "h" #'dired-up-directory
       :n "l" #'dired-find-file
       :n "#" #'dired-flag-auto-save-files
       :n "." #'evil-repeat
       :n "~" #'dired-flag-backup-files
       ;; Comparison commands
       :n "=" #'dired-diff
       :n "|" #'dired-compare-directories
       ;; move to marked files
       :m "[m" #'dired-prev-marked-file
       :m "]m" #'dired-next-marked-file
       :m "[d" #'dired-prev-dirline
       :m "]d" #'dired-next-dirline
       ;; Lower keys for commands not operating on all the marked files
       :desc "wdired" :n "w" #'wdired-change-to-wdired-mode
       :n "a" #'dired-find-alternate-file
       :nv "d" #'dired-flag-file-deletion
       :n "K" #'dired-do-kill-lines
       :n "r" #'dired-do-redisplay
       :nv "m" #'dired-mark
       :nv "t" #'dired-toggle-marks
       :nv "u" #'dired-unmark           ; also "*u"
       :nv "p" #'dired-unmark-backward
       ;; :n "W" #'browse-url-of-dired-file
       :n "x" #'dired-do-flagged-delete
       :n "y" #'dired-copy-filename-as-kill
       :n "Y" (cmd! (dired-copy-filename-as-kill 0))
       :n "+" #'dired-create-directory
       :n "O" #'dired-open-mac
       :n "o" #'dired-preview-mac
       ;; hiding
       :n "<tab>" #'dired-hide-subdir ;; FIXME: This can probably live on a better binding.
       :n "<backtab>" #'dired-hide-all
       :n "$" #'dired-hide-details-mode
       ;; misc
       :n "U" #'dired-undo
       ;; subtree
       )

      :leader
      "f t" #'counsel-tramp
      "f vs" #'+kwame-dat/visit-ssh-config
      "f vh" #'+kwame-dat/visit-host-file
      "f vr" #'+kwame-dat/visit-resolv-config
      "f ve" #'+kwame-dat/visit-emacs-config
      "f vd" #'+kwame-dat/visit-dwm-config)

;; (evil-collection-define-key 'normal 'dired-mode-map
;;     "h" 'dired-up-directory
;;     "l" 'dired-find-file)

;;
;;; Modules

(after! ivy
  ;; I prefer search matching to be ordered; it's more precise
  (add-to-list 'ivy-re-builders-alist '(counsel-projectile-find-file . ivy--regex-plus)))

;; Switch to the new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)


;; projectile
(setq projectile-project-search-path '(
                                       "~/Repo/Work/2Areas/modules"
                                       "~/Repo/Work/2Areas/elico-docker/services"
                                       "~/Repo/Work/2Areas/elico-docker/sites"
                                       "~/Nextcloud/Documents/Work/2Areas"
                                       "~/Nextcloud/Documents/Work/1Projects"

                                       "~/Repo/Work/2Areas"
                                       "~/Repo/Work/1Projects"
                                       "~/Nextcloud/Documents/Joint/2Areas"
                                       "~/Nextcloud/Documents/Joint/1Projects"

                                       "~/Nextcloud/Documents/Spiritual/3Resources"
                                       "~/Nextcloud/Documents/Spiritual/2Areas"
                                       "~/Nextcloud/Documents/Spiritual/1Projects"

                                       "~/Repo/Personal/3Resources"
                                       "~/Nextcloud/Documents/Personal/2Areas"
                                       "~/Repo/Personal/2Areas"
                                       "~/Nextcloud/Documents/Personal/1Projects"
                                       "~/Repo/Personal/1Projects"
                                       ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; :tools
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; :lang org
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq
      org-directory "~/Nextcloud/org/"
      org-archive-location (concat org-directory ".archive/%s::")
      org-roam-directory (concat org-directory "notes/")
      org-roam-db-location (concat org-roam-directory ".org-roam.db")
      org-journal-encrypt-journal t
      org-journal-file-format "%Y%m%d.org"
      org-startup-folded 'overview
      org-ellipsis " [...] ")

;;; :ui doom-dashboard
(setq fancy-splash-image (concat doom-private-dir "splash.png"))
;; Don't need the menu; I know them all by heart
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

;; ledger
(setq ledger-post-amount-alignment-column 70)

;;
;;; Language customizations

(custom-theme-set-faces! 'doom-one
  `(markdown-code-face :background ,(doom-darken 'bg 0.075))
  `(font-lock-variable-name-face :foreground ,(doom-lighten 'magenta 0.6)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mu4e
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq mu4e-maildir "~/Maildir")

(setq send-mail-function 'smtpmail-send-it)

;; Default account on startup
(setq user-full-name  "Tony Ampomah"
      mu4e-sent-folder "/tony@arksolutions.it/Sent"
      mu4e-drafts-folder "/tony@arksolutions.it/Drafts"
      mu4e-trash-folder "/tony@arksolutions.it/Trash")

;; This is set to 't' to avoid mail syncing issues when using mbsync
(setq mu4e-change-filenames-when-moving t)

;; Refresh mail using isync every 10 minutes
(setq mu4e-update-interval (* 10 60))
(setq smtpmail-debug-info t
      message-kill-buffer-on-exit t
      ;; Custom script to run offlineimap in parallel for multiple
      ;; accounts as discussed here:
      ;; http://www.offlineimap.org/configuration/2016/01/29/why-i-m-not-using-maxconnctions.html
      ;; This halves the time for checking mails for 4 accounts for me
      ;; (when nothing has to be synched anyway)
      mu4e-get-mail-command "mbsync -a"
      mu4e-attachment-dir "~/Downloads")


;; show full addresses in view message (instead of just names)
;; toggle per name with M-RET
(setq mu4e-view-show-addresses t)

;; Do not show related messages by default (toggle with =W= works
;; anyway)
(setq mu4e-headers-include-related nil)

;; Alternatives are the following, however in first tests they
;; show inferior results
;; (setq mu4e-html2text-command "textutil -stdin -format html -convert txt -stdout")
;; (setq mu4e-html2text-command "html2text -utf8 -width 72")
;; (setq mu4e-html2text-command "w3m -dump -T text/html")

(defvar my-mu4e-account-alist
  '(("tony@arksolutions.it"
     (user-full-name  "Tony Ampomah")
     (mu4e-compose-signature . (concat "Many thanks\n" "Tony\n"))
     (mu4e-compose-signature-auto-include t)
     (mu4e-sent-folder "/tony@arksolutions.it/Sent")
     (mu4e-drafts-folder "/tony@arksolutions.it/Drafts")
     (mu4e-trash-folder "/tony@arksolutions.it/Trash")
     (user-mail-address "tony@arksolutions.it")
     (smtpmail-default-smtp-server "smtp.zoho.com")
     (smtpmail-local-domain "zoho.com")
     (smtpmail-smtp-user "tony@arksolutions.it")
     (smtpmail-smtp-server "smtp.zoho.com")
     (smtpmail-stream-type starttls)
     (smtpmail-smtp-service 587))

    ("tony.ampomah.jw@gmail.com"
     (user-full-name  "Tony Ampomah")
     (mu4e-compose-signature . (concat
                                "Warm love\n"
                                "Tony\n"))
     (mu4e-compose-signature-auto-include t)
     (mu4e-sent-folder "/tony.ampomah.jw@gmail.com/[Gmail].Sent Mail")
     (mu4e-drafts-folder "/tony.ampomah.jw@gmail.com/[Gmail].Drafts")
     (mu4e-trash-folder "/tony.ampomah.jw@gmail.com/[Gmail].Trash")
     (user-mail-address "tony.ampomah.jw@gmail")
     (smtpmail-default-smtp-server "smtp.gmail.com")
     (smtpmail-local-domain "gmail.com")
     (smtpmail-smtp-user "tony.ampomah.jw@gmail.com")
     (smtpmail-smtp-server "smtp.gmail.com")
     (smtpmail-stream-type starttls)
     (smtpmail-smtp-service 587))
    ))

;; Whenever a new mail is to be composed, change all relevant
;; configuration variables to the respective account. This method is
;; taken from the MU4E documentation:
;; http://www.djcbsoftware.nl/code/mu/mu4e/Multiple-accounts.html#Multiple-accounts
(defun my-mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((account
          (if mu4e-compose-parent-message
              (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
                (string-match "/\\(.*?\\)/" maildir)
                (match-string 1 maildir))
            (completing-read (format "Compose with account: (%s) "
                                     (mapconcat #'(lambda (var) (car var))
                                                my-mu4e-account-alist "/"))
                             (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
                             nil t nil nil (caar my-mu4e-account-alist))))
         (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
        (mapc #'(lambda (var)
                  (set (car var) (cadr var)))
              account-vars)
      (error "No email account found"))))


(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)
(add-hook 'mu4e-compose-mode-hook (lambda ()
                                    (ispell-change-dictionary "en_GB")))

(setq mu4e-trash-folder
      (lambda (msg)
        (cond
         ((string-match "^/tony@arksolutions.it.*"
                        (mu4e-message-field msg :maildir))
          "/tony@arksolutions.it/Trash")
         ;; everything else goes to /archive
         (t  "/archive"))))

(setq mu4e-refile-folder
      (lambda (msg)
        (cond
         ((string-match "^/tony@arksolutions.it.*"
                        (mu4e-message-field msg :maildir))
          "/tony@arksolutions.it/4Archives")
         ((string-match "^/tony.ampomah.jw@gmail.com*"
                        (mu4e-message-field msg :maildir))
          "/tony.ampomah.jw@gmail.com/4Archives")
         ((string-match "^/tampomah@emporium.co.uk*"
                        (mu4e-message-field msg :maildir))
          "/tampomah@emporium.co.uk/Archive")
         ((string-match "^/itechytony@gmail.com.*"
                        (mu4e-message-field msg :maildir))
          "/itechytony@gmail.com/4Archives")
         ;; everything else goes to /archive
         (t  "/archive"))))

;; use org structures and tables in message mode
;; (add-hook 'message-mode-hook 'turn-on-orgstruct++)
(add-hook 'message-mode-hook 'visual-fill-column-mode)

;; view HTML email in browser
;; (add-to-list 'mu4e-view-actions '("ViewInBrowser" . mu4e-action-view-in-browser) t)

;; display unread email on mode line
;; (add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display)
