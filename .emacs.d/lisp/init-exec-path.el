;;; init-exec-path.el --- Set up exec-path to help Emacs find programs  -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

  ;; exec-path-from-shell
  (use-package exec-path-from-shell)
  (setq exec-path-from-shell-check-startup-files nil)
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize))

(provide 'init-exec-path)
;;; init-exec-path.el ends here
