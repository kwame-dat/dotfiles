;;; init-nov.el --- Reading EPUB Books -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
;; Epub Reading Books
(setq nov-text-width t)
(setq visual-fill-column-center-text t)
(use-package nov)
(use-package visual-fill-column)
(add-hook 'nov-mode-hook 'visual-line-mode)
(add-hook 'nov-mode-hook 'visual-fill-column-mode)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
(add-to-list 'auto-mode-alist '("\\.jwpub\\'" . nov-mode))

(provide 'init-nov)
;;; init-nov.el ends here
