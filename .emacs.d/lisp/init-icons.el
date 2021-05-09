;;; init-icons.el --- icons -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package all-the-icons
  :defer t)

(use-package all-the-icons-ivy
  :defer t
  :config
  (all-the-icons-ivy-setup))

(provide 'init-icons)
;;; init-icons.el ends here
