;; init-php.el -- Configuration for PHP

;;; Commentary:

;;; Code:

(setq-default phpstan-executable 'phpstan)
(setq-default php-mode-coding-style 'psr2)
(use-package php-extras)
(use-package php-mode)
(use-package phpactor)
(use-package phpunit)
(use-package psysh)
(use-package smarty-mode)

(provide 'init-php)
;;; init-php.el ends here
