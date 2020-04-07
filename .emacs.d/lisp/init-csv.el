;;; init-csv.el --- CSV files -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package csv-mode
  :init
  (setq csv-separators '("," ";" "|" " "))
  :ensure t)

(provide 'init-csv)
;;; init-csv.el ends here
