;; init-php.el -- Configuration for PHP

;;; Commentary:

;;; Code:
(use-package php-mode
  :init
  (setq-default phpstan-executable 'phpstan)
  (setq-default php-mode-coding-style 'psr2)
  (setq-default flycheck-phpcs-standard "PSR2")
  (setq php-template-compatibility nil)
  :ensure t)

;; (use-package php-extras
;;   :ensure t)

(use-package phpunit
  :ensure t)

;; (use-package phpactor
;;   :ensure t)

(provide 'init-php)
;;; init-php.el ends here
