;;; init-debugging.el --- Debugging with dap mode -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(use-package dap-mode
  :ensure t
  :commands dap-mode
  :config
  (dap-mode 1)
  (require 'dap-ui)
  (dap-ui-mode 1)
  (require 'dap-lldb))

(dap-tooltip-mode 1)
(tooltip-mode 1)

(require 'dap-php)

(provide 'init-debugging)
;;; init-debugging.el ends here
