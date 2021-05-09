;;; init-javascript.el --- Javascript -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq js-indent-level 2)
(add-hook 'coffee-mode-hook
          (lambda ()
            (yas-minor-mode 1)
            (setq coffee-tab-width 2)))

(use-package json-mode
  :defer t)
(use-package js2-mode
  :defer t)
(use-package coffee-mode
  :defer t)
(use-package typescript-mode
  :defer t)
(use-package prettier-js
  :defer t)

(provide 'init-javascript)
;;; init-javascript.el ends here
