;;; init-music.el --- music -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:
(setq mpc-host "localhost:6601")
(use-package emms
  :defer t
  :config
  (require 'emms-setup)
  (require 'emms-player-mpd)
  (emms-all) ; don't change this to values you see on stackoverflow questions if you expect emms to work
  (setq emms-seek-seconds 5)
  (setq emms-player-list '(emms-player-mpd))
  (setq emms-info-functions '(emms-info-mpd))
  (setq emms-player-mpd-server-name "localhost")
  (setq emms-player-mpd-server-port "6601")
  :bind
  ("s-m p" . emms)
  ("s-m b" . emms-smart-browse)
  ("s-m r" . emms-player-mpd-update-all-reset-cache)
  ("<XF86AudioPrev>" . emms-previous)
  ("<XF86AudioNext>" . emms-next)
  ("<XF86AudioPlay>" . emms-pause)
  ("<XF86AudioStop>" . emms-stop))


(defun mpd/start-music-daemon ()
  "Start MPD, connects to it and syncs the metadata cache."
  (interactive)
  (shell-command "mpd")
  (mpd/update-database)
  (emms-player-mpd-connect)
  (emms-cache-set-from-mpd-all)
  (message "MPD Started!"))

(defun mpd/kill-music-daemon ()
  "Stops playback and kill the music daemon."
  (interactive)
  (emms-stop)
  (call-process "killall" nil nil nil "mpd")
  (message "MPD Killed!"))

(defun mpd/update-database ()
  "Updates the MPD database synchronously."
  (interactive)
  (call-process "mpc" nil nil nil "update")
  (message "MPD Database Updated!"))

(kd/leader-key-def
  "amm" 'emms
  "amp" 'emms
  "amb" 'emms-smart-browse
  "amr" 'emms-player-mpd-update-all-reset-cache
  "ams" 'mpd/start-music-daemon
  "amu" 'mpd/update-database
  "amk" 'mpd/kill-music-daemon
  )

(provide 'init-music)
;;; init-music.el ends here
