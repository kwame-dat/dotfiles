;;; init-lsp.el --- Set LSP mode
;;; Commentary:
;; Company to setup completion
(use-package lsp-mode
  :init
  (setq lsp-idle-delay 0.0)
  (setq lsp-auto-guess-root t)
  (setq lsp-keep-workspace-alive nil)
  (setq lsp-flycheck-live-reporting nil)
  :hook (php-mode . lsp)
  :commands lsp)

(use-package company-lsp
  :commands company-lsp
  :ensure t)

(use-package lsp-ui
  :init
  (setq lsp-ui-doc-max-height 8
        lsp-ui-doc-max-width 35
        lsp-ui-sideline-ignore-duplicate t
        ;; lsp-ui-doc is redundant with and more invasive than
        ;; `+lookup/documentation'
        lsp-ui-doc-enable nil
        lsp-prefer-flymake nil
        lsp-prefer-sideline-enable nil
        ;; Don't show symbol definitions in the sideline. They are pretty noisy,
        ;; and there is a bug preventing Flycheck errors from being shown (the
        ;; errors flash briefly and then disappear).
        lsp-ui-sideline-show-hover nil))

(use-package lsp-ivy
  :commands lsp-ivy-workspace-symbol lsp-ivy-global-workspace-symbol)

(provide 'init-lsp)
;;; init-lsp.el ends here
