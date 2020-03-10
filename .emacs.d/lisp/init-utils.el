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

;;;###autoload
(defun itechytony-project-root (&optional dir)
  "Return the project root of DIR (defaults to `default-directory').
Returns nil if not in a project."
  (let ((projectile-project-root (unless dir projectile-project-root))
        projectile-require-project-root)
    (projectile-project-root dir)))


(defconst itechytony-emacs-dir
  (eval-when-compile (file-truename user-emacs-directory))
  "The path to the currently loaded .emacs.d directory. Must end with a slash.")

;;;###autoload
(defun itechytony-project-find-file (dir)
  "Jump to a file in DIR (searched recursively).

If DIR is not a project, it will be indexed (but not cached)."
  (unless (file-directory-p dir)
    (error "Directory %S does not exist" dir))
  (unless (file-readable-p dir)
    (error "Directory %S isn't readable" dir))
  (let* ((default-directory (file-truename (expand-file-name dir)))
         (project-root (itechytony-project-root default-directory))
         (projectile-project-root default-directory)
         (projectile-enable-caching projectile-enable-caching))
    (cond ((and project-root (file-equal-p project-root projectile-project-root))
           (unless (itechytony-project-p projectile-project-root)
             ;; Disable caching if this is not a real project; caching
             ;; non-projects easily has the potential to inflate the projectile
             ;; cache beyond reason.
             (setq projectile-enable-caching nil))
           (call-interactively
            ;; Intentionally avoid `helm-projectile-find-file', because it runs
            ;; asynchronously, and thus doesn't see the lexical
            ;; `default-directory'
            (if (itechytony-module-p :completion 'ivy)
                #'counsel-projectile-find-file
              #'projectile-find-file)))
          ((fboundp 'counsel-file-jump) ; ivy only
           (call-interactively #'counsel-file-jump))
          ((project-current)
           (project-find-file-in nil (list default-directory) nil))
          ((fboundp 'helm-find-files)
           (call-interactively #'helm-find-files))
          ((call-interactively #'find-file)))))


;;;###autoload
(defun +default/browse-project ()
  "Browse files from the current project's root."
  (interactive) (itechytony-project-browse (itechytony-project-root)))
;; NOTE No need for find-in-project, use `projectile-find-file'

;;;###autoload
(defun +default/browse-templates ()
  "Browse files from `+file-templates-dir'."
  (interactive) (itechytony-project-browse +file-templates-dir))
;;;###autoload
(defun +default/find-in-templates ()
  "Find a file under `+file-templates-dir', recursively."
  (interactive) (itechytony-project-find-file +file-templates-dir))

;;;###autoload
(defun +default/browse-emacsd ()
  "Browse files from `itechytony-emacs-dir'."
  (interactive) (itechytony-project-browse itechytony-emacs-dir))
;;;###autoload
(defun +default/find-in-emacsd ()
  "Find a file under `itechytony-emacs-dir', recursively."
  (interactive) (itechytony-project-find-file itechytony-emacs-dir))

;;;###autoload
(defun +default/browse-notes ()
  "Browse files from `org-directory'."
  (interactive) (itechytony-project-browse org-directory))
;;;###autoload
(defun +default/find-in-notes ()
  "Find a file under `org-directory', recursively."
  (interactive) (itechytony-project-find-file org-directory))

;;;###autoload
(defun +default/find-file-under-here ()
  "Perform a recursive file search from the current directory."
  (interactive)
  (if (featurep! :completion ivy)
      (call-interactively #'counsel-file-jump)
    (λ! (itechytony-project-find-file default-directory))))

;;;###autoload
(defun +default/discover-projects (arg)
  "Discover projects in `projectile-project-search-path'.
If prefix ARG is non-nil, prompt for the search path."
  (interactive "P")
  (if arg
      (call-interactively #'projectile-discover-projects-in-directory)
    (mapc #'projectile-discover-projects-in-directory projectile-project-search-path)))

(defun itechytony--resolve-path-forms (spec &optional directory)
  "Converts a simple nested series of or/and forms into a series of
`file-exists-p' checks.

For example

  (itechytony--resolve-path-forms
    '(or A (and B C))
    \"~\")

Returns (approximately):

  '(let* ((_directory \"~\")
          (A (expand-file-name A _directory))
          (B (expand-file-name B _directory))
          (C (expand-file-name C _directory)))
     (or (and (file-exists-p A) A)
         (and (if (file-exists-p B) B)
              (if (file-exists-p C) C))))

This is used by `file-exists-p!' and `project-file-exists-p!'."
  (declare (pure t) (side-effect-free t))
  (let ((exists-fn (if (fboundp 'projectile-file-exists-p)
                       #'projectile-file-exists-p
                     #'file-exists-p)))
    (if (and (listp spec)
             (memq (car spec) '(or and)))
        (cons (car spec)
              (mapcar (itechytony-rpartial #'itechytony--resolve-path-forms directory)
                      (cdr spec)))
      (let ((filevar (make-symbol "file")))
        `(let* ((file-name-handler-alist nil)
                (,filevar ,spec))
           (and (stringp ,filevar)
                ,(if directory
                     `(let ((default-directory ,directory))
                        (,exists-fn ,filevar))
                   (list exists-fn filevar))
                ,filevar))))))

(defun itechytony--path (&rest segments)
  (let (file-name-handler-alist)
    (let ((dir (pop segments)))
      (unless segments
        (setq dir (expand-file-name dir)))
      (while segments
        (setq dir (expand-file-name (car segments) dir)
              segments (cdr segments)))
      dir)))

;;;###autoload
(defun itechytony-glob (&rest segments)
  "Construct a path from SEGMENTS and expand glob patterns.
Returns nil if the path doesn't exist."
  (let* (case-fold-search
         file-name-handler-alist
         (dir (apply #'itechytony--path segments)))
    (if (string-match-p "[[*?]" dir)
        (file-expand-wildcards dir t)
      (if (file-exists-p dir)
          dir))))

;;;###autoload
(defun itechytony-path (&rest segments)
  "Constructs a file path from SEGMENTS."
  (if segments
      (apply #'itechytony--path segments)
    (file!)))

;;;###autoload
(defun itechytony-dir (&rest segments)
  "Constructs a path from SEGMENTS.
See `itechytony-path'."
  (when-let (path (apply #'itechytony-path segments))
    (directory-file-name (file-name-directory path))))

;;;###autoload
;; (cl-defun itechytony-files-in
;;     (paths &rest rest
;;            &key
;;            filter
;;            map
;;            (full t)
;;            (follow-symlinks t)
;;            (type 'files)
;;            (relative-to (unless full default-directory))
;;            (depth 99999)
;;            (mindepth 0)
;;            (match "/[^._][^/]+"))
;;   "Return a list of files/directories in PATHS (one string or a list of them).
;; 
;; FILTER is a function or symbol that takes one argument (the path). If it returns
;; non-nil, the entry will be excluded.
;; 
;; MAP is a function or symbol which will be used to transform each entry in the
;; results.
;; 
;; TYPE determines what kind of path will be included in the results. This can be t
;; (files and folders), 'files or 'dirs.
;; 
;; By default, this function returns paths relative to PATH-OR-PATHS if it is a
;; single path. If it a list of paths, this function returns absolute paths.
;; Otherwise, by setting RELATIVE-TO to a path, the results will be transformed to
;; be relative to it.
;; 
;; The search recurses up to DEPTH and no further. DEPTH is an integer.
;; 
;; MATCH is a string regexp. Only entries that match it will be included."
;;   (let (result file-name-handler-alist)
;;     (dolist (file (mapcan (itechytony-rpartial #'itechytony-glob "*") (itechytony-enlist paths)))
;;       (cond ((file-directory-p file)
;;              (appendq!
;;               result
;;               (and (memq type '(t dirs))
;;                    (string-match-p match file)
;;                    (not (and filter (funcall filter file)))
;;                    (not (and (file-symlink-p file)
;;                              (not follow-symlinks)))
;;                    (<= mindepth 0)
;;                    (list (cond (map (funcall map file))
;;                                (relative-to (file-relative-name file relative-to))
;;                                (file))))
;;               (and (>= depth 1)
;;                    (apply #'itechytony-files-in file
;;                           (append (list :mindepth (1- mindepth)
;;                                         :depth (1- depth)
;;                                         :relative-to relative-to)
;;                                   rest)))))
;;             ((and (memq type '(t files))
;;                   (string-match-p match file)
;;                   (not (and filter (funcall filter file)))
;;                   (<= mindepth 0))
;;              (push (if relative-to
;;                        (file-relative-name file relative-to)
;;                      file)
;;                    result))))
;;     result))
;; 
;; ;;;###autoload
;; (defun itechytony-file-cookie-p (file &optional cookie null-value)
;;   "Returns the evaluated result of FORM in a ;;;###COOKIE FORM at the top of
;; FILE.
;; 
;; If COOKIE doesn't exist, return NULL-VALUE."
;;   (unless (file-exists-p file)
;;     (signal 'file-missing file))
;;   (unless (file-readable-p file)
;;     (error "%S is unreadable" file))
;;   (with-temp-buffer
;;     (insert-file-contents file nil 0 256)
;;     (if (re-search-forward (format "^;;;###%s " (regexp-quote (or cookie "if")))
;;                            nil t)
;;         (let ((load-file-name file))
;;           (eval (sexp-at-point) t))
;;       null-value)))

;;;###autoload
(defmacro file-exists-p! (files &optional directory)
  "Returns non-nil if the FILES in DIRECTORY all exist.

DIRECTORY is a path; defaults to `default-directory'.

Returns the last file found to meet the rules set by FILES, which can be a
single file or nested compound statement of `and' and `or' statements."
  `(let ((p ,(itechytony--resolve-path-forms files directory)))
     (and p (expand-file-name p ,directory))))

;;;###autoload
(defun itechytony-file-size (file &optional dir)
  "Returns the size of FILE (in DIR) in bytes."
  (let ((file (expand-file-name file dir)))
    (unless (file-exists-p file)
      (error "Couldn't find file %S" file))
    (unless (file-readable-p file)
      (error "File %S is unreadable; can't acquire its filesize"
             file))
    (nth 7 (file-attributes file))))

(defvar w32-get-true-file-attributes)
;;;###autoload
(defun itechytony-directory-size (dir)
  "Returns the size of FILE (in DIR) in kilobytes."
  (unless (file-directory-p dir)
    (error "Directory %S does not exist" dir))
  (if (executable-find "du")
      (/ (string-to-number (cdr (itechytony-call-process "du" "-sb" dir)))
         1024.0)
    ;; REVIEW This is slow and terribly inaccurate, but it's something
    (let ((w32-get-true-file-attributes t)
          (file-name-handler-alist dir)
          (max-lisp-eval-depth 5000)
          (sum 0.0))
      (dolist (attrs (directory-files-and-attributes dir nil nil t) sum)
        (unless (member (car attrs) '("." ".."))
          (cl-incf
           sum (if (eq (nth 1 attrs) t) ; is directory
                   (itechytony-directory-size (expand-file-name (car attrs) dir))
                 (/ (nth 8 attrs) 1024.0))))))))


;;
;;; Helpers

(defun itechytony--forget-file (path)
  "Ensure `recentf', `projectile' and `save-place' forget OLD-PATH."
  (when (bound-and-true-p recentf-mode)
    (recentf-remove-if-non-kept path))
  (when (and (bound-and-true-p projectile-mode)
             (itechytony-project-p)
             (projectile-file-cached-p path (itechytony-project-root)))
    (projectile-purge-file-from-cache path))
  (when (bound-and-true-p save-place-mode)
    (save-place-forget-unreadable-files)))

(defun itechytony--update-file (path)
  (when (featurep 'vc)
    (vc-file-clearprops path)
    (vc-resynch-buffer path nil t))
  (when (featurep 'magit)
    (when-let (default-directory (magit-toplevel (file-name-directory path)))
      (magit-refresh))))

(defun itechytony--copy-file (old-path new-path &optional force-p)
  (let* ((new-path (expand-file-name new-path))
         (old-path (file-truename old-path))
         (new-path (apply #'expand-file-name
                          (if (or (directory-name-p new-path)
                                  (file-directory-p new-path))
                              (list (file-name-nondirectory old-path) new-path)
                            (list new-path))))
         (new-path-dir (file-name-directory new-path))
         (project-root (itechytony-project-root))
         (short-new-name (if (and project-root (file-in-directory-p new-path project-root))
                             (file-relative-name new-path project-root)
                           (abbreviate-file-name new-path))))
    (unless (file-directory-p new-path-dir)
      (make-directory new-path-dir t))
    (when (buffer-modified-p)
      (save-buffer))
    (cond ((file-equal-p old-path new-path)
           (throw 'status 'overwrite-self))
          ((and (file-exists-p new-path)
                (not force-p)
                (not (y-or-n-p (format "File already exists at %s, overwrite?" short-new-name))))
           (throw 'status 'aborted))
          ((file-exists-p old-path)
           (copy-file old-path new-path t)
           short-new-name)
          (short-new-name))))


;;
;;; Commands

;;;###autoload
(defun itechytony/delete-this-file (&optional path force-p)
  "Delete FILENAME (defaults to the file associated with current buffer) and
kills the buffer. If FORCE-P, force the deletion (don't ask for confirmation)."
  (interactive
   (list (file-truename (buffer-file-name))
         current-prefix-arg))
  (let* ((fbase (file-name-sans-extension (file-name-nondirectory path)))
         (buf (current-buffer)))
    (cond ((not (file-exists-p path))
           (error "File doesn't exist: %s" path))
          ((not (or force-p (y-or-n-p (format "Really delete %s?" fbase))))
           (message "Aborted")
           nil)
          ((unwind-protect
               (progn (delete-file path) t)
             (let ((short-path (file-relative-name path (itechytony-project-root))))
               (if (file-exists-p path)
                   (error "Failed to delete %s" short-path)
                 ;; Ensures that windows displaying this buffer will be switched
                 ;; to real buffers (`itechytony-real-buffer-p')
                 (itechytony/kill-this-buffer-in-all-windows buf t)
                 (itechytony--forget-file path)
                 (itechytony--update-file path)
                 (message "Successfully deleted %s" short-path))))))))

;;;###autoload
(defun itechytony/copy-this-file (new-path &optional force-p)
  "Copy current buffer's file to NEW-PATH. If FORCE-P, overwrite the destination
file if it exists, without confirmation."
  (interactive
   (list (read-file-name "Copy file to: ")
         current-prefix-arg))
  (pcase (catch 'status
           (when-let (dest (itechytony--copy-file (buffer-file-name) new-path force-p))
             (itechytony--update-file new-path)
             (message "File successfully copied to %s" dest)))
    (`overwrite-self (error "Cannot overwrite self"))
    (`aborted (message "Aborted"))
    (_ t)))

;;;###autoload
(defun itechytony/move-this-file (new-path &optional force-p)
  "Move current buffer's file to NEW-PATH. If FORCE-P, overwrite the destination
file if it exists, without confirmation."
  (interactive
   (list (read-file-name "Move file to: ")
         current-prefix-arg))
  (pcase (catch 'status
           (let ((old-path (buffer-file-name))
                 (new-path (expand-file-name new-path)))
             (when-let (dest (itechytony--copy-file old-path new-path force-p))
               (itechytony--forget-file old-path)
               (when (file-exists-p old-path)
                 (delete-file old-path))
               (mapc #'itechytony--update-file
                     (delq
                      nil (list (if (ignore-errors
                                      (file-equal-p (itechytony-project-root old-path)
                                                    (itechytony-project-root new-path)))
                                    nil
                                  old-path)
                                new-path)))
               (kill-current-buffer)
               (find-file new-path)
               (message "File successfully moved to %s" dest))))
    (`overwrite-self (error "Cannot overwrite self"))
    (`aborted (message "Aborted"))
    (_ t)))

(defun itechytony--sudo-file (file)
  (let ((host (or (file-remote-p file 'host) "localhost")))
    (concat "/" (when (file-remote-p file)
                  (concat (file-remote-p file 'method) ":"
                          (if-let (user (file-remote-p file 'user))
                              (concat user "@" host)
                            host)
                          "|"))
            "sudo:root@" host
            ":" (or (file-remote-p file 'localname)
                    file))))

;;;###autoload
(defun itechytony/sudo-find-file (file)
  "Open FILE as root."
  (interactive "FOpen file as root: ")
  (find-file (itechytony--sudo-file file)))

;;;###autoload
(defun itechytony/sudo-this-file ()
  "Open the current file as root."
  (interactive)
  (find-alternate-file (itechytony--sudo-file (or buffer-file-name
                                            (when (or (derived-mode-p 'dired-mode)
                                                      (derived-mode-p 'wdired-mode))
                                              default-directory)))))

;;;###autoload
(defun itechytony/sudo-save-buffer ()
  "Save this file as root."
  (interactive)
  (let ((file (itechytony--sudo-file buffer-file-name)))
    (if-let (buffer (find-file-noselect file))
        (let ((origin (current-buffer)))
          (unwind-protect
              (with-current-buffer buffer
                (save-buffer))
            (unless (eq origin buffer)
              (kill-buffer buffer))))
      (user-error "Unable to open %S" file))))

(provide 'init-utils)
;;; init-utils.el ends here
