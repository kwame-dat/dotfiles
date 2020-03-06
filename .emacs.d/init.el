;;; Commentary:
;;
;;
;;
;;; Code:
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'init-benchmarking) ;; Measure startup time

(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer
(defconst *is-a-mac* (eq system-type 'darwin))
;;----------------------------------------------------------------------------
;; Adjust garbage collection thresholds during startup, and thereafter
;;----------------------------------------------------------------------------
(let ((normal-gc-cons-threshold (* 20 1024 1024))
      (init-gc-cons-threshold (* 128 1024 1024)))
  (setq gc-cons-threshold init-gc-cons-threshold)
  (add-hook 'emacs-startup-hook
            (lambda () (setq gc-cons-threshold normal-gc-cons-threshold))))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
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
