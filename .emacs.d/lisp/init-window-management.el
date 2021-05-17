;;; init-window-management.el --- window-manangement -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Frame Scaling / Zooming
(use-package default-text-scale
  :defer 1
  :config
  (default-text-scale-mode))

;; (use-package ace-window
;;   :bind (("M-o" . ace-window))
;;   :custom
;;   (aw-scope 'frame)
;;   (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
;;   (aw-minibuffer-flag t)
;;   :config
;;   (ace-window-display-mode 1))

;; Window history
(use-package winner
  :after evil
  :config
  (winner-mode)
  (define-key evil-window-map "u" 'winner-undo)
  (define-key evil-window-map "U" 'winner-redo))

(general-def 'normal
  "C-j" 'evil-window-down
  "C-h" 'evil-window-left
  "C-k" 'evil-window-up
  "C-l" 'evil-window-right)

(provide 'init-window-management)
;;; init-window-management.el ends here
