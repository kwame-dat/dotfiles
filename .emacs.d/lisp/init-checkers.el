;;; init-checkers.el --- Checking my silly mistakes
;;; Commentary:
;;; Code:
;;----------------------------------------------------------------------------
;; Grammar
;;----------------------------------------------------------------------------
(use-package langtool
  :commands
  (langtool-check
   langtool-check-done
   langtool-show-message-at-point
   langtool-correct-buffer))

(use-package writegood-mode)

;;----------------------------------------------------------------------------
;; Spell
;;----------------------------------------------------------------------------
(use-package flyspell-correct)

(use-package flyspell-correct-popup)

(use-package flyspell-correct-ivy
  :bind ("C-M-;" . flyspell-correct-wrapper)
  :init
  (setq flyspell-correct-interface #'flyspell-correct-ivy)
  (setq ispell-program-name "aspell"))

(use-package flyspell
  :delight
  :hook ((markdown-mode org-mode text-mode) . flyspell-mode)
         (prog-mode . flyspell-prog-mode)
  :custom
  (flyspell-abbrev-p t)
  (flyspell-default-dictionary "en_GB")
  (flyspell-issue-message-flag nil)
  (flyspell-issue-welcome-flag nil))

(add-to-list 'ispell-skip-region-alist '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_SRC" . "#\\+END_SRC"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_EXAMPLE" . "#\\+END_EXAMPLE"))
(add-hook 'text-mode-hook 'flyspell-mode)
(global-set-key (kbd "s-\\") 'ispell-word)
(use-package define-word
  :config
  (global-set-key (kbd "M-\\") 'define-word-at-point))

;;----------------------------------------------------------------------------
;; Syntax
;;----------------------------------------------------------------------------
(use-package flycheck
  :ensure t
  :init
  (setq flycheck-emacs-lisp-load-path 'inherit
        flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list
        flycheck-check-syntax-automatically '(save idle-change mode-enabled)
        flycheck-idle-change-delay 0.4
        flycheck-global-modes '(not org-mode)
        flycheck-phpcs-standard "PSR2")
  (global-flycheck-mode))

(use-package flycheck-phpstan
  :ensure t)

(provide 'init-checkers)

;;; init-checkers.el ends here
