;;; init-git.el --- Git SCM support -*- lexical-binding: t -*-
;;; Commentary:

;; See also init-github.el.

;;; Code:
(use-package git-blamed)
(use-package gitignore-mode)
(use-package gitconfig-mode)
(use-package git-timemachine)
(use-package magit
  :init
  (setq magit-status-buffer-switch-function 'switch-to-buffer)
  (setq magit-push-always-verify nil)
  (setq git-commit-summary-max-length 50)
  :config
  (use-package evil-magit)
  (use-package with-editor)
  (add-hook 'with-editor-mode-hook 'evil-insert-state)
  :ensure t)

(fullframe magit-status magit-mode-quit-window)

(provide 'init-git)
;;; init-git.el ends here
