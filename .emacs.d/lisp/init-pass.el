;;; init-pass.el --- Manages password with pass-*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(use-package auth-source-pass)
(use-package pass)
(use-package ivy-pass)
(auth-source-pass-enable)

(provide 'init-pass)
;;; init-pass.el ends here
