(defun my-gnus-group-list-subscribed-groups ()
  "List all subscribed groups with or without un-read messages"
  (interactive)
  (gnus-group-list-all-groups 5))

(define-key gnus-group-mode-map
  ;; list all the subscribed groups even they contain zero un-read messages
  (kbd "o") 'my-gnus-group-list-subscribed-groups)

(setq gnus-select-method '(nntp "news.gwene.org"))

(setq gnus-secondary-select-methods
      '((nnimap "imap.fastmail.com")))

(setq message-send-mail-function 'smtpmail-send-it)

(setq smtpmail-smtp-server "smtp.fastmail.com")
(setq user-mail-address "will@wpc.io")
(setq smtpmail-stream-type 'ssl)
(setq smtpmail-smtp-service 465)

(provide 'my-gnus-mode)
