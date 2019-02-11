;;; init.el --- GNU Emacs Configuration
;; Author: Tony Ampomah <tony@arksolutions.it>
;; Created: December 2018
;;; Commentary:
;;; Code:

;; Make startup faster by reducing the frequency of garbage
(setq gc-cons-threshold (* 50 1000 1000))
;; collection.
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("elpy" . "https://jorgenschaefer.github.io/packages/"))
(package-initialize)

;; Ensure that use-package is installed.
;;
;; If use-package isn't already installed, it's extremely likely that this is a
;; fresh installation! So we'll want to update the package repository and
;; install use-package before loading the literate configuration.
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

;; (org-babel-load-file "~/.emacs.d/config.org")
(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))
;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))

;;; init.el ends here
(put 'dired-find-alternate-file 'disabled nil)
