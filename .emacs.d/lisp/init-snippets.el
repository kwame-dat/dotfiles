;;; init-snippets.el --- Snippets -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(use-package yasnippet
  :diminish yas-minor-mode
  :ensure t
  :config
  (setq yas-snippet-dirs
        '("~/.emacs.d/snippets"))
  (yas-global-mode 1))

(provide 'init-snippets)
;;; init-snippets.el ends here
