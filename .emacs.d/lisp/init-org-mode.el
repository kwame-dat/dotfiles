;;; init-org-mode.el --- org-mode -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq-default fill-column 80)

;; Turn on indentation and auto-fill mode for Org files
(defun kd/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent nil))

(use-package org
  :defer t
  :straight (:type built-in)
  :ensure org-plus-contrib
  ;; :straight org-plus-contrib
  :hook (org-mode . kd/org-mode-setup)
  :config
  (setq org-ellipsis " ⤵"
	org-hide-emphasis-markers t
	org-src-fontify-natively t
	org-src-tab-acts-natively t
	org-edit-src-content-indentation 2
	org-hide-block-startup nil
	org-src-preserve-indentation nil
	org-agenda-skip-scheduled-if-done t
	org-startup-folded t
	org-cycle-separator-lines 2)

  (setq org-modules
	'(org-crypt
	  org-habit
	  org-bookmark
	  org-eshell
	  org-irc))

  (setq org-refile-targets '((nil :maxlevel . 1)
			     (org-agenda-files :maxlevel . 3)))

  ;; (setq org-outline-path-complete-in-steps nil)
  ;; (setq org-refile-use-outline-path t)

  (evil-define-key '(normal insert visual) org-mode-map (kbd "C-j") 'org-next-visible-heading)
  (evil-define-key '(normal insert visual) org-mode-map (kbd "C-k") 'org-previous-visible-heading)

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (latex . t)
     (shell . t)
     (ledger . t)
     (python . t)
     (sql . t)
     (ruby . t)
     ;; (tmux . t)
     (sqlite . t)
     (ledger . t)))

  (push '("conf-unix" . conf-unix) org-src-lang-modes))

;; (use-package org-notify
;;   :ensure nil
;;   :after org
;;   :config (org-notify-start))

(use-package org-pomodoro
  :defer t
  :after org
  :commands (org-mode org-pomodoro-mode)
  :config
  (setq org-pomodoro-long-break-length 60)
  (setq org-pomodoro-long-break-frequency 10))

(use-package org-gcal
  :after org
  :defer t)

(use-package org-jira
  :defer t
  :hook (org-mode . org-jira-mode)
  :after org
  :config
  (setq jiralib-url "https://jira.eandl.co.uk"))

(use-package ox-pandoc
  :after org
  :defer t
  :init (add-to-list 'org-export-backends 'pandoc))

(use-package ox-jira
  :after org
  :defer t
  :init (add-to-list 'org-export-backends 'jira))

(use-package  ox-slack
  :after org
  :defer t
  :init (add-to-list 'org-export-backends 'slack))

(use-package ox-twbs
  :after org
  :defer t
  :init (add-to-list 'org-export-backends 'twbs))

(use-package ox-slimhtml
  :after org
  :defer t
  :init (add-to-list 'org-export-backends 'slimhtml))

(use-package ob-async
  :after org
  :defer t)

(use-package ob-restclient
  :after org
  :defer t)

(use-package evil-org
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
	    (lambda () (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))


;; When editing a code snippet, use the current window rather than
;; popping open a new one (which shows the same information).
(setq org-src-window-setup 'current-window)


;; Don't indent newly expanded blocks, even if they're under a heading.
(setq org-adapt-indentation nil)

;; Automatically put quick capture into insert mode

(add-hook 'org-capture-mode-hook 'evil-insert-state)


;; Task Management & Agenda Views
(setq org-directory "~/org"
      org-agenda-files (quote (
			       "~/org/PTodo.org"
			       "~/org/STodo.org"
			       "~/org/joint/JTodo.org"
			       "~/org/WTodo.org"
			       "~/org/Gcal.org"
			       )))


;; Refile targets configuration 
(setq org-refile-targets
      '((nil :maxlevel . 3)
	(org-agenda-files :maxlevel . 3))
      org-refile-use-outline-path 'file
      org-outline-path-complete-in-steps nil)

(setq org-todo-keywords
      '((sequence
	 "TODO(t)"  ; A task that needs doing & is ready to do
	 "PROJ(p)"  ; A project, which usually contains other tasks
	 "STRT(s)"  ; A task that is in progress
	 "WAIT(w)"  ; Something external is holding up this task
	 "HOLD(h)"  ; This task is paused/on hold because of me
	 "|"
	 "DONE(d)"  ; Task successfully completed
	 "KILL(k)") ; Task was cancelled, aborted or is no longer applicable
	(sequence
	 "[ ](T)"   ; A task that needs doing
	 "[-](S)"   ; Task is in progress
	 "[?](W)"   ; Task is being held up or paused
	 "|"
	 "[X](D)")) ; Task was completed
      org-todo-keyword-faces
      '(("[-]"  . org-todo-active)
	("STRT" . (:foreground "orange" :weight bold))
	("[?]"  . (:foreground "red" :weight bold))
	("WAIT" . (:foreground "red" :weight bold))
	("HOLD" . (:foreground "red" :weight bold))
	("PROJ" . org-todo-project)))

