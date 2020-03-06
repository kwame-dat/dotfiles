;;; init-swiper.el ---
;;; Commentary:

;; Completion configuration
(setq counsel-git-cmd "git ls-files --full-name --exclude-standard --others --cached --")
(use-package swiper)
(use-package flx)

(provide 'init-swiper)
;;; init-swiper.el ends here
