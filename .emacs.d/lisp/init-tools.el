;;; init-tools.el
;;; Commentary:
;;: Code:
;;----------------------------------------------------------------------------
;; Debugger
;;----------------------------------------------------------------------------
(use-package dap-mode
  :ensure t
  :commands dap-mode
  :config
  (dap-mode 1)
  (require 'dap-ui)
  (dap-ui-mode 1)
  (require 'dap-lldb))
(dap-tooltip-mode 1)
(tooltip-mode 1)
(require 'dap-php)

;;----------------------------------------------------------------------------
;; Docker
;;----------------------------------------------------------------------------
(use-package dockerfile-mode)

(use-package docker-compose-mode)

(use-package docker)

;;----------------------------------------------------------------------------
;; EditorConfig
;;----------------------------------------------------------------------------
(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

;;----------------------------------------------------------------------------
;; Lookup
;;----------------------------------------------------------------------------
(use-package synosaurus
  :config
  (global-set-key (kbd "s-|") 'powerthesaurus-lookup-word-dwim))

;;----------------------------------------------------------------------------
;; LSP
;;----------------------------------------------------------------------------
(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-enable-file-watchers nil
        lsp-auto-guess-root t
        lsp-prefer-flymake nil
        lsp-file-watch-threshold 3000

        )
  :commands lsp
  :bind (:map lsp-mode-map ("C-c C-f" . lsp-format-buffer))
  :hook ((java-mode
          python-mode
          go-mode
          js-mode
          js2-mode
          typescript-mode
          web-mode
          php-mode
          c-mode
          c++-mode
          objc-mode) . lsp))

(use-package lsp-ui
  :after lsp-mode
  :commands lsp-ui-mode
  :custom-face
  (lsp-ui-doc-background ((t (:background nil))))
  (lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic)))))
  :bind (:map lsp-ui-mode-map
              ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
              ([remap xref-find-references] . lsp-ui-peek-find-references)
              ("C-c u" . lsp-ui-imenu)
              ("M-i" . lsp-ui-doc-focus-frame))
  :custom
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-enable nil)
  (lsp-ui-doc-border (face-foreground 'default))
  (lsp-ui-sideline-enable nil)
  (lsp-ui-sideline-ignore-duplicate t)
  (lsp-ui-sideline-show-code-actions nil)
  :config
  ;; WORKAROUND Hide mode-line of the lsp-ui-imenu buffer
  ;; https://github.com/emacs-lsp/lsp-ui/issues/243
  (defadvice lsp-ui-imenu (after hide-lsp-ui-imenu-mode-line activate)
    (setq mode-line-format nil)))

(use-package company-lsp
  :ensure t
  :custom (company-lsp-cache-candidates 'auto))

;;----------------------------------------------------------------------------
;; Magit
;;----------------------------------------------------------------------------
(use-package magit-gitflow)

(use-package magit-todos)

(use-package github-review)

(use-package magit
  :init
  (setq magit-status-buffer-switch-function 'switch-to-buffer)
  (setq magit-push-always-verify nil)
  (setq git-commit-summary-max-length 50)
  :config
  (use-package evil-magit)
  (use-package with-editor)
  (add-hook 'with-editor-mode-hook 'evil-insert-state)
  :ensure t)

(use-package yagist)

(use-package bug-reference-github)

(use-package github-clone)

(use-package forge)
(push '("github.thetrainline.com" "github.thetrainline.com/api/v3"
        "github.thetrainline.com" forge-github-repository)
        forge-alist)

(use-package git-gutter-fringe
  :ensure t
  :init
  (setq git-gutter-fr:side 'right-fringe)
  :config (global-git-gutter-mode))
(use-package browse-at-remote)

;;----------------------------------------------------------------------------
;; Pass
;;----------------------------------------------------------------------------
(use-package pass)

(use-package ivy-pass)

;;----------------------------------------------------------------------------
;; PDF
;;----------------------------------------------------------------------------
(use-package pdf-tools
  :config
  (setq-default pdf-view-use-scaling t
                pdf-view-use-imagemagick nil)
  :ensure t
  :config (pdf-tools-install))

;;----------------------------------------------------------------------------
;; Redis
;;----------------------------------------------------------------------------
(use-package eredis)

;;----------------------------------------------------------------------------
;; macOs
;;----------------------------------------------------------------------------
(require 'init-macos)

;;----------------------------------------------------------------------------
;; Elastic Search
;;----------------------------------------------------------------------------
(use-package es-mode)
(autoload 'es-mode "es-mode.el"
  "Major mode for editing Elasticsearch queries" t)
(add-to-list 'auto-mode-alist '("\\.es$" . es-mode))

;;----------------------------------------------------------------------------
;; Open Vidoes in VLC player please
;;----------------------------------------------------------------------------
(use-package openwith
  :init
  (setq openwith-associations '(("\\.mp4\\'" "vlc" (file))))
  :config
  (openwith-mode t))


(provide 'init-tools)
;;; init-tools.el ends here
