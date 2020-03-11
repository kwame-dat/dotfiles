;;; init-apps.el --- Install useful apps
;;; Commentary:
;;: Code:

;; Epub Reading Books
(setq nov-text-width 70)
(setq visual-fill-column-center-text t)
(use-package nov)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
(defun my-nov-font-setup ()
  (face-remap-add-relative 'variable-pitch :family "Avenir"
                           :height 1.5))
(add-hook 'nov-mode-hook 'my-nov-font-setup)
(add-hook 'nov-mode-hook 'visual-line-mode)
;; (add-hook 'nov-mode-hook 'visual-fill-column-mode)

;; Write
(use-package synosaurus
  :config
  (global-set-key (kbd "s-|") 'powerthesaurus-lookup-word-dwim))

;; slack
(use-package slack
  :commands (slack-start)
  :init
  (setq slack-buffer-emojify t) ;; if you want to enable emoji, default nil
  (setq slack-prefer-current-team t)
  :config

  (slack-register-team
   :name "emacs-slack"
   :default t
   :client-id ""
   :client-secret ""
   :token ""
   :subscribed-channels '(devz general random team-backend ccs-new suite-3))

  (evil-define-key 'normal slack-info-mode-map
    ",u" 'slack-room-update-messages)
  (evil-define-key 'normal slack-mode-map
    ",c" 'slack-buffer-kill
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
    ",3" 'slack-message-embed-channel))

;; alerts
(use-package alert
  :commands (alert)
  :init
  (setq alert-default-style 'notifier))

;; elasticseach client
(use-package es-mode)
(autoload 'es-mode "es-mode.el"
  "Major mode for editing Elasticsearch queries" t)
(add-to-list 'auto-mode-alist '("\\.es$" . es-mode))

;; redis client
(use-package eredis)

;; dash
(use-package dash-at-point)
(autoload 'dash-at-point "dash-at-point"
  "Search the word at point with Dash." t nil)
(global-set-key "\C-cd" 'dash-at-point)
(global-set-key "\C-ce" 'dash-at-point-with-docset)

(provide 'init-apps)
;;; init-apps.el ends here
