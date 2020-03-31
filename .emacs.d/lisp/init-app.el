;;; init-app.el --- Install useful app
;;; Commentary:
;;; Code:
;;----------------------------------------------------------------------------
;; Calendar
;;----------------------------------------------------------------------------
(use-package calfw :defer t)
(use-package calfw-org :defer t)
(use-package calfw-cal :defer t)
(use-package calfw-ical :defer t)
;;----------------------------------------------------------------------------
;; Chat Slack
;;----------------------------------------------------------------------------
(use-package slack
  :defer t
  :init
  (setq slack-buffer-emojify t)
  (setq slack-prefer-current-team t)
  :commands (slack-start))

;;----------------------------------------------------------------------------
;; Epub Reading Books
;;----------------------------------------------------------------------------
(use-package nov
  :defer t
  :init
  (setq nov-text-width t))

(use-package visual-fill-column
  :init
  (setq visual-fill-column-center-text t)
  :defer t)

(add-hook 'nov-mode-hook 'visual-line-mode)
(add-hook 'nov-mode-hook 'visual-fill-column-mode)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
(add-to-list 'auto-mode-alist '("\\.jwpub\\'" . nov-mode))

(require 'init-alert)

(provide 'init-app)
;;; init-app.el ends here
