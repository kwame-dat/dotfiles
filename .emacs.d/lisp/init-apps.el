;;; init-apps.el --- Install useful apps
;;; Commentary:
;;: Code:
;; Write
(use-package synosaurus
  :config
  (global-set-key (kbd "s-|") 'powerthesaurus-lookup-word-dwim))

;; alerts
(use-package alert
  :commands (alert)
  :init
  (setq alert-default-style 'notifier))

(provide 'init-apps)
;;; init-apps.el ends here
