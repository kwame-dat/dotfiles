;;; init-lsp.el --- Set LSP mode
;;; Commentary:
;; Company to setup completion
(use-package lsp-mode
  :init
  (setq lsp-idle-delay 0.0)
  (setq lsp-auto-guess-root nil)
  (setq lsp-prefer-flymake nil)
  (setq lsp-keep-workspace-alive nil)
  (setq lsp-flycheck-live-reporting t)
  (setq lsp-file-watch-threshold nil)
  :hook (php-mode . lsp)
  :commands lsp)

(use-package company-lsp
  :init
  :commands company-lsp
  :ensure t)

(use-package lsp-ui
  :init
  (setq lsp-ui-doc-max-height 8
        lsp-ui-doc-max-width 35
        lsp-ui-sideline-ignore-duplicate t
        lsp-ui-sideline-show-hover nil)
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-position 'top)
  (lsp-ui-doc-border (face-foreground 'default))
  (lsp-ui-sideline-enable nil)
  (lsp-ui-sideline-ignore-duplicate t)
  (lsp-ui-sideline-show-code-actions nil))

(use-package lsp-ivy
  :commands lsp-ivy-workspace-symbol lsp-ivy-global-workspace-symbol)

(provide 'init-lsp)
;;; init-lsp.el ends here
