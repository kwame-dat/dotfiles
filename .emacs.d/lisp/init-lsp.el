;;; init-lsp.el --- Set LSP mode
;;; Commentary:
;; Company to setup completion
(setq lsp-prefer-flymake nil)
(setq lsp-enable-file-watchers nil)
(setq lsp-idle-delay 0.0)
(setq lsp-auto-guess-root t)
(use-package lsp-mode
  :diminish lsp-mode
  :hook (php-mode . lsp)
  :commands lsp)

(use-package company-lsp
  :commands company-lsp
  :ensure t)

(setq lsp-ui-doc-enable nil)
(setq lsp-ui-doc-enable nil)

(use-package lsp-ui
  :diminish lsp-ui-mode
  :requires lsp-mode flycheck)

(provide 'init-lsp)
;;; init-lsp.el ends here
