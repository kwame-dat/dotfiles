;;; init-flycheck.el --- Initialize Flycheck
;;; Commentary:
;;; Code:
(setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)
(setq flycheck-emacs-lisp-load-path 'inherit
      flycheck-check-syntax-automatically '(save idle-change mode-enabled)
      flycheck-idle-change-delay 0.4)

(setq flycheck-global-modes '(not org-mode))
(setq flycheck-phpcs-standard "PSR2")
(use-package let-alist)
(use-package flycheck)
(global-flycheck-mode)
(use-package flycheck-phpstan)

(defun my-php-mode-setup ()
  "My PHP-mode hook."
  (require 'flycheck-phpstan)
  (flycheck-mode t))

(add-hook 'php-mode-hook 'my-php-mode-setup)

(provide 'init-flycheck)
;;; init-flycheck.el ends here
