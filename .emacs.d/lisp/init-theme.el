;;; init-theme.el --- UI
;;; Commentary:
;;; Code:
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t))

(use-package all-the-icons)

(use-package all-the-icons-dired)

(use-package all-the-icons-ivy
  :ensure t
  :config
  (all-the-icons-ivy-setup))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(setq hl-todo-keyword-faces
      '(("TODO"   . "#FF0000")
        ("FIXME"  . "#FF0000")
        ("DEBUG"  . "#A020F0")
        ("GOTCHA" . "#FF4500")
        ("STUB"   . "#1E90FF")))
(use-package hl-todo)

(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(provide 'init-theme)
;;; init-theme.el ends here
