;;; init-lsp.el --- lsp -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; (setq lsp-completion-provider :capf)
;; (setq lsp-idle-delay 0.500)
;; (setq lsp-enable-file-watchers nil)
;; (setq lsp-print-performance t)

(setq lsp-enable-file-watchers nil
      lsp-auto-guess-root t
      lsp-file-watch-threshold 3000)


(use-package lsp-mode
  :defer t
  :straight t
  :commands lsp
  :hook ((typescript-mode
          python-mode
          js2-mode
          web-mode
          php-mode
          c-mode) . lsp)
  :bind (:map lsp-mode-map
         ("TAB" . completion-at-point))
  :custom (lsp-headerline-breadcrumb-enable nil))

(kd/leader-key-def
  "l"  '(:ignore t :which-key "lsp")
  "ld" 'xref-find-definitions
  "lr" 'xref-find-references
  "ln" 'lsp-ui-find-next-reference
  "lp" 'lsp-ui-find-prev-reference
  "ls" 'counsel-imenu
  "le" 'lsp-ui-flycheck-list
  "lS" 'lsp-ui-sideline-mode
  "lX" 'lsp-execute-code-action)

(use-package lsp-ui
  :defer t
  :bind (:map lsp-ui-mode-map
              ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
              ([remap xref-find-references] . lsp-ui-peek-find-references))
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-sideline-show-hover nil)
  (setq lsp-ui-doc-position 'bottom)
  (lsp-ui-doc-show))

;; (use-package lsp-ivy
;;   :commands lsp-ivy-workspace-symbol lsp-ivy-global-workspace-symbol
;;   )

(provide 'init-lsp)
;;; init-lsp.el ends here
