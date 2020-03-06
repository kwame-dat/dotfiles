;;; init-javascript.el --- Support for Javascript and derivatives -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(setq js-indent-level 2)
(add-hook 'coffee-mode-hook
          (lambda ()
            (yas-minor-mode 1)
            (setq coffee-tab-width 2)))
(use-package json-mode)
(use-package js2-mode)
(use-package coffee-mode)
;; (use-package typescript-mode)
(use-package prettier-js)

(provide 'init-javascript)
;;; init-javascript.el ends here
