;;; init-ivy.el --- Ivy configuration -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "s-y") 'counsel-yank-pop)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "s-r") 'counsel-imenu)
(global-set-key (kbd "s-b") 'counsel-switch-buffer)
(global-set-key (kbd "s-/") 'comment-line)
(global-set-key (kbd "s-F") 'counsel-rg)
(global-set-key (kbd "s-f") 'swiper-isearch)
(global-set-key (kbd "s-b") 'ivy-switch-buffer)
(define-key ivy-minibuffer-map (kbd "C-c C-e") 'ivy-occur)

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
(provide 'init-ivy)
;;; init-ivy.el ends here
