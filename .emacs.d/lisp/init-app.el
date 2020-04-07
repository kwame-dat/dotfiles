;;; init-app.el --- Install useful app
;;; Commentary:
;;; Code:
;;----------------------------------------------------------------------------
;; Calendar
;;----------------------------------------------------------------------------
(use-package calfw)
(use-package calfw-org)
(use-package calfw-cal)
(use-package calfw-ical)
;;----------------------------------------------------------------------------
;; Chat Slack
;;----------------------------------------------------------------------------
(use-package slack
  :init
  (setq slack-buffer-emojify t)
  (setq slack-prefer-current-team t)
  :commands (slack-start))

;;----------------------------------------------------------------------------
;; Epub Reading Books
;;----------------------------------------------------------------------------
(use-package nov
  :init
  (setq nov-text-width t))

(use-package visual-fill-column
  :init
  (setq visual-fill-column-center-text t))

(add-hook 'nov-mode-hook 'visual-line-mode)
(add-hook 'nov-mode-hook 'visual-fill-column-mode)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
(add-to-list 'auto-mode-alist '("\\.jwpub\\'" . nov-mode))

(require 'init-alert)

(provide 'init-app)
;;; init-app.el ends here
