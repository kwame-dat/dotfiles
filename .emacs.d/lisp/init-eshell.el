;;; init-eshell.el --- eshell -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(use-package exec-path-from-shell
  :defer t
  :demand t
  :init
  (setq exec-path-from-shell-check-startup-files nil))
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(defun efs/configure-eshell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  ;; Bind some useful keys for evil-mode
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "C-r") 'counsel-esh-history)
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "<home>") 'eshell-bol)
  (evil-normalize-keymaps)

  (setq
   eshell-scroll-to-bottom-on-input 'all
   eshell-error-if-no-glob t
   eshell-hist-ignoredups t
   eshell-save-history-on-exit t
   eshell-prefer-lisp-functions nil
   eshell-destroy-buffer-when-process-dies t
   eshell-history-size         10000
   eshell-buffer-maximum-lines 10000
   eshell-scroll-to-bottom-on-input t))

(use-package eshell-git-prompt
  :defer t)

(use-package eshell-toggle
  :defer t)

(use-package eshell
  :defer t
  :hook (eshell-first-time-mode . efs/configure-eshell)
  :config

  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "zsh" "vim")))

  (eshell-git-prompt-use-theme 'simple))


(provide 'init-eshell)
;;; init-eshell.el ends here
