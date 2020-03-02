;;; init-company.el --- Set up Auto completion
;;; Commentary:
;; Company to setup completion
(setq
 company-global-modes
 '(not erc-mode message-mode help-mode gud-mode eshell-mode shell-mode vterm-mode))

(setq company-minimum-prefix-length 3
      company-idle-delay 0.0)

(with-eval-after-load 'company
  (define-key company-active-map (kbd "RET") #'company-complete-selection)
  (define-key company-active-map (kbd "C-SPC") #'company-manual-begin))
(define-key evil-insert-state-map (kbd "C-SPC") 'company-manual-begin)

(use-package company
  :diminish company-mode
  :ensure t
  :config
  (define-key company-active-map (kbd "ESC") 'company-abort)
  (define-key company-active-map (kbd "[tab]") 'company-complete)
  (define-key company-active-map (kbd "[return]") 'company-complete)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (add-hook 'after-init-hook 'global-company-mode))


(use-package company-box
  :init
  (setq company-box-show-single-candidate t
	company-box-doc-delay 1
	company-box-doc-enable nil
	company-box-backends-colors nil
	company-box-max-candidates 50
	company-box-icons-alist 'company-box-icons-all-the-icons)
  :diminish company-box-mode
  :hook (company-mode . company-box-mode))

(use-package company-lsp
  :commands company-lsp
  :ensure t)

(use-package lsp-mode
  :init
  (setq lsp-prefer-flymake nil)
  (setq lsp-enable-file-watchers nil)
  (setq lsp-idle-delay 0.0)
  (setq lsp-auto-guess-root t)
  :diminish lsp-mode
  :hook (php-mode . lsp)
  :commands lsp)

(use-package lsp-ui
  :init
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-doc-enable nil)
  :diminish lsp-ui-mode
  :requires lsp-mode flycheck)

(provide 'init-company)
;;; init-company.el ends here
