;;; init-flycheck.el --- Initialize Flycheck
;;; Commentary:
;;; Code:
(use-package let-alist
  :ensure t)

(use-package flycheck-phpstan
  :ensure t)

(use-package flycheck
  :init
  (setq flycheck-php-cs-standard "PSR2")
  (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)
  (setq flycheck-emacs-lisp-load-path 'inherit
        flycheck-check-syntax-automatically '(save idle-change mode-enabled)
        flycheck-idle-change-delay 0.8
        flycheck-disabled-checkers '(php-phpmd))
  :ensure t)

(provide 'init-flycheck)
;;; init-flycheck.el ends here
