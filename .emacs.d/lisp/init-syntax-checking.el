;;; init-syntax-checking.el --- syntax-checking -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(use-package flycheck
  :defer t
  :hook (lsp-mode . flycheck-mode)
  :config
  (setq flycheck-emacs-lisp-load-path 'inherit
        flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list
        flycheck-check-syntax-automatically '(save idle-change mode-enabled)
        flycheck-idle-change-delay 0.2
        flycheck-global-modes '(not org-mode)
        flycheck-phpcs-standard "PSR12")
  (global-flycheck-mode))

(defun my-flycheck-setup ()
  (flycheck-add-next-checker 'lsp 'php-phpcs 'php-md))
(add-hook 'php-mode-hook #'my-flycheck-setup)

(provide 'init-syntax-checking)
;;; init-syntax-checking.el ends here
