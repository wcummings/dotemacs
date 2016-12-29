(load "~/.emacs.d/lib/rcirc.el")

(defcustom my-irc-mode-znc-host nil
  "ZNC host"
  :type '(string)
  :group 'my-customizations)

(defcustom my-irc-mode-znc-port nil
  "ZNC port"
  :type '(string)
  :group 'my-customizations)

(defcustom my-irc-mode-znc-password nil
  "ZNC password"
  :type '(string)
  :group 'my-customizations)

(setq irc-nick "wcummings")
(setq rcirc-default-nick irc-nick)
(setq rcirc-default-user-name irc-nick)
(setq rcirc-default-full-name irc-nick)

(setq rcirc-server-alist `((,my-irc-mode-znc-host
			    :port ,my-irc-mode-znc-port
			    :nick ,irc-nick
			    :password ,(concat irc-nick ":" my-irc-mode-znc-password)
			    :full-name ,irc-nick
			    :encryption tls)))

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

;; rcirc only passes a single param, so we need to get more interactively
(defun-rcirc-command flood (text)
  "friday flood day"
  (interactive)
  (let ((i 0)
	(count
	 (string-to-number (read-string "how rude do u wanna be? "))))
    (while (< i count)
      (rcirc-send-message process target text)
      (setq i (+ 1 i)))))

;; https://www.emacswiki.org/emacs/rcircExampleSettings
(defun-rcirc-command bold (text)
  "Post a bold message to the current target."
  (interactive)
  (rcirc-send-message process target (concat "\002" text "\002")))

(defun-rcirc-command survey (text)
  "Survey people"
  (interactive)
  (let* ((fragments (split-string text ","))
         (query (car fragments))
         (choices (cdr fragments)))
    (rcirc-send-message process target
     (concat (upcase query) ": "
             (string-join
              (mapcar (lambda (item)
                        (concat "[ ] " (upcase item)))
                      choices)
              "  ")))))

(provide 'my-irc-mode)
