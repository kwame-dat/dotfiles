;;; ~/.config/doom/autoload/tonyampomah.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +kwame-dat/visit-emacs-config ()
  (interactive)
  (find-file "~/.emacs.d/emacs.org"))

;;;###autoload
(defun +kwame-dat/visit-host-file ()
  (interactive)
  (find-file "/sudo:root@localhost:/etc/hosts"))

;;;###autoload
(defun +kwame-dat/visit-ssh-config ()
  (interactive)
  (find-file "~/.ssh/config"))

;;;###autoload
(defun +kwame-dat/visit-emacs-config ()
  (interactive)
  (find-file "~/.doom/config.el"))

;;;###autoload
(defun +kwame-dat/visit-dwm-config ()
  (interactive)
  (find-file "~/Repo/Personal/2Areas/dwm/config.h"))

;;;###autoload
(defun +kwame-dat/visit-resolv-config ()
  (interactive)
  (find-file "/sudo:root@localhost:/etc/resolv.conf"))

;;;###autoload
(defun +kwame-dat/find-in-notes ()
  (interactive)
  (counsel-find-file "~/Nextcloud/org"))

;;;###autoload
(defun open-terminal-in-projectile-root ()
  (interactive)
  (let ((workdir (if (projectile-project-root)
                     (projectile-project-root)
                   (projectile-project-root))))
    (call-process-shell-command
     (concat "alacritty --working-directory  "workdir) nil 0)))

;;;###autoload
(defun +kwame-dat/sudo-this-file (&optional arg)
  "Edit currently visited file as root.

  With a prefix ARG prompt for a file to visit.
  Will also prompt for a file to visit if current
  buffer is not visiting a file."
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

;;;###autoload
(defun +kwame-dat/day-view ()
  (interactive)
  (progn (org-agenda nil "a")
         (org-agenda-day-view)))

(defadvice ido-find-file (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))
