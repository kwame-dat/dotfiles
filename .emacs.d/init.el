;;; init.el --- Main configuration -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
;;----------------------------------------------------------------------------
;; Bootstrap configuration
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-utils)
(require 'init-elpa)
(require 'init-exec-path)
;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(require 'init-editing-utils)
(require 'init-key-bindings)
(require 'init-evil)
(require 'init-swiper)
(require 'init-ivy)
(require 'init-projectile)
(require 'init-counsel)
(require 'init-fonts)
(require 'init-php)
(require 'init-company)
(require 'init-lsp)
(require 'init-flycheck)
(require 'init-dired)
(require 'init-apps)
(require 'init-elasticsearch)
(require 'init-org)
(require 'init-theme)
(require 'init-treemacs)
(require 'init-workspace)
(require 'init-terminal)
(require 'init-emails)
(require 'init-css)
(require 'init-web)
(require 'init-javascript)
(require 'init-yaml)
(require 'init-env)
(require 'init-editorconfig)
(require 'init-git)
(require 'init-github)
(require 'init-vc)
(require 'init-ledger)
(require 'init-macos)
(require 'init-markdown)
(require 'init-restclient)
(require 'init-docker)
(require 'init-pdf-tools)
(require 'init-debugging)
(require 'init-wgrep)
(require 'init-snippets)
(require 'init-csv)
(require 'init-spelling)
(require 'init-uniquify)
(require 'init-pass)
(require 'init-slack)
(require 'init-nov)
(require 'init-eredis)
(require 'init-grammar)
(require 'init-calendar)
(require 'init-shackle)
(require 'secrets)

(provide 'init)
;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
;;; init.el ends here
