;;; init-tools.el -- Installing useful tools
;;; Commentary:
;;; Code:
;; macos
;;;###autoload
(setq locate-command "mdfind")

;;;###autoload
(defun +macos-open-with (&optional app-name path)
  "Send PATH to APP-NAME on OSX."
  (interactive)
  (let* ((path (expand-file-name
                (replace-regexp-in-string
                 "'" "\\'"
                 (or path (if (derived-mode-p 'dired-mode)
                              (dired-get-file-for-visit)
                            (buffer-file-name)))
                 nil t)))
         (command (format "open %s"
                          (if app-name
                              (format "-a %s '%s'" (shell-quote-argument app-name) path)
                            (format "'%s'" path)))))
    (message "Running: %s" command)
    (shell-command command)))

        ;;;###autoload
(defmacro +macos--open-with (id &optional app dir)
  `(defun ,(intern (format "+macos/%s" id)) ()
     (interactive)
     (+macos-open-with ,app ,dir)))

        ;;;###autoload (autoload '+macos/open-in-default-program "tools/macos/autoload" nil t)
(+macos--open-with open-in-default-program)

        ;;;###autoload (autoload '+macos/reveal-in-finder "tools/macos/autoload" nil t)
(+macos--open-with reveal-in-finder "Finder" default-directory)

        ;;;###autoload (autoload '+macos/reveal-project-in-finder "tools/macos/autoload" nil t)
(+macos--open-with reveal-project-in-finder "Finder"
                   (or (doom-project-root) default-directory))

        ;;;###autoload (autoload '+macos/send-to-transmit "tools/macos/autoload" nil t)
(+macos--open-with send-to-transmit "Transmit")

        ;;;###autoload (autoload '+macos/send-cwd-to-transmit "tools/macos/autoload" nil t)
(+macos--open-with send-cwd-to-transmit "Transmit" default-directory)

        ;;;###autoload (autoload '+macos/send-to-launchbar "tools/macos/autoload" nil t)
(+macos--open-with send-to-launchbar "LaunchBar")

        ;;;###autoload (autoload '+macos/send-project-to-launchbar "tools/macos/autoload" nil t)
(+macos--open-with send-project-to-launchbar "LaunchBar"
                   (or (doom-project-root) default-directory))

;;docker
(use-package docker
  :ensure t)

;;pass
(use-package pass
  :ensure t)

;;ivy-pass
(use-package ivy-pass
  :ensure t)

;;pdf-tools
(use-package pdf-tools
  :ensure t
  :config (pdf-tools-install))

;;org-pdfview
(use-package org-pdfview
  :ensure t)

;; magit
(use-package magit
  :init
  (setq magit-status-buffer-switch-function 'switch-to-buffer)
  (setq magit-push-always-verify nil)
  (setq git-commit-summary-max-length 50)
  :config
  (use-package evil-magit)
  (use-package with-editor)
  (add-hook 'with-editor-mode-hook 'evil-insert-state)
  :ensure t)

;; git-gutter-fringe
(use-package git-gutter-fringe
  :ensure t
  :init
  (setq git-gutter-fr:side 'right-fringe)
  :diminish git-gutter-mode
  :config (global-git-gutter-mode))

;; debugging
(use-package dap-mode
  :ensure t
  :commands dap-mode
  :config
  (dap-mode 1)
  (require 'dap-ui)
  (dap-ui-mode 1)
  (require 'dap-lldb))

;; define-word
(use-package define-word
  :config
  (global-set-key (kbd "M-\\") 'define-word-at-point))

;; flyspell-correct-ivy
(use-package flyspell-correct-ivy
  :bind ("C-M-;" . flyspell-correct-wrapper)
  :init
  (setq flyspell-correct-interface #'flyspell-correct-ivy)
  (setq ispell-program-name "aspell"))

(add-to-list 'ispell-skip-region-alist '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_SRC" . "#\\+END_SRC"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_EXAMPLE" . "#\\+END_EXAMPLE"))

(add-hook 'text-mode-hook 'flyspell-mode)
(global-set-key (kbd "s-\\") 'ispell-word)

(provide 'init-tools)
;;; init-tools.el ends here
