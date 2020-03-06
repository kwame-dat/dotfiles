;;; init-vc.el --- Version control support -*- lexical-binding: t -*-
;;; Commentary:

;; Most version control packages are configured separately: see
;; init-git.el, for example.

;;; Code:
(use-package git-gutter-fringe
  :ensure t
  :init
  (setq git-gutter-fr:side 'right-fringe)
  :diminish git-gutter-mode
  :config (global-git-gutter-mode))

(use-package browse-at-remote)

(provide 'init-vc)
;;; init-vc.el ends here
