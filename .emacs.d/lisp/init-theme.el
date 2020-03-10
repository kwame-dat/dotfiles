;;; init-theme.el --- UI
;;; Commentary:
;;; Code:
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-tomorrow-day t))

(use-package all-the-icons)

(use-package all-the-icons-dired)

(use-package all-the-icons-ivy
  :ensure t
  :config
  (all-the-icons-ivy-setup))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; (use-package spaceline-all-the-icons)

;; (use-package spaceline)
;; (spaceline-spacemacs-theme)
;; (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(provide 'init-theme)
;;; init-theme.el ends here
