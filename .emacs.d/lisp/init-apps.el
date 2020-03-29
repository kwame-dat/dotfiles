;;; init-apps.el --- Install useful apps
;;; Commentary:
;;: Code:
;; Write
(use-package synosaurus
  :config
  (global-set-key (kbd "s-|") 'powerthesaurus-lookup-word-dwim))


(provide 'init-apps)
;;; init-apps.el ends here
