;;; init-editorconfig.el --- Ensure editorconfig is passed -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(use-package editorconfig
  :diminish editorconfig-mode
  :ensure t
  :config
  (editorconfig-mode 1))

(provide 'init-editorconfig)
;;; init-editorconfig.el ends here
