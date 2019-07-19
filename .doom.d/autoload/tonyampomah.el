;;; ~/.config/doom/autoload/tonyampomah.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +tonyampomah/find-in-dotfiles ()
  "Open a file somewhere in ~/.dotfiles via a fuzzy filename search."
  (interactive)
  (doom-project-find-file (expand-file-name "~/Dotfiles")))

;;;###autoload
(defun +tonyampomah/browse-dotfiles ()
  "Browse the files in ~/.dotfiles."
  (interactive)
  (doom-project-browse (expand-file-name "~/Dotfiles")))

;;;###autoload
(defun +tonyampomah/find-notes-for-major-mode (&optional arg)
  "TODO"
  (interactive "P")
  (let ((default-directory (expand-file-name "~/Notes" org-directory)))
    (if arg
        (call-interactively #'find-file)
      (find-file
       (expand-file-name (concat (string-remove-suffix "-mode" (symbol-name major-mode)) ".org"))))))

;;;###autoload
(defun +tonyampomah/find-notes-for-project (&optional arg)
  "TODO"
  (interactive "P")
  (let ((project-root (doom-project-name 'nocache))
        (default-directory (expand-file-name "projects/" org-directory)))
    (if arg
        (call-interactively #'find-file)
      (find-file
       (expand-file-name (concat project-root ".org"))))))

;;;###autoload
(defun +tonyampomah-toggle-line-spacing ()
  "Toggle line spacing between no extra space to extra half line height.
URL `http://ergoemacs.org/emacs/emacs_toggle_line_spacing.html'
Version 2017-06-02"
  (interactive)
  (if line-spacing
      (setq line-spacing nil)
    (setq line-spacing 0.5))
  (redraw-frame (selected-frame)))

;;;###autoload
(defun +tonyampomah-go-to-projects ()
  (interactive)
  (find-file "~/GTD/todo.org")
  (widen)
  (beginning-of-buffer)
  (re-search-forward "* Projects")
  (beginning-of-line))

;;;###autoload
(defun +tonyampomah-project-overview ()
  (interactive)
  (go-to-projects)
  (org-narrow-to-subtree)
  (org-sort-entries t ?p)
  (org-columns))

;;;###autoload
(defun +tonyampomah-project-deadline-overview ()
  (interactive)
  (go-to-projects)
  (org-narrow-to-subtree)
  (org-sort-entries t ?d)
  (org-columns))

;;;###autoload
(defun +tonyampomah-agenda-list-stuck-projects ()
  (interactive)
  (go-to-projects)
  (org-agenda nil "#" 'subtree))

;;;###autoload
(defun +tonyampomah-go-to-areas ()
    (interactive)
    (find-file "~/GTD/todo.org")
    (widen)
    (beginning-of-buffer)
    (re-search-forward "* Areas")
    (beginning-of-line))

;;;###autoload
(defun +tonyampomah-areas-overview ()
    (interactive)
    (go-to-areas)
    (org-narrow-to-subtree)
    (org-columns))
