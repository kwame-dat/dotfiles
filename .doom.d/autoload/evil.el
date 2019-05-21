;;; /mnt/projects/conf/doom-emacs-private/autoload/evil.el -*- lexical-binding: t; -*-
;;;###if (featurep! :editor evil)

;;;###autoload (autoload '+tonyampomah:multi-next-line "autoload/evil" nil nil)
(evil-define-motion +tonyampomah:multi-next-line (count)
  "Move down 6 lines."
  :type line
  (let ((line-move-visual (or visual-line-mode (derived-mode-p 'text-mode 'magit-mode))))
    (evil-line-move (* 6 (or count 1)))))

;;;###autoload (autoload '+tonyampomah:multi-previous-line "autoload/evil" nil nil)
(evil-define-motion +tonyampomah:multi-previous-line (count)
  "Move up 6 lines."
  :type line
  (let ((line-move-visual (or visual-line-mode (derived-mode-p 'text-mode 'magit-mode))))
    (evil-line-move (- (* 6 (or count 1))))))
