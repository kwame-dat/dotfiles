;;; init-ledger.el --- Support for the ledger CLI accounting tool -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(use-package ledger-mode
  :init
  (setq ledger-post-amount-alignment-column 70)
  (setq ledger-highlight-xact-under-point nil
        ledger-use-iso-dates nil))

(use-package flycheck-ledger)
(use-package evil-ledger)

(add-hook 'ledger-mode-hook 'display-line-numbers-mode)
(provide 'init-ledger)
;;; init-ledger.el ends here
