;;; init-fonts.el --- Fonts -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


(setq-default line-spacing 0.5)
(setq kd/default-font "Victor Mono")
(setq kd/default-font-size 12)
(setq kd/current-font-size kd/default-font-size)

(setq kd/font-change-increment 1.1)

(defun kd/font-code ()
  (concat kd/default-font "-" (number-to-string kd/current-font-size)))

(defun kd/set-font-size ()
  "Set the font to `kd/default-font' at `kd/current-font-size'.
  Set that for the current frame, and also make it the default for
  other, future frames."
  (let ((font-code (kd/font-code)))
    (if (assoc 'font default-frame-alist)
        (setcdr (assoc 'font default-frame-alist) font-code)
      (add-to-list 'default-frame-alist (cons 'font font-code)))
    (set-frame-font font-code)))

(defun kd/reset-font-size ()
  "Change font size back to `kd/default-font-size'."
  (interactive)
  (setq kd/current-font-size kd/default-font-size)
  (kd/set-font-size))

(defun kd/increase-font-size ()
  "Increase current font size by a factor of `kd/font-change-increment'."
  (interactive)
  (setq kd/current-font-size
        (ceiling (* kd/current-font-size kd/font-change-increment)))
  (kd/set-font-size))

(defun kd/decrease-font-size ()
  "Decrease current font size by a factor of `kd/font-change-increment', down to a minimum size of 1."
  (interactive)
  (setq kd/current-font-size
        (max 1
             (floor (/ kd/current-font-size kd/font-change-increment))))
  (kd/set-font-size))

(define-key global-map (kbd "C-0") 'kd/reset-font-size)
(define-key global-map (kbd "C-+") 'kd/increase-font-size)
(define-key global-map (kbd "C-=") 'kd/increase-font-size)
(define-key global-map (kbd "C-_") 'kd/decrease-font-size)
(define-key global-map (kbd "C--") 'kd/decrease-font-size)

(kd/reset-font-size)


;; Set the font face based on platform
(use-package mixed-pitch
  :defer t
  :hook
  ;; If you want it in all text modes:
  (org-mode . mixed-pitch-mode))

;; (use-package ligature
;;   :config
;;   ;; Enable the "www" ligature in every possible major mode
;;   (ligature-set-ligatures 't '("www"))
;;   ;; Enable traditional ligature support in eww-mode, if the
;;   ;; `variable-pitch' face supports it
;;   (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
;;   ;; Enable all Cascadia Code ligatures in programming modes
;;   (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
;;                                        ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
;;                                        "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
;;                                        "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
;;                                        "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
;;                                        "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
;;                                        "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
;;                                        "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
;;                                        ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
;;                                        "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
;;                                        "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
;;                                        ;; "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
;;                                        ;; "\\" "://"
;;                                        ))
;;   ;; Enables ligature checks globally in all buffers. You can also do it
;;   ;; per mode with `ligature-mode'.
;;   (global-ligature-mode t))

(use-package emojify
  :defer t
  :hook (erc-mode . emojify-mode)
  :commands emojify-mode)

(use-package unicode-fonts
  :defer t)

(provide 'init-fonts)
;;; init-fonts.el ends here
