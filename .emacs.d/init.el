;;; init.el --- Main configuration -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(setq gc-cons-threshold 100000000)
(setq package-enable-at-startup nil)
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(defvar file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)
(setq site-run-file nil)
;;----------------------------------------------------------------------------
;; Adjust garbage collection thresholds during startup, and thereafter
;;----------------------------------------------------------------------------
(defvar better-gc-cons-threshold 67108864 ; 64mb
  "The default value to use for `gc-cons-threshold'.

If you experience freezing, decrease this.  If you experience stuttering, increase this.")

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold better-gc-cons-threshold)
            (setq file-name-handler-alist file-name-handler-alist-original)
            (makunbound 'file-name-handler-alist-original)))
(setq gc-cons-threshold most-positive-fixnum)
(setq load-prefer-newer noninteractive)
(let (file-name-handler-alist)
  (setq user-emacs-directory (file-name-directory load-file-name)))

;; Garbage Collect when Emacs is out of focus and avoid garbage collection when using minibuffer.
(add-hook 'emacs-startup-hook
          (lambda ()
            (if (boundp 'after-focus-change-function)
                (add-function :after after-focus-change-function
                              (lambda ()
                                (unless (frame-focus-state)
                                  (garbage-collect))))
              (add-hook 'after-focus-change-function 'garbage-collect))
            (defun gc-minibuffer-setup-hook ()
              (setq gc-cons-threshold (* better-gc-cons-threshold 2)))

            (defun gc-minibuffer-exit-hook ()
              (garbage-collect)
              (setq gc-cons-threshold better-gc-cons-threshold))

            (add-hook 'minibuffer-setup-hook #'gc-minibuffer-setup-hook)
            (add-hook 'minibuffer-exit-hook #'gc-minibuffer-exit-hook)))
;;----------------------------------------------------------------------------
;; Bootstrap configuration
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(require 'init-utils)
(require 'init-elpa)
(require 'init-exec-path)
;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------
(load-)
(require 'sensible-defaults)
(require 'init-editing-utils)
(require 'init-key-bindings)
(require 'init-evil)
(require 'init-swiper)
(require 'init-ivy)
(require 'init-counsel)
(require 'init-fonts)
(require 'init-php)
(require 'init-projectile)
(require 'init-company)
(require 'init-lsp)
(require 'init-flycheck)
(require 'init-dired)
(require 'init-apps)
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
(require 'init-elasticsearch)
(require 'init-nov)
(require 'init-eredis)
(require 'init-grammar)
;;----------------------------------------------------------------------------
;; Allow access from emacsclient
;;----------------------------------------------------------------------------
(add-hook 'after-init-hook
          (lambda ()
            (require 'server)
            (unless (server-running-p)
              (server-start))))
;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(when (file-exists-p custom-file)
  (load custom-file))
;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
(require 'init-locales)
(provide 'init)
;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
;;; init.el ends here
