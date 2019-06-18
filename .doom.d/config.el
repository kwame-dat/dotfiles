(setq doom-localleader-key ",")
(setq display-line-numbers-type 'relative)
(setq doom-theme 'doom-tomorrow-night)
(blink-cursor-mode 1)
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

(setq user-full-name "Tony Ampomah"
      user-mail-address "tony@arksolutions.it"

      doom-font (font-spec :family "Office Code Pro" :size 14)
      doom-variable-pitch-font (font-spec :family "Office Code Pro" :size 14)

      which-key-idle-delay 0.50
      lsp-ui-sideline-enable nil
      lsp-ui-doc-enable nil)


(when IS-LINUX
  (font-put doom-font :weight 'semi-light))
(when IS-MAC
  (setq ns-use-thin-smoothing t)
  (add-hook 'window-setup-hook #'toggle-frame-maximized))


;;
;;; Keybinds

(map! :m "M-j" #'multi-next-line
      :m "M-k" #'multi-previous-line

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
      (:prefix "n"
        "m" #'+tonyampomah/find-notes-for-major-mode
        "p" #'+tonyampomah/find-notes-for-project))


;;
;;; Modules

(setq +pretty-code-enabled-modes '(emacs-lisp-mode org-mode))

;; app/rss
(add-hook! 'elfeed-show-mode-hook (text-scale-set 2))

;; lang/org
(after! org
  (add-to-list 'org-modules 'org-habit t))
(setq org-directory "~/Repositories/Org"
      org-agenda-files (list org-directory)
      org-ellipsis " ▼ ")

;; lang/php
;; (map! :php-mode-map
;;   "C-]" #'phpactor-find-references)
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



;;
;;; Custom
(def-project-mode! +javascript-screeps-mode
  :match "/screeps\\(?:-ai\\)?/.+$"
  :modes (+javascript-npm-mode)
  :add-hooks (+javascript|init-screeps-mode)
  :on-load (load! "lisp/screeps"))

;;; Modeline
;; (defface mode-line-success-highlight '((t (:inherit mode-line-highlight)))
;;   "TODO")

;; (load! "lisp/modeline")
;; (add-hook! 'doom-load-theme-hook
;;   (set-face-foreground 'mode-line (doom-color 'blue))
;;   (set-face-foreground 'mode-line-buffer-id (doom-color 'fg))
;;   (set-face-background 'mode-line-success-highlight (doom-color 'green)))

;; Projectile
(setq projectile-project-search-path '("~/Repositories/"))

;; app email settings
;; Each path is relative to `+email-mu4e-mail-path', which is ~/.mail by default
;; (set! :email "tony@arksolutions.it"
;;     '((mu4e-sent-folder       . "/tony@arksolutions.it/Sent Mail")
;;       (mu4e-drafts-folder     . "/tony@arksolutions.it/Drafts")
;;       (mu4e-trash-folder      . "/tony@arksolutions.it/Trash")
;;       (mu4e-refile-folder     . "/tony@arksolutions.it/All Mail")
;;       (smtpmail-smtp-user     . "tony@arksolutions.it")
;;       (user-mail-address      . "tony@arksolutions.it")
;;       (mu4e-compose-signature . "---\nTony Ampomah"))
;;     t)
