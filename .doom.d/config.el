(setq doom-localleader-key ",")
(setq display-line-numbers-type 'relative)
(setq doom-theme 'doom-one-light)
(blink-cursor-mode 1)
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

(setq user-full-name "Tony Ampomah"
      user-mail-address "tony@arksolutions.it"

      doom-font (font-spec :family "Office Code Pro" :size 16 :weight 'light)
      doom-big-font (font-spec :family "Office Code Pro" :size 14 :weight 'light)
      doom-variable-pitch-font (font-spec :family "Office Code Pro" :size 14 :weight 'light)

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


;; lang/org
(after! org
  (add-to-list 'org-modules 'org-habit t))
(setq org-directory "~/Repositories/Org"
      org-agenda-files (list org-directory)
      org-ellipsis " ▼ ")
(setq org-startup-folded 'fold)

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

;; (defun my-php-mode-setup ()
;;   "My PHP-mode hook."
;;   (require 'flycheck-phpstan)
;;   (flycheck-mode t))
;; (add-hook 'php-mode-hook 'my-php-mode-setup)
;; (setq-default phpstan-config-file "/phpstan.neon")

;; Projectile
(setq projectile-project-search-path '("~/Repositories"
                                       "~/Downloads"
                                       "~/Desktop"
                                       "~/Documents"))
;; app email settings
;; Each path is relative to `+email-mu4e-mail-path', which is ~/.mail by default
(setq +mu4e-backend 'offlineimap)
(set-email-account! :email "arksolutions.it"
    '((mu4e-sent-folder       . "/arksolutions.it/Sent Mail")
      (mu4e-drafts-folder     . "/arksolutions.it/Drafts")
      (mu4e-trash-folder      . "/arksolutions.it/Trash")
      (mu4e-refile-folder     . "/arksolutions.it/All Mail")
      (smtpmail-smtp-user     . "tony@arksolutions.it")
      (user-mail-address      . "tony@arksolutions.it")
      (mu4e-compose-signature . "---\nTony Ampomah"))
    t)
