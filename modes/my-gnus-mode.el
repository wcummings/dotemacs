(require 'gnus)

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

;; auto-complete emacs address using bbdb UI
(add-hook 'message-mode-hook
          '(lambda ()
             (flyspell-mode t)
             (local-set-key (kdb "TAB") 'bbdb-complete-name)))

(defun slurp (file)
  "Read FILE into a string."
  (with-temp-buffer
    (insert-file-contents file)
    (buffer-substring-no-properties
     (point-min)
     (point-max))))

(defun gnus-import-feed-list (path)
  "Import list of NNTP feeds from file at PATH."
  (interactive "F")
  (let ((feeds (split-string (slurp path) "\n" t)))
    (cl-loop for feed in feeds
             do (gnus-subscribe-group feed))))

(provide 'my-gnus-mode)
