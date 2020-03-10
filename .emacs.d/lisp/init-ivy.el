;;; init-ivy.el --- Ivy configuration -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package ivy
  :init
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-on-del-error-function #'ignore)
  (setq ivy-re-builders-alist
        '((swiper . ivy--regex-plus)
          (swiper-isearch . ivy--regex-plus)
          (counsel-ag . ivy--regex-plus)
          (counsel-rg . ivy--regex-plus)
          (t      . ivy--regex-fuzzy)))
  :config
  (evil-set-initial-state 'ivy-occur-grep-mode 'normal)
  :diminish ivy-mode)

(ivy-mode 1)

(use-package all-the-icons-ivy
  :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup))
(provide 'init-ivy)
;;; init-ivy.el ends here
