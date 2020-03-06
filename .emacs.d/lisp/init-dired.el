;;; init-dired.el --- Dired config
;;; Commentary:
;;; Code:

(defun itechytony-dired-mode-setup ()
  "to be run as hook for `dired-mode'."
  (dired-hide-details-mode 1))
(add-hook 'dired-mode-hook 'itechytony-dired-mode-setup)

(setq dired-dwim-target t)
(setq dired-hide-details-mode t)
(setq dired-clean-up-buffers-too t)
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'top)

(evil-define-key 'normal global-map (kbd "-")       'dired-jump)
(evil-define-key 'normal dired-mode-map (kbd "j") 'dired-next-line)
(evil-define-key 'normal dired-mode-map (kbd "k") 'dired-previous-line)


(use-package async
  :diminish dired-async-mode
  :config
  (dired-async-mode 1))

(use-package dired-narrow
  :diminish dired-narrow-mode
  :ensure t
  :config
  (bind-key "C-c C-n" #'dired-narrow)
  (bind-key "C-c C-f" #'dired-narrow-fuzzy)
  (bind-key "C-x C-N" #'dired-narrow-regexp))

(use-package dired-subtree :ensure t
  :after dired
  :config
  (bind-key "<tab>" #'dired-subtree-toggle dired-mode-map)
  (bind-key "<backtab>" #'dired-subtree-cycle dired-mode-map))

(use-package dired-hide-dotfiles
  :config
  (dired-hide-dotfiles-mode)
  (define-key dired-mode-map "." 'dired-hide-dotfiles-mode))

(use-package dired-open
  :config
  (setq dired-open-extensions
        '(("pdf" . "zathura")
          ("xlsx" . "gnumeric")
          ("mkv" . "mpv")
          ("mp3" . "mpv")
          ("mp4" . "mpv")
          ("avi" . "mpv"))))

(provide 'init-dired)
;;; init-dired.el ends here
