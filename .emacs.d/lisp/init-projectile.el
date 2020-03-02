;; init-projectile.el -- Configuration for Projects

;;; Commentary:

;;; Code:
(setq projectile-enable-caching nil)
(setq projectile-project-search-path '("~/Desktop"
                                       "~/Downloads"
                                       "~/Documents/2Areas"
                                       "~/Documents/1Projects"
                                       "~/Repo/2Areas"
                                       "~/Repo/1Projects"))
(setq projectile-completion-system 'ivy)
(setq projectile-enable-caching t)
(setq projectile-switch-project-action #'projectile-dired)

(setq projectile-mode-line
      '(:eval (if (file-remote-p default-directory)
                  " Prj[*remote*]"
                (format " Prj[%s]" (projectile-project-name)))))

(use-package projectile
  :ensure t
  :init (projectile-mode))


(provide 'init-projectile)
;;; init-projectile.el ends here
