;;; init-yaml.el --- Support Yaml files -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package yaml-mode)
(add-hook 'yaml-mode-hook 'display-line-numbers-mode)

(provide 'init-yaml)
;;; init-yaml.el ends here
