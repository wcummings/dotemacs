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

                                        ;(defun slack-complete-command  )

(advice-add 'pcomplete-erc-nicks :around 'pcomplete-slack-nicks-advice)

(defun pcomplete-slack-nicks-advice (origin-fun &rest args)
  (let ((nicks (apply origin-fun args)))
    (append nicks (mapcar (lambda (v) (concat "@" v)) nicks))))

(provide 'my-erc-mode)
