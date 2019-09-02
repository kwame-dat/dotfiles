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
       (format +onsave)
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
       (php +lsp +php-laravel-mode +php-composer-mode)
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

       :config
       (default +bindings +smartparens))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("cb477d192ee6456dc2eb5ca5a0b7bd16bdb26514be8f8512b937291317c7b166" "f5568ed375abea716d1bdfae0316d1d179f69972eaccd1f331b3e9863d7e174a" "06e4b3fdcbadc29ff95a7146dee846cd027cfefca871b2e9142b54ad5de4832f" "ab9456aaeab81ba46a815c00930345ada223e1e7c7ab839659b382b52437b9ea" "e3c87e869f94af65d358aa279945a3daf46f8185f1a5756ca1c90759024593dd" "155a5de9192c2f6d53efcc9c554892a0d87d87f99ad8cc14b330f4f4be204445" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
