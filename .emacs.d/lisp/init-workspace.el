;;; init-workspace.el -- Workspace installation and configuration
;;; Commentary:
;;; Code:
(use-package perspective
  :ensure t
  :config
  (persp-mode))

(use-package persp-projectile
  :ensure t)

(provide 'init-workspace)
;;; init-workspace.el ends here
