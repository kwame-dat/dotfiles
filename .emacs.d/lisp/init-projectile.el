;; init-projectile.el -- Configuration for Projects

;;; Commentary:

;;; Code:
(setq projectile-project-search-path '(
                                       "~/Documents/2Areas"
                                       "~/Documents/1Projects"
                                       "~/Repo/2Areas"
                                       "~/Repo/1Projects"
                                       ))
(setq projectile-completion-system 'ivy)
(setq projectile-switch-project-action #'projectile-dired)
(use-package projectile
  :ensure t
  :init (projectile-mode))

(provide 'init-projectile)
;;; init-projectile.el ends here
