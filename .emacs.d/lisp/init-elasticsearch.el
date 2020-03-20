;;; init-elasticsearch.el --- Playing with Elasticsearch -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package es-mode)
(autoload 'es-mode "es-mode.el"
  "Major mode for editing Elasticsearch queries" t)
(add-to-list 'auto-mode-alist '("\\.es$" . es-mode))

(provide 'init-elasticsearch)
;;; init-elasticsearch.el ends here
