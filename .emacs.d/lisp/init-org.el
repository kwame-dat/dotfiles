;;; init-org.el --- Set up Org Mode
;;; Commentary:
;; Basic Org Mode configuration, assuming presence of Evil & Evil Leader.

;;;###autoload
(defun +org-cycle-only-current-subtree-h (&optional arg)
  (interactive "P")
  (unless (eq this-command 'org-shifttab)
    (save-excursion
      (org-beginning-of-line)
      (let (invisible-p)
        (when (and (org-at-heading-p)
                   (or org-cycle-open-archived-trees
                       (not (member org-archive-tag (org-get-tags))))
                   (or (not arg)
                       (setq invisible-p (outline-invisible-p (line-end-position)))))
          (unless invisible-p
            (setq org-cycle-subtree-status 'subtree))
          (org-cycle-internal-local)
          t)))))

(setq org-icalendar-include-todo t
      org-icalendar-use-deadline '(event-if-todo event-if-not-todo todo-due)
      org-icalendar-use-scheduled '(event-if-todo event-if-not-todo todo-start)
      org-icalendar-with-timestamps t)
(setq org-startup-truncated nil)
(setq org-agenda-inhibit-startup nil)
(add-hook 'org-mode-hook 'org-indent-mode)

(setq org-refile-targets '((org-agenda-files :maxlevel . 2)))

(setq org-ellipsis "⤵")

(setq org-src-fontify-natively t)

(setq org-directory "~/org")
(setq org-agenda-files (quote (
                               "~/org/calendar/personal.org"
                               "~/org/calendar/shared.org"
                               "~/org/calendar/spouse.org"
                               "~/org/todo-home.org"
                               "~/org/todo-personal.org"
                               "~/org/todo-spiritual.org"
                               "~/org/todo-work.org"
                               )))

(add-hook 'org-capture-mode-hook 'evil-insert-state)
(setq org-capture-templates
      '(
        ("t" "Inbox - Personal" entry (file "~/org/inbox-personal.org")
         "* TODO %?\n")
        ("w" "Inbox - Work" entry (file "~/org/inbox-work.org")
         "* TODO %?\n")
        ("h" "Inbox - Home" entry (file "~/org/inbox-home.org")
         "* TODO %?\n")
        ("s" "Inbox - Spiritual" entry (file "~/org/inbox-spiritual.org")
         "* TODO %?\n")
        ("e" "Email" entry (file+headline "~/org/inbox.org" "Tasks")
         "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")
        ("p" "Project" entry (file+headline "~/org/todo-personal.org" "1Projects")
         (file "~/org/templates/new-project-template.org"))
        ("g" "Someday" entry (file+headline "~/org/someday.org" "Someday")
         "* SOMEDAY %?\n")
        ("l" "Log" entry (file+olp+datetree "~/org/log.org" "Log")
         (file "~/org/templates/logtemplate.org"))))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (emacs-lisp . t)
   (latex . t)
   (shell . t)
   (elasticsearch . t)
   (ledger . t)
   (python . t)
   (ruby . t)
   (sqlite . t)))

(setq org-confirm-babel-evaluate nil)

(use-package org
  :custom-face
  ;; (variable-pitch ((t (:family "Avenir"))))
  (org-document-title ((t (:weight bold ))))
  (org-done ((t (:strike-through t :weight bold))))
  (org-headline-done ((t (:strike-through t))))
  (org-level-1 ((t (:weight bold :height 1.2))))
  (org-level-2 ((t (:weight normal :height 1.2))))
  (org-level-3 ((t (:weight normal :height 1.2))))
  (org-image-actual-width '(600))
  :config
  (add-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h 'append)
  (setq org-todo-keywords
        '((sequence "TODO(t)"
                    "STARTED(s)"
                    "WAITING(w)"
                    "SOMEDAY(.)"
                    "MAYBE(m)"
                    "|"
                    "DONE(d!)"
                    "CANCELLED(c)"))))

(use-package ox-pandoc)

(use-package ox-jira)

(use-package ox-slack)

(use-package ox-twbs)

(use-package ob-restclient)

(use-package org-pomodoro
  :config
  (setq org-pomodoro-long-break-length 60)
  (setq org-pomodoro-long-break-frequency 10))

(use-package evil-org
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(setq jiralib-url "https://theampomahs.atlassian.net")
(use-package org-jira)

(use-package org-evil
  :config
  (evil-define-minor-mode-key 'normal 'org-evil-heading-mode "@" 'org-refile)
  (evil-define-minor-mode-key 'normal 'org-evil-heading-mode "#" 'org-add-note)
  (evil-define-minor-mode-key 'normal 'org-evil-heading-mode "+" 'org-shiftup)
  (evil-define-minor-mode-key 'normal 'org-evil-heading-mode "=" 'org-shiftdown))

(use-package org-gcal)

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package org-pdfview)

(use-package ox-slimhtml)

(use-package ox-clip
  :config
  (evil-define-key 'visual org-mode-map (kbd "gy") 'ox-clip-formatted-copy))

(provide 'init-org)
;;; init-org.el ends here
