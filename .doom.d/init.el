;;; ~/.doom.d/init.el -*- lexical-binding: t; -*-

(doom! :completion
       (company          ; the ultimate code completion backend
        +auto            ; as-you-type code completion
        +childframe)
       (ivy)

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

       :config
       (default +bindings +smartparens))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-safe-themes
   (quote
    ("a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379" "fd944f09d4d0c4d4a3c82bd7b3360f17e3ada8adf29f28199d09308ba01cc092" "75d3dde259ce79660bac8e9e237b55674b910b470f313cdf4b019230d01a982a" "43c808b039893c885bdeec885b4f7572141bd9392da7f0bd8d8346e02b2ec8da" "955426466aa729d7d32483d3b2408cf474a1332550ad364848d1dfe9eecc8a16" "1cfc3c062790a8d6f9ce677c50cf671609f45c32695778873b4a7619f1e749b5" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
