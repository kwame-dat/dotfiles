;;; init-flycheck.el --- Initialize Flycheck
;;; Commentary:
;;; Code:
(use-package let-alist)

(use-package flycheck-phpstan)

(use-package flycheck
  :init
  (setq flycheck-php-cs-standard "PSR2")
  (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)
  (setq flycheck-emacs-lisp-load-path 'inherit
        flycheck-check-syntax-automatically '(save idle-change mode-enabled)
        flycheck-idle-change-delay 0.4
        flycheck-disabled-checkers '(php-phpmd)))
(global-flycheck-mode)

(provide 'init-flycheck)
;;; init-flycheck.el ends here
