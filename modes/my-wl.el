(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)
(setq wl-icon-directory "~/wl/etc")

(autoload 'wl-user-agent-compose "wl-draft" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))

(setq elmo-imap4-default-server "imap.fastmail.com"
      elmo-imap4-default-user "will@fastmail.us"
      elmo-imap4-default-authenticate-type 'clear
      elmo-imap4-default-port '993
      elmo-imap4-default-stream-type 'ssl)

(setq wl-smtp-connection-type 'ssl
      wl-smtp-posting-port 465
      wl-smtp-authenticate-type "plain"
      wl-smtp-posting-user "will@fastmail.us"
      wl-smtp-posting-server "smtp.fastmail.com"
      wl-local-domain "localhost"
      wl-message-id-domain "smtp.fastmail.com")

(setq wl-from "William Cummings <will@fastmail.us>")

(setq wl-default-folder "%inbox")

;; ignore  all fields
(setq wl-message-ignored-field-list '("^.*:"))

;; ..but these five
(setq wl-message-visible-field-list
      '("^To:"
        "^Cc:"
        "^From:"
        "^Subject:"
        "^Date:"))

(provide 'my-wl)
