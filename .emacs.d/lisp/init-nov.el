;;; init-nov.el --- Reading EPUB Books -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
;; Epub Reading Books
(use-package nov)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
(add-to-list 'auto-mode-alist '("\\.jwpub\\'" . nov-mode))

(provide 'init-nov)
;;; init-nov.el ends here
