;;; init-css.el --- CSS/Less/SASS/SCSS support -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
;; css-mode
(use-package css-mode
  :defer t
  :config
  (setq css-indent-offset 2))

;; scss-mode
(use-package scss-mode
  :defer t
  :config
  (setq scss-compile-at-save nil))

;; less-css-mode
(use-package less-css-mode
  :defer t)

(provide 'init-css)
;;; init-css.el ends here
