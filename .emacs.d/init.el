;;; init.el --- Main configuration -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
;;----------------------------------------------------------------------------
;; Bootstrap configuration
;;----------------------------------------------------------------------------
(setq gc-cons-threshold (* 50 1000 1000))
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(setq package-check-signature nil)
(require 'init-utils)
(require 'init-elpa)
;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(require 'init-core)
(require 'init-editor)
(require 'init-emacs)
(require 'init-ui)
(require 'init-completion)
(require 'init-lang)
(require 'init-checkers)
(require 'init-tools)
(require 'init-terminal)
(require 'init-app)
(require 'init-email)
(require 'secrets)

(provide 'init)
;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
;;; init.el ends here
(setq gc-cons-threshold (* 2 1000 1000))
