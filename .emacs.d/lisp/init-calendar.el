;;; init-calendar.el --- calendar -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq calendar-week-start-day 1)
;; (use-package calfw)
;; (use-package calfw-org)
;; (use-package calfw-cal)
;; (use-package calfw-ical)

;; (defun my-open-calendar ()
;;   (interactive)
;;   (cfw:open-calendar-buffer
;;    :contents-sources
;;    (list
;;     (cfw:org-create-source "Green")  ; orgmode source
;;     (cfw:cal-create-source "Orange") ; diary source
;;     (cfw:ical-create-source "Moon" "~/moon.ics" "Gray")  ; ICS source1
;;     (cfw:ical-create-source "gcal" "https://..../basic.ics" "IndianRed") ; google calendar ICS
;;     ))) 

;; (kd/leader-key-def
;;   "cc"  '(cfw:open-org-calendar :which-key "calendar"))

(provide 'init-calendar)
;;; init-calendar.el ends here
