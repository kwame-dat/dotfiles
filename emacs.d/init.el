;;; Package --- Summary

;;; Commentary:
;; Emacs init file responsible for either loading a pre-compiled configuration file
;; or tangling and loading a literate org configuration file.

;;; Code:

;; Don't attempt to find/apply special file handlers to files loaded during startup.
(let ((file-name-handler-alist nil))
  ;; If config is pre-compiled, then load that
  (if (file-exists-p (expand-file-name "emacs.elc" user-emacs-directory))
      (load-file (expand-file-name "emacs.elc" user-emacs-directory))
    ;; Otherwise use org-babel to tangle and load the configuration
    (require 'org)
    (org-babel-load-file (expand-file-name "emacs.org" user-emacs-directory))))

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ag rainbow-mode doom-themes yasnippet yagist writeroom-mode writegood-mode window-purpose which-key wgrep web-mode vterm-toggle use-package typescript-mode treemacs-projectile treemacs-magit treemacs-icons-dired treemacs-evil toc-org synosaurus speed-type slack shell-pop shackle scss-mode psysh prettier-js powerline-evil phpunit phpactor php-mode php-cs-fixer pdf-tools pass ox-twbs ox-slimhtml ox-slack ox-pandoc ox-jira org-superstar org-pomodoro org-plus-contrib org-jira org-gcal org-evil openwith ob-restclient nov mu4e-alert mixed-pitch magit-todos magit-gitflow lsp-ui lsp-ivy langtool js2-mode ivy-posframe ivy-pass haskell-mode github-review github-clone git-gutter-fringe general fountain-mode forge flyspell-correct-popup flyspell-correct-ivy flycheck-ledger eyebrowse exec-path-from-shell evil-surround evil-org evil-multiedit evil-mc evil-magit evil-ledger evil-commentary evil-collection es-mode eredis engine-mode emms editorconfig dotenv-mode doom-modeline dockerfile-mode docker-compose-mode docker dired-subtree dired-narrow diminish define-word dap-mode csv-mode counsel-tramp counsel-projectile company-prescient company-dict company-box coffee-mode calfw-org calfw-ical calfw-cal calfw bug-reference-github browse-at-remote base16-theme amx all-the-icons-ivy-rich all-the-icons-ivy all-the-icons-dired airline-themes)))
 '(shell-pop-full-span t)
 '(shell-pop-shell-type (quote ("vterm" "*vterm*" (lambda nil (vterm)))))
 '(shell-pop-term-shell "/usr/bin/fish")
 '(shell-pop-window-position "bottom")
 '(shell-pop-window-size 45))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-ui-doc-background ((t (:background nil))))
 '(lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic)))))
 '(org-document-title ((t (:weight bold))))
 '(org-image-actual-width (quote (600)))
 '(org-level-1 ((t (:weight bold :height 1.2))))
 '(org-level-2 ((t (:weight normal :height 1.2))))
 '(org-level-3 ((t (:weight normal :height 1.2))))
 '(variable-pitch ((t (:family "Noto Sans")))))
