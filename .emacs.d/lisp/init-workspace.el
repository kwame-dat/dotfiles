;;; init-workspace.el -- Workspace installation and configuration
;;; Commentary:
;;; Code:

(use-package perspective
  :demand t
  :config
  (progn
    (persp-mode)
    (defun persp-get-perspectives-for-buffer (buffer)
      "Get the names of all of the perspectives of which `buffer` is a member."
      (cl-loop for perspective being the hash-value of perspectives-hash
               if (member buffer (persp-buffers perspective))
               collect (persp-name perspective)))

    (defun persp-pick-perspective-by-buffer (buffer)
      "Select a buffer and go to the perspective to which that buffer
        belongs. If the buffer belongs to more than one perspective
        completion will be used to pick the perspective to switch to.
        Switch the focus to the window in which said buffer is displayed
        if such a window exists. Otherwise display the buffer in whatever
        window is active in the perspective."
      (interactive (list (funcall persp-interactive-completion-function
                                  "Buffer: " (mapcar 'buffer-name (buffer-list)))))
      (let* ((perspectives (persp-get-perspectives-for-buffer (get-buffer buffer)))
             (perspective (if (> (length perspectives) 1)
                              (funcall persp-interactive-completion-function
                                       (format "Select the perspective in which you would like to visit %s."
                                               buffer)
                                       perspectives)
                            (car perspectives))))
        (if (string= (persp-name persp-curr) perspective)
            ;; This allows the opening of a single buffer in more than one window
            ;; in a single perspective.
            (switch-to-buffer buffer)
          (progn
            (persp-switch perspective)
            (if (get-buffer-window buffer)
                (set-frame-selected-window nil (get-buffer-window buffer))
              (switch-to-buffer buffer))))))

    (defun persp-mode-switch-buffers (arg)
      (interactive "P")
      (if arg (call-interactively 'ido-switch-buffer)
        (call-interactively 'persp-pick-perspective-by-buffer)))))

(use-package persp-projectile)

(provide 'init-workspace)
;;; init-workspace.el ends here
