;;; init-theme.el --- UI
;;; Commentary:
;;; Code:
(add-to-list 'default-frame-alist
             '(ns-appearance . light))
(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config
  (load-theme 'sanityinc-tomorrow-night t))

(use-package diminish :ensure t)
(diminish 'evil-org-mode)
(diminish 'ivy-mode)
(diminish 'emojify-mode)
(diminish 'emoji-cheat-sheet-plus-display-mode)
(diminish 'company-mode)
(diminish 'company-box-mode)
(diminish 'ivy-mode)
(diminish 'editorconfig-mode)
(diminish 'evil-commentary-mode)
(diminish 'evil-mc-mode)
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
(diminish 'persp-mode)

(use-package all-the-icons)

(use-package all-the-icons-dired)

(use-package all-the-icons-ivy
  :ensure t
  :config
  (all-the-icons-ivy-setup))

(use-package spaceline-all-the-icons)

(use-package spaceline)
(spaceline-spacemacs-theme)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(provide 'init-theme)
;;; init-theme.el ends here
