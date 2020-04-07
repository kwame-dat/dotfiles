;; init-php.el -- My best friend PHP config
;;; Commentary:
;;; Code:
(use-package php-mode
  :init
  (setq-default php-mode-coding-style 'psr2)
  :ensure t)

(use-package phpactor
  :ensure t)

(use-package phpstan
  :init
  (setq-default phpstan-executable 'phpstan)
  :ensure t)

(use-package phpunit
  :ensure t)

(use-package psysh
  :ensure t)

(provide 'init-php)
;;; init-php.el ends here
