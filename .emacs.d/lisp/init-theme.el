;;; init-theme.el --- UI
;;; Commentary:
;;; Code:
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one-light t))

(use-package all-the-icons)

(use-package all-the-icons-dired)

(use-package all-the-icons-ivy
  :ensure t
  :config
  (all-the-icons-ivy-setup))

(use-package spaceline)
(spaceline-spacemacs-theme)

(use-package diminish :ensure t)
(diminish 'evil-org-mode)
(diminish 'ivy-mode)
(diminish 'subword-mode)
(diminish 'mixed-pitch-mode)
(diminish 'indented-text-mode)
(diminish 'yas-minor-mode)
(diminish 'projectile-mode)
(diminish 'undo-tree-mode)
(diminish 'flycheck-mode)
(diminish 'flyspell-mode)
(diminish 'which-key-mode)
(diminish 'eldoc-mode)
(diminish 'dired-async-mode)
(diminish 'evil-mc-mode)
(diminish 'company-box-mode)
(diminish 'evil-commentary-mode)
(diminish 'org-src-mode)
(diminish 'sub-mode)
(diminish 'all-the-icons-dired-mode)
(diminish 'company-mode)
(add-hook 'org-indent-mode-hook (lambda () (diminish 'org-indent-mode)))
(diminish 'wrap-region-mode)
(diminish 'yas/minor-mode)
(diminish 'visual-line-mode)
(diminish 'abbrev-mode)
(diminish 'subword-mode)

(with-eval-after-load 'subword
  (diminish 'subword-mode))
(global-subword-mode +1)

(use-package hl-todo
  :init
  (setq hl-todo-keyword-faces
        '(("TODO"   . "#FF0000")
          ("FIXME"  . "#FF0000")
          ("DEBUG"  . "#A020F0")
          ("GOTCHA" . "#FF4500")
          ("STUB"   . "#1E90FF"))))

(provide 'init-theme)
;;; init-theme.el ends here
