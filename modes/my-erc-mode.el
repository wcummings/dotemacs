(require 'erc)
(require 'tls)
(require 'znc)

;; (setq erc-rename-buffers t)
(setq erc-interpret-mirc-color t)

;; (defcustom my-erc-mode-servers nil
;;   "ERC server config."
;;   :type 'sexp
;;   :group 'my-customizations)

;; (defcustom my-erc-mode-znc-host nil
;;   "ZNC host."
;;   :type '(string)
;;   :group 'my-customizations)

;; (defcustom my-erc-mode-znc-port nil
;;   "ZNC port."
;;   :type '(string)
;;   :group 'my-customizations)

;; (defcustom my-erc-mode-znc-password nil
;;   "ZNC password."
;;   :type '(string)
;;   :group 'my-customizations)

;; (defcustom my-erc-mode-znc-username nil
;;   "ZNC username."
;;   :type '(string)
;;   :group 'my-customizations)

;; (defun znc ()
;;   "Connect to a list of networks via ZNC."
;;   (interactive)
;;   (dolist (server my-erc-mode-servers)
;;     (let* ((nick (plist-get server :nick))
;;            (network (plist-get server :network))
;;            (password (concat my-erc-mode-znc-username "/"
;;                              network ":" my-erc-mode-znc-password)))
;;       (erc-tls :server my-erc-mode-znc-host
;;            :port my-erc-mode-znc-port
;;            :nick nick
;;            :full-name nick
;;            :password password))))

(advice-add 'pcomplete-erc-nicks :around 'pcomplete-slack-nicks-advice)

(defun pcomplete-slack-nicks-advice (origin-fun &rest args)
  (let ((nicks (apply origin-fun args)))
    (append nicks (mapcar (lambda (v) (concat "@" v)) nicks))))

(defvar my-erc-version "mIRC Version 7.0")

(defun my-erc-ctcp-query-VERSION (_proc nick _login _host _to _msg)
  "Send CTCP response to NICK."
  (erc-send-ctcp-notice nick (concat "VERSION " my-erc-version)) nil)

(setf erc-disable-ctcp-replies t)
(add-hook 'erc-ctcp-query-VERSION-hook 'my-erc-ctcp-query-VERSION)

(defun erc-cmd-SLAP (nick)
  "mIRC is the greatest IRC client."
  (erc-send-action (erc-default-target) (format "slaps %s around a bit with a large trout" nick)))

(provide 'my-erc-mode)
