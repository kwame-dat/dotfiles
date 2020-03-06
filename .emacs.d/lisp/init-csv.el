;;; init-csv.el --- CSV files -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq csv-separators '("," ";" "|" " "))
(use-package csv-mode
  :ensure t)

(provide 'init-csv)
;;; init-csv.el ends here
