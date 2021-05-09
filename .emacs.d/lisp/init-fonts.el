;;; init-fonts.el --- Fonts -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

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
