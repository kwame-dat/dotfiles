;;; init-snippets.el --- snippets -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(use-package yasnippet
  :defer t
  :hook (prog-mode . yas-minor-mode)
  :config
  (setq yas-snippet-dirs
	'("~/.emacs.d/snippets"))
  (yas-reload-all))

(use-package yasnippet-snippets
  :defer t)

(provide 'init-snippets)
;;; init-snippets.el ends here
