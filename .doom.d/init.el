;;; ~/.doom.d/init.el -*- lexical-binding: t; -*-

(doom! :completion
       (company +childframe)
       (ivy +fuzzy +presclient +icons)

       :ui
       hl-todo
       doom
       modeline
       (popup +all +defaults)
       treemacs
       vc-gutter
       vi-tilde-fringe
       window-select
       workspaces
       nav-flash
       ophints

       :editor
       (evil +everywhere)
       file-templates
       fold
       format
       multiple-cursors
       rotate-text
       snippets
       word-wrap

       :emacs
       (dired +icons)
       electric
       vc

       :term
       eshell
       term
       vterm

       :tools
       ansible
       debugger
       docker
       editorconfig
       eval
       (flycheck +childframe)
       flyspell
       gist
       (lookup +docsets +devdocs)
       lsp
       macos
       magit
       make
       tmux
       pass
       pdf

       :lang
       (javascript +lsp)
       (php +lsp +php-laravel-mode +php-composer-mode)
       (python +pyenv +lsp)
       (org +attach
            +babel
            +capture
            +export
            +present
            +protocol
            +dragndrop
            +ipython
            +pandoc
            +gnuplot
            +present)
       (sh +lsp)
       (web +lsp)
       ledger
       markdown
       data
       emacs-lisp
       rest

       :email
       (mu4e +gmail)

       :app
       calendar

       :config
       (default +bindings +smartparens))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("423435c7b0e6c0942f16519fa9e17793da940184a50201a4d932eafe4c94c92d" "32fd809c28baa5813b6ca639e736946579159098d7768af6c68d78ffa32063f4" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
