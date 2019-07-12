;;; ~/.doom.d/init.el -*- lexical-binding: t; -*-

(doom! :completion
       (company          ; the ultimate code completion backend
        +auto            ; as-you-type code completion
        +childframe)
       (ivy +childframe)

       :ui
       doom
       doom-dashboard
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
       format
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
       macos             ; MacOS-specific commands
       magit             ;
       make              ; run make tasks from Emacs
       tmux              ; an API for interacting with tmux
       pass

       :lang
       (cc +lsp)
       (csharp +unity)
       common-lisp
       data
       emacs-lisp
       (java +lsp)
       (javascript +lsp)
       ledger
       markdown
       (org +attach +babel +capture +export +present +protocol)
       (php +php-laravel-mode +php-composer-mode)
       (python +pyenv +lsp)
       rest
       ruby
       sh
       swift
       web

       :email
       (mu4e +gmail)       ; WIP

       :app
       calendar

       :config
       (default +bindings +smartparens))
