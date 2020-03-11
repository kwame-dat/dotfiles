;;; init-pdf-tools.el --- pdf-tools installation and configuration -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(use-package pdf-tools
  :config
  (setq-default pdf-view-display-size 'fit-page
                pdf-view-use-scaling t
                pdf-view-use-imagemagick nil)
  :ensure t
  :config (pdf-tools-install))

(provide 'init-pdf-tools)
;;; init-pdf-tools.el ends here
