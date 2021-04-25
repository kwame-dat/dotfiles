;;; ~/.config/doom/autoload/tonyampomah.el -*- lexical-binding: t; -*-

;;;###autoload
(defun itechytony/visit-emacs-config ()
  (interactive)
  (find-file "~/.emacs.d/emacs.org"))

(defun itechytony/visit-host-file ()
  (interactive)
  (find-file "/sudo:root@localhost:/etc/hosts"))

(defun itechytony/edit-ssh-config ()
  (interactive)
  (find-file "~/.ssh/config"))

(defun itechytony/edit-emacs-config ()
  (interactive)
  (find-file "~/.emacs.d/config.org"))

(defun itechytony/visit-resolv-conf ()
  (interactive)
  (find-file "/sudo:root@localhost:/etc/resolv.conf"))

(defun itechytony/find-in-notes ()
  (interactive)
  (counsel-find-file "~/org"))

(defun open-terminal-in-projectile-root ()
  (interactive)
  (let ((workdir (if (projectile-project-root)
                     (projectile-project-root)
                   (projectile-project-root))))
    (call-process-shell-command
     (concat "alacritty --working-directory  "workdir) nil 0)))

(defun itechytony/sudo-this-file (&optional arg)
  "Edit currently visited file as root.

  With a prefix ARG prompt for a file to visit.
  Will also prompt for a file to visit if current
  buffer is not visiting a file."
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun itechytony/sudo-find-file (file-name)
  "Like find file, but opens the file as root."
  (interactive "FSudo Find File: ")
  (let ((tramp-file-name (concat "/sudo::" (expand-file-name file-name))))
    (find-file tramp-file-name)))

(defun itechytony/day-view ()
  (interactive)
  (progn (org-agenda nil "a")
         (org-agenda-day-view)))

(defadvice ido-find-file (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun +itechytony/search-project-for-symbol-at-point ()
  "Bring up a `counsel-dash' search interface with symbol at point."
  (interactive)
  (counsel-rg
   (substring-no-properties (or (thing-at-point 'symbol) ""))))
