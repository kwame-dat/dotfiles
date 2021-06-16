;;; init.el --- Load the full configuration -*- lexical-binding: t -*-
;;; Commentary:

;; This file bootstraps the configuration, which is divided into
;; a number of other files.

;;; Code:

;; Produce backtraces when errors occur: can be helpful to diagnose startup issues
;;(setq debug-on-error t)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Native Compilation
(setq comp-async-report-warnings-errors nil)

;; (require 'init-benchmarking) ;; Measure startup time
(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))

;; Adjust garbage collection thresholds during startup, and thereafter
(let ((normal-gc-cons-threshold (* 20 1024 1024))
      (init-gc-cons-threshold (* 128 1024 1024)))
  (setq gc-cons-threshold init-gc-cons-threshold)
  (add-hook 'emacs-startup-hook
            (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))

;; Bootstrap config
(require 'init-package-management)
(require 'init-directory-clean)
(require 'init-keyboard-bindings)

;; General Configuration
(require 'init-user-interface)
(require 'init-themes) ;; stop theme compilation
(require 'init-modeline)
(require 'init-fonts)
(require 'init-icons)
(require 'init-completion)
(require 'init-treemacs)
(require 'init-workspace) ;; fix persp mode
(require 'init-configuration-files)
(require 'init-search-n-lookup)
(require 'init-notifications)
(require 'init-toggles)

;; File Browsing
(require 'init-dired)
(require 'init-tramp)

;; Window
(require 'init-window-management)

;; Development
(require 'init-git)
(require 'init-projectile)

;; Languages
(require 'init-lsp)
(require 'init-php)
(require 'init-web)
(require 'init-javascript)
(require 'init-dotenv)
(require 'init-css)
(require 'init-haskell)
(require 'init-restclient)
(require 'init-csv)
(require 'init-markdown)
(require 'init-fountain)
(require 'init-yaml)

;; Tools
(require 'init-docker)
(require 'init-vagrant)
(require 'init-editorconfig)
(require 'init-elastic-search)
(require 'init-debugger)

;; Productivity
(require 'init-syntax-checking)
(require 'init-spell-checking)
(require 'init-grammar-checking)
(require 'init-autocompletion)
(require 'init-snippets)
(require 'init-multiple-cursors)
(require 'init-smart-parens)
(require 'init-colour-highlighting)
(require 'init-writing)

;; Org Mode
(require 'init-org-mode)

;; Applications
(kd/leader-key-def
  "a"  '(:ignore t :which-key "apps"))
(require 'init-calendar)
(require 'init-alert)
(require 'init-chat)
(require 'init-music)
(require 'init-mail)
(require 'init-eshell)
(require 'init-terminal)
(require 'init-password-manager)
(require 'init-reading)
(require 'init-touch-typing)
(require 'init-finance)


(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
;;; init.el ends here
