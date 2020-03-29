;;; init-alert.el --- I need some notification bro
;;; Commentary:
;;; Code:
(use-package alert
  :commands (alert)
  :init
  (setq alert-default-style 'notifier))

(provide 'init-alert)
;;; init-alert.el ends here
