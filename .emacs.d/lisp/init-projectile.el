;;; init-projectile.el --- Projectile -*- lexical-binding: t -*-
;;; Commentary: Manage projects inside of Emacs
;;; Code:
(use-package projectile
  :diminish
  :defer t
  :config
  (setq projectile-project-search-path '(
					 "~/Nextcloud/Documents/Work/3Resources"
					 "~/Nextcloud/Documents/Work/2Areas"
					 "~/Nextcloud/Documents/Work/1Projects"
					 "~/Nextcloud/Documents/Joint/3Resources"
					 "~/Nextcloud/Documents/Joint/2Areas"
					 "~/Nextcloud/Documents/Joint/1Projects"
					 "~/Nextcloud/Documents/Spiritual/3Resources"
					 "~/Nextcloud/Documents/Spiritual/2Areas"
					 "~/Nextcloud/Documents/Spiritual/1Projects"
					 "~/Nextcloud/Documents/Personal/3Resources"
					 "~/Nextcloud/Documents/Personal/2Areas"
					 "~/Nextcloud/Documents/Personal/1Projects"
					 "~/Repo/Work/3Resources"
					 "~/Repo/Work/2Areas"
					 "~/Repo/Work/1Projects"
					 "~/Repo/Personal/3Resources"
					 "~/Repo/Personal/2Areas"
					 "~/Repo/Personal/1Projects"

					 ))
  (setq projectile-completion-system 'ivy)
  (setq projectile-switch-project-action #'projectile-dired)
  (projectile-mode))

(kd/leader-key-def
	;;; <leader> p --- projects
  "pp"  'projectile-switch-project
  "pi"  'projectile-invalidate-cache
  "pt"  'projectile-run-vterm
  "pb"  'projectile-switch-to-buffer
  "ps"  'counsel-projectile-rg
  "pc"  'projectile-compile-project
  "pB"  'counsel-switch-buffer
  "pd"  'projectile-discover-projects-in-search-path)


(global-set-key (kbd "M-p") 'projectile-find-file)
(global-set-key (kbd "M-S-p") 'projectile-switch-project)
(global-set-key (kbd "H-p") 'projectile-find-file)

(provide 'init-projectile)
;;; init-projectile.el ends here
