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
       (lookup +docsets)
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
       (org +attach +babel +capture +export +present +protocol +dragndrop +ipython +pandoc +gnuplot +present)
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
