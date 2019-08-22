;;; ~/.doom.d/init.el -*- lexical-binding: t; -*-

(doom! :completion
       (company          ; the ultimate code completion backend
        +auto            ; as-you-type code completion
        +childframe)
       (ivy)

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
       common-lisp
       data
       emacs-lisp
       (java +lsp)
       (javascript +lsp)
       ledger
       markdown
       (org +attach +babel +capture +export +present +protocol +dragndrop +ipython +pandoc +gnuplot +present)
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
       irc              ; how neckbeards socialize
       (rss +org)        ; emacs as an RSS reader
       twitter           ; twitter client https://twitter.com/vnought
       (write            ; emacs as a word processor (latex + org + markdown)
       +wordnut         ; wordnet (wn) search
       +langtool)       ; a proofreader (grammar/style check) for Emacs

       :collab
       floobits          ; peer programming for a price
       impatient-mode    ; show off code over HTTP

       :config
       (default +bindings +smartparens))
