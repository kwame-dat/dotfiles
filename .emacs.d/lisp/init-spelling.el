;;; init-spelling.el --- Spell check settings -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; flyspell-correct-ivy
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

(use-package ispell
  :defer 2
  :ensure-system-package (hunspell . "trizen -S hunspell")
  :custom
  (ispell-dictionary "en_GB")
  (ispell-dictionary-alist
   '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_GB") nil utf-8)
     ))
  (ispell-program-name (executable-find "hunspell"))
  (ispell-really-hunspell t)
  (ispell-silently-savep t))

(provide 'init-spelling)
;;; init-spelling.el ends here
