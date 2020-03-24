;;; init-env.el --- Editing dotenv files -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(use-package dotenv-mode)
(add-to-list 'auto-mode-alist '("\\.env\\..*\\'" . dotenv-mode))

(provide 'init-env)
;;; init-env.el ends here
