;;; init-password-manager.el --- password-manager -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
;; (setq auth-sources
;;       '((:source "~/.authinfo.gpg")))

(use-package pass
  :defer t)

(use-package ivy-pass
  :defer t)

(use-package password-store
  :defer t
  :config
  (setq password-store-password-length 12))

(use-package auth-source-pass
  :defer t
  :config
  (auth-source-pass-enable))

(kd/leader-key-def

  "ap" '(:ignore t :which-key "pass")
  "app" 'password-store-copy
  "apc" 'password-store-copy
  "apd" 'password-store-remove
  "apr" 'password-store-rename
  "ape" 'password-store-edit
  "api" 'password-store-insert
  "apg" 'password-store-generate)

(provide 'init-password-manager)
;;; init-password-manager.el ends here
