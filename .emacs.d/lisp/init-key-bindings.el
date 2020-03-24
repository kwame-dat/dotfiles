;;; init-key-bindings.el --- Key bindings
;;; Commentary:
;;; Code:
(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'super)

;; Keybonds
(global-set-key [(super a)] 'mark-whole-buffer)
(global-set-key [(super v)] 'yank)
(global-set-key [(super c)] 'kill-ring-save)
(global-set-key [(super s)] 'save-buffer)
(global-set-key [(super l)] 'goto-line)
(global-set-key [(super w)]
                (lambda () (interactive) (delete-window)))
(global-set-key [(super z)] 'undo)

(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "s-r") 'counsel-imenu)
(global-set-key (kbd "s-b") 'counsel-switch-buffer)
(global-set-key (kbd "s-/") 'comment-line)
(global-set-key (kbd "s-F") 'counsel-projectile-rg)
(global-set-key (kbd "s-f") 'swiper-isearch)
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))
(global-set-key (kbd "s-o") (kbd "C-x o"))
(global-set-key (kbd "<escape>")      'keyboard-escape-quit)
(global-set-key (kbd "s-w") (kbd "C-x 0"))
(global-set-key (kbd "s-p") 'counsel-projectile-find-file)
(global-set-key (kbd "s-P") 'projectile-switch-project)
(global-set-key (kbd "s-q") 'save-buffers-kill-emacs)
(global-set-key (kbd "s-k") 'kill-this-buffer)

(global-set-key (kbd "s-1")   'eyebrowse-switch-to-window-config-1)
(global-set-key (kbd "s-2" )  'eyebrowse-switch-to-window-config-2)
(global-set-key (kbd "s-3" )  'eyebrowse-switch-to-window-config-3)
(global-set-key (kbd "s-4" )  'eyebrowse-switch-to-window-config-4)
(global-set-key (kbd "s-5" )  'eyebrowse-switch-to-window-config-5)
(global-set-key (kbd "s-6" )  'eyebrowse-switch-to-window-config-6)
(global-set-key (kbd "s-7" )  'eyebrowse-switch-to-window-config-7)
(global-set-key (kbd "s-8" )  'eyebrowse-switch-to-window-config-8)
(global-set-key (kbd "s-9" )  'eyebrowse-switch-to-window-config-9)

(defun itechytony/config-evil-leader ()
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    ;; application
    "acs" 'slack-start
    "acj" 'slack-channel-select
    "acd" 'slack-im-select
    "acq" 'slack-ws-close
    "app" 'password-store-copy
    "apf" 'password-store-get-field
    "apd" 'password-store-remove
    "apr" 'password-store-rename
    "ape" 'password-store-edit
    ;; workspaces
    "<tab><tab>" 'eyebrowse-switch-to-window-config
    "<tab>c" 'eyebrowse-new-workspace
    "<tab>." 'eyebrowse-switch-back-and-forth
    "<tab>n" 'eyebrowse-new-workspace
    "<tab>d" 'eyebrowse-projectile-remove-project
    "<tab>k" 'eyebrowse-projectile-kill-buffer-and-window
    "<tab>r" 'eyebrowse-rename-window-config
    "<tab>[" 'eyebrowse-prev-window-config
    "<tab>]" 'eyebrowse-next-window-config
    ;; files
    "fc"  'editorconfig-find-current-editorconfig
    "fC"  'itecytony/copy-this-file
    "fR"  'projectile-recentf
    "fD"  'itechytony/delete-this-file
    "fd" 'dired
    "ff"  'counsel-find-file
    "fe"  '+default/find-in-emacsd
    "fE"  '+default/browse-emacsd
    "fF"  '+default/find-file-under-here
    "fh"  'itechytony/visit-host-file
    "fu"  'itechytony/sudo-find-file
    "fU"  'itechytony/sudo-this-file
    "fy"  'default/yank-buffer-filename
    "fl"  'locate
    "fp"  'itechytony/visit-emacs-config
    "fr"  'recentf-open-files
    "fs"  'save-buffer
    "fS"  'write-file
    "ft"  'itechytony/visit-todo-list-file
    ;; buffers
    "bb"  'counsel-switch-buffer
    "bB"  'counsel-ibuffer
    "bk"  'kill-this-buffer
    "bd"  'kill-this-buffer
    "bq"  'kill-buffer-and-window
    ;; search
    "sb" 'swiper-isearch
    "sp" 'counsel-projectile-rg
    ;; git
    "gR"  'vc-revert
    "gg"  'magit-status
    "gb"  'magit-branch-checkout
    "gR"  'vc-revert
    "g/"  'magit-dispatch
    "gD"  'magit-file-delete
    "gB"  'magit-blame-addition
    "gC"  'magit-clone
    "gF"  'magit-fetch
    "gL"  'magit-log
    "gS"  'magit-stage-file
    "gU"  'magit-unstage-file
    ;; toggle
    "ts"  'treemacs
    "tc"  'company-mode
    "tf"  'flycheck-mode
    "tr"  'nlinum-mode
    "ttl"  'toggle-truncate-lines
    "tvl"  'global-visual-line-mode
    "te"  'global-emojify-mode
    ;; projects
    "pp"  'projectile-switch-project
    "pi"  'projectile-invalidate-cache
    "pt"  'projectile-run-vterm
    "pb"  'projectile-switch-to-buffer
    "ps"  'counsel-projectile-rg
    "pB"  'counsel-switch-buffer
    "pd"  'projectile-discover-projects-in-search-path
    ;; notes
    "nf" 'itechytony/find-in-notes
    "na" 'org-agenda
    "nci" 'org-pomodoro
    "nco" 'org-pomodoro-clock-break
    "nn" 'itechytony/find-in-notes
    "nn" 'org-capture
    "nt" 'itechytony/visit-todo-list-file
    "ni" 'itechytony/visit-inbox
    "nv" 'org-search-view
    ":"  'eval-expression
    "cc"  'compile
    "<SPC>"  'counsel-projectile-find-file
    "/r"  'counsel-imenu
    "/sp"  'counsel-rg
    ;; insert
    "ie" 'emoji-cheat-sheet-plus-insert
    ;; window
    "w"  'evil-window-map
    ;; help
    "h"  'help-map
    ;; open application
    "o-" 'dired-jump
    "oc" 'cfw:open-org-calendar
    "oo" '+macos/reveal-in-finder
    "om" 'mu4e
    "od"  'docker
    "op"  'pass
    "oe"  'es-command-center
    "oe"  'es-command-center
    "ot" 'shell-pop
    "oT" 'vterm-toggle
    "x"  'counsel-M-x))

(defun itechytony/apply-evil-other-package-configs ()
  "Apply evil-dependent settings specific to other packages."
  ;; PHP
  (evil-define-key 'normal php-mode-map (kbd ", tt") 'phpunit-current-test)
  (evil-define-key 'normal php-mode-map (kbd ", tp") 'phpunit-current-project)
  (evil-define-key 'normal php-mode-map (kbd ", tc") 'phpunit-current-class)
  (evil-define-key 'normal php-mode-map (kbd ", n") 'phpactor-create-new-class)
  (evil-define-key 'normal php-mode-map (kbd ", m") 'phpactor-move-class)
  (evil-define-key 'normal php-mode-map (kbd ", i") 'phpactor-import-class)
  (evil-define-key 'normal php-mode-map (kbd ", f") 'php-search-documentation)
  (evil-define-key 'normal php-mode-map (kbd ", r") 'counsel-imenu)

  ;; Org Mode
  (evil-define-key 'normal org-mode-map (kbd ", c") 'org-ctrl-c-ctrl-c)
  (evil-define-key 'normal org-mode-map (kbd ", t") 'org-todo)
  (evil-define-key 'normal org-mode-map (kbd ", s") 'org-schedule)
  (evil-define-key 'normal org-mode-map (kbd ", d") 'org-deadline)
  (evil-define-key 'normal org-mode-map (kbd ", a") 'org-agenda)
  (evil-define-key 'normal org-mode-map (kbd ", e") 'org-export-dispatch)
  (evil-define-key 'normal org-mode-map (kbd ", n") 'org-narrow-to-element)
  (evil-define-key 'normal org-mode-map (kbd ", w") 'widen)
  (evil-define-key 'normal org-mode-map (kbd ", r") 'org-refile)

  ;; Ledger Mode
  (evil-define-key 'normal ledger-mode-map (kbd ", a") 'ledger-add-transaction)

  ;; Easy window movement
  (evil-define-key 'normal global-map (kbd "C-j") 'evil-window-down)
  (evil-define-key 'normal global-map (kbd "C-h") 'evil-window-left)
  (evil-define-key 'normal global-map (kbd "C-k") 'evil-window-up)
  (evil-define-key 'normal global-map (kbd "C-l") 'evil-window-right)

  ;; Slack mode
  (evil-define-key 'normal slack-mode-map
    (kbd ",j") 'slack-channel-select
    (kbd ",d") 'slack-im-select
    (kbd ",p") 'slack-room-load-prev-messages
    (kbd ",e") 'slack-message-edit
    (kbd ",q") 'slack-ws-close
    (kbd ",mm") 'slack-message-embed-mention
    (kbd ",c") 'slack-message-embed-channel
    (kbd ",k") 'slack-channel-select
    (kbd ",@") 'slack-message-embed-mention
    (kbd ",j") 'slack-channel-select
    (kbd ",#") 'slack-message-embed-channel
    (kbd ",u") 'slack-room-update-messages
    ",q" 'slack-buffer-kill
    ",ra" 'slack-message-add-reaction
    ",rr" 'slack-message-remove-reaction
    ",rs" 'slack-message-show-reaction-users
    ",pl" 'slack-room-pins-list
    ",pa" 'slack-message-pins-add
    ",pr" 'slack-message-pins-remove
    ",mm" 'slack-message-write-another-buffer
    ",me" 'slack-message-edit
    ",md" 'slack-message-delete
    ",u" 'slack-room-update-messages
    ",2" 'slack-message-embed-mention
    ",3" 'slack-message-embed-channel
    "\C-n" 'slack-buffer-goto-next-message
    "\C-p" 'slack-buffer-goto-prev-message)

  (evil-define-key 'normal slack-edit-message-mode-map
    ",k" 'slack-message-cancel-edit
    ",s" 'slack-message-send-from-buffer
    ",2" 'slack-message-embed-mention
    ",3" 'slack-message-embed-channel)

  ;; Dired
  (evil-define-key 'normal dired-mode-map
    (kbd "C-e") 'dired-toggle-read-only
    (kbd "j") 'dired-next-line
    (kbd "k") 'dired-previous-line))

(provide 'init-key-bindings)
;;; init-key-bindings.el ends here
