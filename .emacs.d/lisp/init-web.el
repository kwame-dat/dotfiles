;;; init-web.el --- Web Mode -*- lexical-binding: t -*-
;;; Commentary: For HTML, Templates like blade etc
;;; Code:
(use-package web-mode
  :defer t
  :mode "\\(?:\\(?:\\.\\(?:html\\|twig\\)\\)\\)\\'"
  :config
  (setq web-mode-attr-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-indent-style 2
        web-mode-markup-indent-offset 2
        web-mode-sql-indent-offset 2)

  (setq web-mode-ac-sources-alist
        '(("php" . (ac-source-php-extras
                    ac-source-yasnippet
                    ac-source-gtags
                    ac-source-abbrev
                    ac-source-dictionary
                    ac-source-words-in-same-mode-buffers))
          ("css" . (ac-source-css-property
                    ac-source-abbrev
                    ac-source-dictionary
                    ac-source-words-in-same-mode-buffers))))

  (add-hook 'web-mode-hook
            (lambda ()
              (setq web-mode-style-padding 2)
              (yas-minor-mode t)
              (emmet-mode)
              (flycheck-add-mode 'html-tidy 'web-mode)
              (flycheck-mode)))

  (add-hook 'web-mode-before-auto-complete-hooks
            '(lambda ()
               (let ((web-mode-cur-language (web-mode-language-at-pos)))
                 (if (string= web-mode-cur-language "php")
                     (yas-activate-extra-mode 'php-mode)
                   (yas-deactivate-extra-mode 'php-mode))
                 (if (string= web-mode-cur-language "css")
                     (setq emmet-use-css-transform t)
                   (setq emmet-use-css-transform nil))))))

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))


(use-package web-beautify
  :defer t)

(provide 'init-web)
;;; init-web.el ends here
