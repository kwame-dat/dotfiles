;;; init-wgrep.el --- wgrep allows you to edit a grep buffer -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(use-package wgrep)
(eval-after-load 'grep
  '(define-key grep-mode-map
    (kbd "C-x C-q") 'wgrep-change-to-wgrep-mode))

(eval-after-load 'wgrep
  '(define-key grep-mode-map
    (kbd "C-c C-c") 'wgrep-finish-edit))
(setq wgrep-auto-save-buffer t)

(provide 'init-wgrep)
;;; init-wgrep.el ends here
