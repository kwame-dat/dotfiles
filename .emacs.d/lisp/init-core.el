;;; init-core.el --- Core packages
;;; Commentary:
;;; Code:
(require 'init-editing-utils)
(require 'init-key-bindings)
;;----------------------------------------------------------------------------
;; Make sure Emacs can execute from my shell
;;----------------------------------------------------------------------------
(use-package exec-path-from-shell
  :init
  (setq exec-path-from-shell-check-startup-files nil))
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
;;----------------------------------------------------------------------------
;; Helping me find which key combination
;;----------------------------------------------------------------------------
(use-package which-key
  :init
  (setq which-key-idle-delay 0.40)
  :ensure t
  :config (which-key-mode))

;;----------------------------------------------------------------------------
;; Projectile
;;----------------------------------------------------------------------------
(use-package projectile
  :ensure t
  :init
  (setq projectile-project-search-path '(
                                         "~/Documents/Home/1Projects"
                                         "~/Documents/Home/2Areas"
                                         "~/Documents/Personal/1Projects"
                                         "~/Documents/Personal/2Areas"
                                         "~/Documents/Spiritual"
                                         "~/Documents/Work/1Projects"
                                         "~/Documents/Work/2Areas"
                                         "~/Repo/2Areas"
                                         "~/Repo/1Projects"
                                         "~/org"
                                         ))
  (setq projectile-completion-system 'ivy)
  (setq projectile-switch-project-action #'projectile-dired)
  (projectile-mode))

(use-package wgrep
  :init
  (setq wgrep-auto-save-buffer t))

(eval-after-load 'grep
  '(define-key grep-mode-map
    (kbd "C-x C-q") 'wgrep-change-to-wgrep-mode))

(eval-after-load 'wgrep
  '(define-key grep-mode-map
     (kbd "C-c C-c") 'wgrep-finish-edit))


(provide 'init-core)
;;; init-core.el ends here
