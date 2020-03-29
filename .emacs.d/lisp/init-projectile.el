;; init-projectile.el -- Configuration for Projects

;;; Commentary:

;;; Code:
(setq projectile-project-search-path '(
                                       "~/Documents/Home"
                                       "~/Documents/Personal"
                                       "~/Documents/Spiritual"
                                       "~/Documents/Work"
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
