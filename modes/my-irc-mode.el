(require 'rcirc)
(require 'notifications)

(defvar *rcirc-last-message-time* nil)
(defvar *rcirc-last-message-time-file* "~/.emacs.d/.rcirc-last-message-time")
(defvar *rcirc-last-message-time-initial* nil)

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
  "Flood"
  (interactive)
  (let ((i 0)
	(count
	 (string-to-number (read-string "How many lines? "))))
    (while (< i count)
      (rcirc-send-message process target text)
      (incf i))))

;; https://www.emacswiki.org/emacs/rcircExampleSettings
(defun-rcirc-command bold (text)
  "Post a bold message to the current target."
  (interactive)
  (rcirc-send-message process target (concat "\002" text "\002")))

(advice-add 'rcirc-process-server-response-1 :around 'rcirc-process-server-response-advice)
(advice-add 'rcirc-connect :before 'rcirc-pre-connect-advice)
(advice-add 'rcirc-send-string :around 'rcirc-send-string-advice)

(defun rcirc-process-server-response-advice (orig-fun &rest args)
  (let ((text (cadr args)))
    (if (string-match "^\\(@\\([^ ]+\\) \\)?\\(\\(:[^ ]+ \\)?[^ ]+ .+\\)$" text)
        (let ((tags (match-string 2 text))
              (rest (match-string 3 text)))
          (when tags
            (rcirc-handle-message-tags (rcirc-parse-tags tags)))
          (apply orig-fun (list (car args) rest)))
      (apply orig-fun args))))

(defun rcirc-pre-connect-advice (&rest args)
  (when (file-exists-p *rcirc-last-message-time-file*)
    (setq *rcirc-last-message-time-initial*
          (with-temp-buffer (insert-file-contents *rcirc-last-message-time-file*)
                            (read (current-buffer))))))

(defun rcirc-send-string-advice (orig-fun &rest args)
  (let ((process (car args))
        (text (cadr args)))
   (when (string-prefix-p "USER " text)
     (apply orig-fun (list process "CAP REQ znc.in/playback")))
   (apply orig-fun args)))

(add-hook 'rcirc-receive-message-functions 'rcirc-do-notifications-hook)

(defun rcirc-do-notifications-hook (process cmd sender args text)
  (let ((target (car args))
        (message (cadr args))
        (nick (rcirc-nick (rcirc-buffer-process))))
    (when (and (equal cmd "PRIVMSG")
               (not (equal sender nick))
               (or (equal target nick)
                   (string-match (concat "\\b"
                                         (regexp-quote nick)
                                         "\\b")
                                 message)))
      (notifications-notify :title sender :body message))))

(defun rcirc-parse-tags (tags)
  "Parse TAGS message prefix."
  (mapcar (lambda (tag)
            (let ((p (split-string tag "=")))
              `(,(car p) . ,(cadr p))))
          (split-string tags ";")))

(defun rcirc-handle-message-tags (tags)
  (let* ((time (cdr (assoc "time" tags)))
         (timestamp (floor (float-time (date-to-time time)))))
    (setq *rcirc-last-message-time* timestamp)
    (with-temp-file *rcirc-last-message-time-file*
      (insert (with-output-to-string (princ *rcirc-last-message-time*))))))

(defun rcirc-handler-CAP (process sender args text)
  (rcirc-check-auth-status process sender args text)
  (let ((response (cadr args))
	(capab (caddr args)))
    (when (and *rcirc-last-message-time-initial*
	       (string= response "ACK")
	       (string= capab "znc.in/playback"))
      (rcirc-send-privmsg process "*playback" (format "Play * %d" (+ *rcirc-last-message-time-initial* 1))))))

(provide 'my-irc-mode)
