;;; init-toggles.el --- toggles -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(kd/leader-key-def
  "ts"  'treemacs
  "tc"  'company-mode
  "tf"  'flycheck-mode
  "tr"  'display-line-numbers
  "ttl"  'toggle-truncate-lines
  "tvl"  'global-visual-line-mode
  "te"  'global-emojify-mode)

(provide 'init-toggles)
;;; init-toggles.el ends here
