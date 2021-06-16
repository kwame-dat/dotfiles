;;; init-modeline.el --- Modline -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(setq doom-modeline-height 5)
(setq doom-modeline-modal-icon t)
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))

;; (use-package diminish)
;; (diminish 'company-mode)
;; (diminish 'which-key-mode)
;; (diminish 'subword-mode)
;; (diminish 'mixed-pitch-mode)
;; (diminish 'indented-text-mode)
;; (diminish 'undo-tree-mode)
;; (diminish 'eldoc-mode)
;; (diminish 'company-box-mode)
;; (diminish 'evil-commentary-mode)
;; (diminish 'org-src-mode)
;; (diminish 'sub-mode)
;; (diminish 'all-the-icons-dired-mode)
;; (diminish 'company-mode)
;; (add-hook 'org-indent-mode-hook (lambda () (diminish 'org-indent-mode)))
;; (diminish 'wrap-region-mode)
;; (diminish 'yas/minor-mode)
;; (diminish 'visual-line-mode)
;; (diminish 'abbrev-mode)
;; (diminish 'subword-mode)
;; (diminish 'auto-revert-mode)

(provide 'init-modeline)
;;; init-modeline.el ends here
