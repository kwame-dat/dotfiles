;;; init-editing-utils.el --- Day-to-day editing helpers -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
;;----------------------------------------------------------------------------
;; Essential settings.
;;----------------------------------------------------------------------------
(blink-cursor-mode 0)
(setq initial-major-mode 'org-mode)
(setq-default buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(setq locale-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(setq load-prefer-newer t)
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
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(setq visible-bell t)
(setq vc-follow-symlinks t)
(setq large-file-warning-threshold nil)
(setq split-width-threshold nil)
(setq custom-safe-themes t)
(column-number-mode t)
(setq tab-width 4)
(setq tramp-default-method "ssh")

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

(setq auth-sources '("~/.authinfo.gpg" "~/.authinfo"))

;; display date and time
(setq display-time-day-and-date t)
(setq display-time-format "%H:%M | %a %e %B %Y ")
(setq display-time-default-load-average nil)
(display-time-mode 1)

(global-hl-line-mode)
(add-hook 'vterm-mode-hook (lambda ()
  (setq-local global-hl-line-mode nil)))

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

;; (global-auto-revert-mode t)
(global-visual-line-mode 1)


(provide 'init-editing-utils)
;;; init-editing-utils.el ends here
