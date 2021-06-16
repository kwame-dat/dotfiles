;;; init-autocompletion.el --- autocompletion -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(use-package company
  :diminish
  :defer t
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :config
  (setq company-global-modes
	'(not
	  erc-mode
	  eshell-mode
	  gud-mode
	  help-mode
	  message-mode
	  shell-mode
	  vterm-mode)

	company-selection-wrap-around t
	company-idle-delay 0
	company-minimum-prefix-length 1
	company-selection-wrap-around t
	company-tooltip-align-annotations t
	company-require-match 'never
	company-auto-commit nil
	company-auto-commit-chars nil
	company-dabbrev-other-buffers nil
	company-dabbrev-ignore-case nil
	company-dabbrev-downcase nil)

  ;; (define-key company-active-map (kbd "ESC") 'company-abort)
  ;; (define-key company-active-map [tab] 'company-complete-common-or-cycle)
  )

;; (eval-after-load 'company
;;   '(progn
;;      (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
;;      (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)))

;; (with-eval-after-load 'company
;;   (define-key company-active-map (kbd "C-j") (lambda () (interactive) (company-complete-common-or-cycle 1)))
;;   (define-key company-active-map (kbd "C-k") (lambda () (interactive) (company-complete-common-or-cycle -1))))

(add-hook 'after-init-hook 'global-company-mode)

;; (use-package company-prescient
;;   :defer t
;;   :hook (company-mode . company-prescient-mode)
;;   :config
;;   (prescient-persist-mode +1))

;; (use-package company-dict
;;   :defer t)

(provide 'init-autocompletion)
;;; init-autocompletion.el ends here
