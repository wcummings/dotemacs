(require 'rcirc)

(setq rcirc-default-nick "wcummings")
(setq rcirc-default-user-name "wcummings")
(setq rcirc-default-full-name "wcummings")

(load "znc-secret.el")

(setq rcirc-server-alist `((,znc-host
			    :port ,znc-port
			    :nick "wcummings"
			    :password ,(concat "wcummings:" znc-password)
			    :full-name "wcummings")))

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
