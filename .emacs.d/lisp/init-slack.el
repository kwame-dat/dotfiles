;;; init-slack.el --- Lets chat in Emacs with Slack -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq slack-buffer-emojify t)
(setq slack-prefer-current-team t)
(use-package slack
  :commands (slack-start))

(provide 'init-slack)
;;; init-slack.el ends here
