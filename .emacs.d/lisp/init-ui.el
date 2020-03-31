;;; init-ui.el --- UI
;;; Commentary:
;;; Code:
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-monokai-pro t))

(use-package hl-todo
  :defer t
  :init
  (setq hl-todo-keyword-faces
        '(("TODO"   . "#FF0000")
          ("FIXME"  . "#FF0000")
          ("DEBUG"  . "#A020F0")
          ("GOTCHA" . "#FF4500")
          ("STUB"   . "#1E90FF"))))

;; (mac-auto-operator-composition-mode)
(set-frame-font "Dank Mono 18" nil t)

(use-package all-the-icons
  :defer t)

(use-package all-the-icons-dired
  :defer t)

(use-package all-the-icons-ivy
  :defer t
  :ensure t
  :config
  (all-the-icons-ivy-setup))

(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(use-package moody
  :config
  (setq x-underline-at-descent-line t)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode))

;; hide all minor modes
(use-package minions
  :config
  (setq minions-mode-line-lighter ""
        minions-mode-line-delimiters '("" . ""))
  (minions-mode 1))
;;----------------------------------------------------------------------------
;; Treemacs
;;----------------------------------------------------------------------------
(require 'init-treemacs)

;;----------------------------------------------------------------------------
;; Workspace
;;----------------------------------------------------------------------------
(require 'init-workspace)

(provide 'init-ui)
;;; init-ui.el ends here
