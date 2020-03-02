;;; init-key-bindings.el --- Key bindings
;;; Commentary:

;;; Commentary:
;;
;;
;;
;;; Code:
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "s-y") 'counsel-yank-pop)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "s-r") 'counsel-imenu)
(global-set-key (kbd "s-b") 'counsel-switch-buffer)
(global-set-key (kbd "s-/") 'comment-line)
(global-set-key (kbd "s-F") 'counsel-rg)
(global-set-key (kbd "s-f") 'swiper-isearch)

(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'super)
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))
(global-set-key (kbd "s-o") (kbd "C-x o"))
(global-set-key (kbd "<escape>")      'keyboard-escape-quit)
(global-set-key (kbd "s-w") (kbd "C-x 0"))
(global-set-key (kbd "s-p") 'projectile-find-file)
(global-set-key (kbd "s-P") 'projectile-persp-switch-project)
(global-set-key (kbd "s-q") 'save-buffers-kill-emacs)
(global-set-key (kbd "s-k") 'kill-this-buffer)

;; Keybonds
(global-set-key [(super a)] 'mark-whole-buffer)
(global-set-key [(super v)] 'yank)
(global-set-key [(super c)] 'kill-ring-save)
(global-set-key [(super s)] 'save-buffer)
(global-set-key [(super l)] 'goto-line)
(global-set-key [(super w)]
                (lambda () (interactive) (delete-window)))
(global-set-key [(super z)] 'undo)

(defun itechytony/config-evil-leader ()
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    ;; workspaces
    "<tab><tab>" 'persp-switch
    "<tab>c" 'persp-switch
    "<tab>." 'persp-switch
    "<tab>s" 'persp-switch
    "<tab>n" 'persp-switch
    "<tab>d" 'persp-kill
    "<tab>k" 'persp-kill
    "<tab>r" 'persp-rename
    "<tab>R" 'persp-state-restore
    "<tab>[" 'persp-prev
    "<tab>]" 'persp-next
    "<tab>S" 'persp-state-save
    "<tab>L" 'persp-state-load
    ;; files
    "fR"  'projectile-recentf
    "fdd" 'itechytony/find-in-documents
    "fdp" 'itechytony/find-projects-in-documents
    "fda" 'itechytony/find-areas-in-documents
    "fdr" 'itechytony/find-resources-in-documents
    "ff"  'find-file
    "fh"  'itechytony/visit-host-file
    "fl"  'locate
    "fp"  'itechytony/visit-emacs-config
    "fr"  'recentf-open-files
    "fs"  'save-buffer
    "fS"  'write-file
    "ft"  'itechytony/visit-todo-list-file
    ;; buffers
    "bb"  'persp-counsel-switch-buffer
    "bB"  'ibuffer
    "bk"  'kill-buffer
    "bd"  'kill-buffer
    ;; search
    "sb" 'swiper-isearch
    "sp" 'projectile-ag
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
    "pp"  'projectile-persp-switch-project
    "pi"  'projectile-invalidate-cache
    "pt"  'projectile-run-vterm
    "pb"  'projectile-switch-to-buffer
    "ps"  'projectile-rg
    "pB"  'persp-buffers
    "pd"  'projectile-discover-projects-in-search-path
    ;; notes
    "nf" 'itechytony/find-in-notes
    "na" 'org-agenda
    "np" 'org-pomodoro
    "nn" 'itechytony/find-in-notes
    "nc" 'org-capture
    "nt" 'itechytony/visit-todo-list-file
    "ni" 'itechytony/visit-inbox
    "nv" 'org-search-view
    ":"  'eval-expression
    "cc"  'compile
    "<SPC>"  'projectile-find-file
    "/r"  'counsel-imenu
    "/sp"  'counsel-rg
    ;; insert
    "ie" 'emoji-cheat-sheet-plus-insert
    ;; window
    "w"  'evil-window-map
    ;; help
    "h"  'help-map
    ;; open application
    "oD" 'docker
    "od" 'docker
    "oesc" 'es-command-center
    "oc" 'calender
    "o-" 'dired-jump
    "oo" '+macos/reveal-in-finder
    "opp"  'pass
    "opcc"  'password-store-copy
    "opcf"  'password-store-copy-field
    "opi"  'password-store-insert
    "opg"  'password-store-generate
    "opd"  'password-store-remove
    "opr"  'password-store-rename
    "ope"  'password-store-edit
    "om"  'mu4e
    "ot"  'shell-pop
    "oT"  'vterm-toggle
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

  ;; Dired
  (evil-define-key 'normal dired-mode-map (kbd "C-e") 'dired-toggle-read-only))

; ;; Highlights all matches of the selection in the buffer.
; (define-key evil-visual-state-map "R" 'evil-multiedit-match-all)

; ;; Match the word under cursor (i.e. make it an edit region). Consecutive presses will
; ;; incrementally add the next unmatched match.
; (define-key evil-normal-state-map (kbd "M-d") 'evil-multiedit-match-and-next)
; ;; Match selected region.
; (define-key evil-visual-state-map (kbd "M-d") 'evil-multiedit-match-and-next)
; ;; Insert marker at point
; (define-key evil-insert-state-map (kbd "M-d") 'evil-multiedit-toggle-marker-here)

; ;; Same as M-d but in reverse.
; (define-key evil-normal-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)
; (define-key evil-visual-state-map (kbd "M-D") 'evil-multiedit-match-and-prev)

; ;; OPTIONAL: If you prefer to grab symbols rather than words, use
; ;; `evil-multiedit-match-symbol-and-next` (or prev).

; ;; Restore the last group of multiedit regions.
; (define-key evil-visual-state-map (kbd "C-M-D") 'evil-multiedit-restore)

; ;; RET will toggle the region under the cursor
; (define-key evil-multiedit-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)

; ;; ...and in visual mode, RET will disable all fields outside the selected region
; (define-key evil-motion-state-map (kbd "RET") 'evil-multiedit-toggle-or-restrict-region)

; ;; For moving between edit regions
; (define-key evil-multiedit-state-map (kbd "C-n") 'evil-multiedit-next)
; (define-key evil-multiedit-state-map (kbd "C-p") 'evil-multiedit-prev)
; (define-key evil-multiedit-insert-state-map (kbd "C-n") 'evil-multiedit-next)
; (define-key evil-multiedit-insert-state-map (kbd "C-p") 'evil-multiedit-prev)

; ;; Ex command that allows you to invoke evil-multiedit with a regular expression, e.g.
; (evil-ex-define-cmd "ie[dit]" 'evil-multiedit-ex-match)

(provide 'init-key-bindings)
;;; init-key-bindings.el ends here
