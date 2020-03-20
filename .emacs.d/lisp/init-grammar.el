;;; init-grammar.el --- Help me write well my horrible grammar -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(use-package langtool
  :commands
  (langtool-check
   langtool-check-done
   langtool-show-message-at-point
   langtool-correct-buffer))

(use-package writegood-mode)

(provide 'init-grammar)
;;; init-grammar.el ends here
