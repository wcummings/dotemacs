(require 'rcirc)

(setq rcirc-default-nick "wcummings")
(setq rcirc-default-user-name "wcummings")
(setq rcirc-default-full-name "wcummings")

(load "znc-secret.el")

(setq rcirc-server-alist '((znc-host
			    :port znc-port
			    :nick "wcummings"
			    :password (concat "wcummings:" znc-password)
			    :full-name "wcummings")))

(provide 'irc)
