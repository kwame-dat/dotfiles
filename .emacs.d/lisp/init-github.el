;;; init-github.el --- Github integration -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(require 'init-git)

(use-package yagist)
(use-package bug-reference-github)
(use-package github-clone)
(use-package forge)
(use-package github-review)
(push '("github.thetrainline.com" "github.thetrainline.com/api/v3"
        "github.thetrainline.com" forge-github-repository)
        forge-alist)

(provide 'init-github)
;;; init-github.el ends here
