;;; init-workspace.el -- Workspace installation and configuration
;;; Commentary:
;;; Code:
(use-package eyebrowse                  ; Easy workspaces creation and switching
  :ensure t
  :config
  (setq eyebrowse-new-workspace t)
  (eyebrowse-mode t))
(require 'eyebrowse-projectile)

(provide 'init-workspace)
;;; init-workspace.el ends here
