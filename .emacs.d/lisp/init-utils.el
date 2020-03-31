;;; init-utils.el --- Elisp helper functions and commands -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(defun itechytony/visit-emacs-config ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun itechytony/visit-host-file ()
  (interactive)
  (find-file "/etc/hosts"))

(defun itechytony/find-in-notes ()
  (interactive)
  (counsel-find-file "~/Dropbox/org"))

(defun itechytony/find-in-documents ()
  (interactive)
  (counsel-find-file "~/Documents"))

(defun itechytony/find-projects-in-documents ()
  (interactive)
  (counsel-find-file "~/Documents/1Projects"))

(defun itechytony/find-areas-in-documents ()
  (interactive)
  (counsel-find-file "~/Documents/2Areas"))

(defun itechytony/find-resources-in-documents ()
  (interactive)
  (counsel-find-file "~/Documents/3Resources"))

(defun itechytony/visit-todo-list-file ()
  (interactive)
  (find-file "~/Dropbox/org/todo.org"))

(defun itechytony/visit-inbox ()
  (interactive)
  (find-file "~/Dropbox/org/inbox.org"))


(provide 'init-utils)
;;; init-utils.el ends here