(setq org-capture-templates
      '(
	("i" "Inbox" entry (file "~/org/Inbox.org")
	 "* TODO %?\n %i\n")
	("e" "Email" entry (file+headline "~/org/Inbox.org" "Emails")
	 "* TODO [#A] Process Email %:fromname on %:subject\nSCHEDULED:%t\nDEADLINE: %(org-insert-time-stamp (org-read-date nil t \"+2d\"))\n:PROPERTIES:\n:CREATED: %U\n:END:\n %a" :immediate-finish t :prepend t)
	("p" "Project" entry (file+headline "~/org/PTodo.org" "1Projects")
	 (file "~/org/templates/new-project.org"))
	("w" "workProject" entry (file+headline "~/org/WTodo.org" "1Projects")
	 (file "~/org/templates/new-project.org"))
	("m" "MeetingWorkbook" entry (file+headline "~/org/STodo.org" "Life & Ministry Workbook")
	 (file "~/org/templates/workbook.org"))
	("s" "Someday" entry (file+headline "~/org/PSomeday.org" "Someday")
	 "* SOMEDAY %?\n")))


;; I prefer indented in org mode please.
(setq org-startup-indented t)

;; Stop asking to confirm
(setq org-confirm-babel-evaluate nil)

;; Block Templates
(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("sh" . "src sh"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("sc" . "src scheme"))
(add-to-list 'org-structure-template-alist '("ts" . "src typescript"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("yaml" . "src yaml"))
(add-to-list 'org-structure-template-alist '("json" . "src json"))

;; Fonts & Bullets
;; I like to see an outline of pretty bullets instead of a list of asterisks.
(use-package org-bullets
  :init
  (add-hook 'org-mode-hook 'org-bullets-mode))

;; Replace list hyphen with dot
;; (font-lock-add-keywords 'org-mode
;;                         '(("^ *\\([-]\\) "
;;                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

;; Generate Table of Contents Dynamically
(use-package toc-org
  :after org
  :init (add-hook 'org-mode-hook #'toc-org-enable))

;; Increase the size of various headings
(set-face-attribute 'org-document-title nil :font "Cantarell" :weight 'bold :height 1.3)
(dolist (face '((org-level-1 . 1.2)
		(org-level-2 . 1.1)
		(org-level-3 . 1.05)
		(org-level-4 . 1.0)
		(org-level-5 . 1.1)
		(org-level-6 . 1.1)
		(org-level-7 . 1.1)
		(org-level-8 . 1.1)))
  (set-face-attribute (car face) nil :font "Cantarell" :weight 'medium :height (cdr face)))

;; Make sure org-indent face is available
(require 'org-indent)

;; Ensure that anything that should be fixed-pitch in Org files appears that way
(set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
(set-face-attribute 'org-table nil  :inherit 'fixed-pitch)
(set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
(set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
(set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
(set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
(set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

;; Get rid of the background on column views
(set-face-attribute 'org-column nil :background nil)
(set-face-attribute 'org-column-title nil :background nil)


;; Organisation (GTD and PARA)
;; A project is “any outcome that will
;; take more than one action step to complete.” As a result of
;; implementing Tiago Forte’s “PARA” system, I can ensure that I
;; always have an up to date project list.

;; Projects
(defun go-to-projects ()
  (interactive)
  (find-file "~/org/PTodo.org")
  (widen)
  (beginning-of-buffer)
  (re-search-forward "* Projects")
  (beginning-of-line))

(defun project-overview ()
  (interactive)
  (go-to-projects)
  (org-narrow-to-subtree)
  (org-sort-entries t ?p)
  (org-columns))

(defun project-deadline-overview ()
  (interactive)
  (go-to-projects)
  (org-narrow-to-subtree)
  (org-sort-entries t ?d)
  (org-columns))


(defun my-org-agenda-list-stuck-projects ()
  (interactive)
  (go-to-projects)
  (org-agenda nil "#" 'subtree))


;; Areas
(defun go-to-areas ()
  (interactive)
  (find-file "~/org/PTodo.org")
  (widen)
  (beginning-of-buffer)
  (re-search-forward "* Areas")
  (beginning-of-line))

(defun areas-overview ()
  (interactive)
  (go-to-areas)
  (org-narrow-to-subtree)
  (org-columns))


;; Reviews
(defun my-new-daily-review ()
  (interactive)
  (let ((org-capture-templates '(("d" "Review: Daily Review" entry (file+olp+datetree "/tmp/reviews.org")
				  (file "~/org/reviews/daily-review-template.org")))))
    (progn
      (org-capture nil "d")
      (org-capture-finalize t)
      (org-speed-move-safe 'outline-up-heading)
      (org-narrow-to-subtree)
      (fetch-calendar)
      (org-clock-in))))

(defun my-new-weekly-review ()
  (interactive)
  (let ((org-capture-templates '(("w" "Review: Weekly Review" entry (file+olp+datetree "/tmp/reviews.org")
				  (file "~/org/reviews/weekly-review-template.org")))))
    (progn
      (org-capture nil "w")
      (org-capture-finalize t)
      (org-speed-move-safe 'outline-up-heading)
      (org-narrow-to-subtree)
      (fetch-calendar)
      (org-clock-in))))

(defun my-new-monthly-review ()
  (interactive)
  (let ((org-capture-templates '(("m" "Review: Monthly Review" entry (file+olp+datetree "/tmp/reviews.org")
				  (file "~/org/reviews/monthly-review-template.org")))))
    (progn
      (org-capture nil "m")
      (org-capture-finalize t)
      (org-speed-move-safe 'outline-up-heading)
      (org-narrow-to-subtree)
      (fetch-calendar)
      (org-clock-in))))

(bind-keys :prefix-map review-map
	   :prefix "C-c r"
	   ("d" . my-new-daily-review)
	   ("w" . my-new-weekly-review)
	   ("m" . my-new-monthly-review))

(defun kd/day-view ()
  (interactive)
  (progn (org-agenda nil "a")
	 (org-agenda-day-view)))


;; Bindings
(kd/leader-key-def
      ;;; <leader> n --- notes
  "nf" '(lambda() (interactive) (counsel-find-file "~/org"))
  "n." '(lambda() (interactive) (counsel-find-file "~/org"))
  "ni" '(lambda() (interactive) (find-file "~/org/Inbox.org"))
  "np" '(lambda() (interactive) (find-file "~/org/PTodo.org"))
  "nw" '(lambda() (interactive) (find-file "~/org/WTodo.org"))
  "ns" '(lambda() (interactive) (find-file "~/org/STodo.org"))
  "nj" '(lambda() (interactive) (find-file "~/org/joint/JTodo.org"))
  "na" 'org-agenda
  "nd" 'kd/day-view
  "nci" 'org-pomodoro
  "nco" 'org-pomodoro-clock-break
  "nn" 'org-capture
  "nv" 'org-search-view
  )

(kd/my-local-leader-def 'normal org-mode-map
  "c" 'org-ctrl-c-ctrl-c
  "t" 'org-todo
  "s" 'org-schedule
  "d" 'org-deadline
  "a" 'org-agenda
  "e" 'org-export-dispatch
  "n" 'org-narrow-to-element
  "w" 'widen
  "r" 'org-refile)

(provide 'init-org-mode)
;;; init-org-mode.el ends here
