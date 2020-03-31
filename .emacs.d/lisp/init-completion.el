;;; init-completion.el --- Please help me complete stuff
;;; Commentary:
;;; Code:
;; Completion framework
(use-package swiper
  :defer t
  :ensure t)

(use-package flx
  :ensure t)

(use-package counsel
  :init
  (setq counsel-git-cmd "git ls-files --full-name --exclude-standard --others --cached --")
  :ensure t)

(use-package counsel-projectile
  :defer t
  :ensure t)

(use-package ivy
  :defer t
  :init
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-on-del-error-function #'ignore)
  (setq ivy-re-builders-alist
        '((swiper . ivy--regex-plus)
          (swiper-isearch . ivy--regex-plus)
          (counsel-ag . ivy--regex-plus)
          (counsel-rg . ivy--regex-plus)
          (t      . ivy--regex-fuzzy)))
  :config
  (ivy-mode 1)
  (evil-set-initial-state 'ivy-occur-grep-mode 'normal))

;;----------------------------------------------------------------------------
;; Company
;;----------------------------------------------------------------------------
(require 'init-company)

(provide 'init-completion)

;;; init-completion.el ends here
