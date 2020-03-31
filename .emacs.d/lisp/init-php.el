;; init-php.el -- My best friend PHP config
;;; Commentary:
;;; Code:
(use-package php-mode
  :init
  (setq-default php-mode-coding-style 'psr2)
  :defer t
  :ensure t)

(use-package phpactor
  :defer t
  :ensure t)

(use-package phpstan
  :init
  (setq-default phpstan-executable 'phpstan)
  :defer t
  :ensure t)

(use-package phpunit
  :defer t
  :ensure t)

(use-package psysh
  :defer t
  :ensure t)

(provide 'init-php)
;;; init-php.el ends here
