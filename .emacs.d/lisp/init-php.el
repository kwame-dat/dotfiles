;; init-php.el -- My best friend PHP config
;;; Commentary:
;;; Code:

(setq-default phpstan-executable 'phpstan)
(setq-default php-mode-coding-style 'psr2)
(use-package php-extras)
(use-package php-mode)
(use-package phpactor)
(use-package phpunit)
(use-package psysh)

(provide 'init-php)
;;; init-php.el ends here
