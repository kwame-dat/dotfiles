;;; init-smex.el --- Use smex to improve M-x -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Use smex to handle M-x
(setq-default smex-save-file (expand-file-name ".smex-items" user-emacs-directory))
(global-set-key [remap execute-extended-command] 'smex)
(use-package smex)

(provide 'init-smex)
;;; init-smex.el ends here
