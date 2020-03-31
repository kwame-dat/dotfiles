;;; init-evil.el -- My evil mode configuration.
;;; Commentary:
;;; Code:
(defun itechytony/config-evil ()
  "Configure evil mode."
  (evil-add-hjkl-bindings occur-mode-map 'emacs
    (kbd "/")       'evil-search-forward
    (kbd "n")       'evil-search-next
    (kbd "N")       'evil-search-previous
    (kbd "C-d")     'evil-scroll-down
    (kbd "C-u")     'evil-scroll-up
    (kbd "C-w C-w") 'other-window)

  (define-key evil-visual-state-map [escape] 'keyboard-quit)
  (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit))

(defmacro define-evil-or-global-key (key def &optional state)
  "Define a key KEY with DEF in an Evil map, or in the global map.

	   If the Evil map for STATE is defined (or `normal' if STATE is not
	   provided) the key will be defined in that map.  Failing that, it will
	   be defined globally.

	   Note that STATE should be provided as an unquoted symbol.

	   This macro provides a way to override Evil mappings in the appropriate
	   Evil map in a manner that is compatible with environments where Evil
	   is not used."
  (let* ((evil-map-name (if state
			    (concat "evil-" (symbol-name state) "-state-map")
			  "evil-normal-state-map"))
	 (map (if (boundp (intern evil-map-name))
		  (intern evil-map-name)
		global-map)))
    `(define-key ,map ,key ,def)))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-want-abbrev-expand-on-insert-exit nil)
  :ensure t
  :commands (evil-mode evil-define-key)

  :config
  (add-hook 'evil-mode-hook 'itechytony/config-evil)
  (evil-mode 1)
  (itechytony/apply-evil-other-package-configs))

(use-package evil-leader
  :ensure t
  :config
  (itechytony/config-evil-leader)
  (global-evil-leader-mode))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode))

(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode))

(use-package evil-indent-textobject :ensure t)


(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(provide 'init-evil)
;;; init-evil.el ends here
