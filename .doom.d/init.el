;;; ~/.doom.d/init.el -*- lexical-binding: t; -*-

(doom! :completion
       (company +childframe)
       (ivy +fuzzy +presclient +icons)

       :ui
       doom
       doom-quit
       hl-todo
       modeline
       nav-flash
       ophints
       (popup +all +defaults)
       treemacs
       pretty-code
       unicode
       vc-gutter
       vi-tilde-fringe
       window-select
       workspaces

       :editor
       (evil +everywhere)
       file-templates
       fold
       (format)
       lispy
       multiple-cursors
       rotate-text
       snippets

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

       :lang
       (cc +lsp)
       (java +lsp)
       (javascript +lsp)
       (php +lsp)
       (python +pyenv +lsp)
       (org +attach +babel +capture +export +present +protocol +dragndrop +ipython +pandoc +gnuplot +present)
       (sh +lsp)
       (web +lsp)
       (ruby +lsp)
       ledger
       markdown
       data
       emacs-lisp
       rest
       swift

       :email
       (mu4e +gmail)

       :app
       calendar
       (rss +org)
       twitter

       :config
       (default +bindings +smartparens))
