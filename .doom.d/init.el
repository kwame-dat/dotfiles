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
       indent-guides
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
       ;; term
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
       ;;upload            ; map local to remote projects via ssh/ftp
       ;;wakatime

       :lang
       ;;assembly
       (cc +lsp)
       ;;crystal
       ;;clojure
       ;; (csharp +unity)
       ;;common-lisp
       data
       ;;erlang
       ;;elixir
       ;;elm
       emacs-lisp
       ;;ess
       ;;go
       ;; (haskell +intero)
       ;;hy
       ;;(java +lsp)
       (javascript +lsp)
       ;;julia
       ;; latex
       ledger
       ;; lua
       markdown
       ;;nim
       ;;nix
       ;;ocaml
       (org +attach +babel +capture +export +present +protocol)
       ;;perl
       (php +php-laravel-mode +php-composer-mode)
       ;;plantuml
       ;;purescript
       ;; (python +pyenv +lsp)
       rest
       ;;ruby
       ;; (rust +lsp)
       ;;scala
       sh
       ;;swift
       web

       :email
       (mu4e +gmail)       ; WIP

       :app
       calendar

       :config
       (default +bindings +smartparens))
