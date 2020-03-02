;org;; init.el -- My Emacs configuration
;-*-Emacs-Lisp-*-

;;; Commentary:
;;
;;
;;
;;; Code:
(setq-default buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(setq locale-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

(setq initial-scratch-message
      (concat
       ";; This buffer is for text that is not saved, and for Lisp evaluation.\n"
       ";; To create a file, visit it with C-x C-f and enter text in its buffer.\n"
       ";;\n"
       ";; __          __  _                            \n"
       ";; \\ \\        / / | |                           \n"
       ";;  \\ \\  /\\  / /__| | ___ ___  _ __ ___   ___   \n"
       ";;   \\ \\/  \\/ / _ \\ |/ __/ _ \\| '_ ` _ \\ / _ \\  \n"
       ";;    \\  /\\  /  __/ | (_| (_) | | | | | |  __/_ \n"
       ";;     \\/  \\/ \\___|_|\\___\\___/|_| |_| |_|\\___(_)\n"))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Also add all directories within "lisp"
;; I use this for packages I'm actively working on, mostly.
(let ((files (directory-files-and-attributes (expand-file-name "lisp" user-emacs-directory) t)))
  (dolist (file files)
    (let ((filename (car file))
          (dir (nth 1 file)))
      (when (and dir
                 (not (string-suffix-p "." filename)))
        (add-to-list 'load-path (car file))))))

;; Essential settings.
(setq
 inhibit-startup-message t
 inhibit-startup-screen t
 sentence-end-double-space nil
 confirm-kill-emacs 'y-or-n-p)

(setq split-height-threshold 0)
(setq split-width-threshold nil)
(setq ring-bell-function 'ignore)

(menu-bar-mode -1)
(tool-bar-mode -1)
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(set-window-scroll-bars (minibuffer-window) nil nil)

(show-paren-mode 1)
(setq show-paren-delay 0)

(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(setq-default left-fringe-width nil)
(setq-default indicate-empty-lines t)
(setq-default indent-tabs-mode nil)

(setq visible-bell t)
(setq vc-follow-symlinks t)
(setq large-file-warning-threshold nil)
(setq split-width-threshold nil)
(setq custom-safe-themes t)
(column-number-mode t)
(setq tab-width 4)
(setq tramp-default-method "ssh")
;; (setq tramp-syntax 'simplified)

(electric-pair-mode 1)

(setq delete-by-moving-to-trash t)
(defun system-move-file-to-trash (file)
  "Use \"trash\" to move FILE to the system trash.
                    When using Homebrew, install it using \"brew install trash\"."
  (call-process (executable-find "trash")
                nil 0 nil
                file))

;; Keep all backup and auto-save files in one directory
(setq backup-directory-alist '(("." . "~/.emacs.d/.cache/backups")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/.cache/auto-save-list/" t)))

(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq create-lockfiles nil)  ; stop creating .# files


;; Allow "confusing" functions
(put 'narrow-to-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

(fset 'yes-or-no-p 'y-or-n-p)      ; y and n instead of yes and no everywhere else

(setq user-full-name "Tony Ampomah"
      user-mail-address "tony@arksolutions.it")

;; (save-place-mode t)

(setq epg-gpg-program "gpg")
(setq auth-sources
      '((:source "~/.authinfo.gpg")))

;; display date and time
(setq display-time-day-and-date t)
(setq display-time-format "%e %b %y  %H:%M")
;; (setq display-time-default-load-average nil)
(display-time-mode 1) ;; add time

;; start calendar from Monday
(setq calendar-week-start-day 1)

;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(setq js-indent-level 2)
(setq css-indent-offset 2)
(setq-default c-basic-offset 2)
(setq c-basic-offset 2)
(setq-default tab-width 2)
(setq-default c-basic-indent 2)


(global-auto-revert-mode t)
(global-visual-line-mode 1)

;; Don't litter my init file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

;; Larger package-specific configurations.
(require 'init-elpa)
(require 'init-functions)
(require 'init-key-bindings)
(require 'init-evil)
(require 'init-completion)
(require 'init-fonts)
(require 'init-projectile)
(require 'init-company)
(require 'init-flycheck)
(require 'init-dired)
(require 'init-php)
(require 'init-apps)
(require 'init-org)
(require 'init-theme)
(require 'init-treemacs)
(require 'init-workspace)
(require 'init-terminal)
(require 'init-emails)
(require 'init-tools)

;; exec-path-from-shell
(use-package exec-path-from-shell)
(setq exec-path-from-shell-check-startup-files nil)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; which-key
(use-package which-key
  :diminish which-key-mode
  :config (which-key-mode))

;; dump-jump
(use-package dumb-jump
  :config
  (define-key evil-normal-state-map (kbd "M-.") 'dumb-jump-go)
  (setq dumb-jump-selector 'ivy)
  :diminish dumb-jump-mode)

;; web-mode
(use-package web-mode
  :ensure t
  :diminish web-mode)

;; scss-mode
(use-package scss-mode
  :config
  (setq scss-compile-at-save nil))

;; less-css-mode
(use-package less-css-mode)

;; css-mode
(use-package css-mode
  :config
  (setq css-indent-offset 2))

;; yaml-mode
(use-package yaml-mode)

;; restclient
(use-package restclient)

;; coffee-mode
(use-package coffee-mode)

;; javascript
(setq js-indent-level 2)
(add-hook 'coffee-mode-hook
          (lambda ()
            (yas-minor-mode 1)
            (setq coffee-tab-width 2)))

;; json-mode
(use-package json-mode)

;; markdown-mode
(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc --no-highlight"))

;; ledger-mode
(setq ledger-post-amount-alignment-column 70)
(use-package ledger-mode)
(use-package flycheck-ledger)
(use-package evil-ledger)

;; csv-mode
(use-package csv-mode
  :ensure t)

;; editorconfig
(use-package editorconfig
  :diminish editorconfig-mode
  :ensure t
  :config
  (editorconfig-mode 1))

;; yasnippet
(use-package yasnippet
  :diminish yas-minor-mode
  :ensure t
  :config
  (setq yas-snippet-dirs
        '("~/.emacs.d/snippets"))
  (yas-global-mode 1))

;; dotenv-mode
(use-package dotenv-mode)
