(require 'rcirc)

(setq irc-nick "wcummings")
(setq rcirc-default-nick irc-nick)
(setq rcirc-default-user-name irc-nick)
(setq rcirc-default-full-name irc-nick)

(load "znc-secret.el")

(setq rcirc-server-alist `((,znc-host
			    :port ,znc-port
			    :nick ,irc-nick
			    :password ,(concat irc-nick ":" znc-password)
			    :full-name ,irc-nick)))

;; http://superuser.com/questions/249563/using-rcirc-with-a-irc-bouncer-like-znc
(defun rcirc-detach-buffer ()
  (interactive)
  (let ((buffer (current-buffer)))
    (when (and (rcirc-buffer-process)
           (eq (process-status (rcirc-buffer-process)) 'open))
      (with-rcirc-server-buffer
    (setq rcirc-buffer-alist
          (rassq-delete-all buffer rcirc-buffer-alist)))
      (rcirc-update-short-buffer-names)
      (if (rcirc-channel-p rcirc-target)
      (rcirc-send-string (rcirc-buffer-process)
                 (concat "DETACH " rcirc-target))))
    (setq rcirc-target nil)
    (kill-buffer buffer)))

;; bind to C-x k so i dont accidentally part channels
(define-key rcirc-mode-map (kbd "C-x k") 'rcirc-detach-buffer)

(provide 'irc)
