(require 'eshell)
(require 'em-smart)
;; (setq eshell-where-to-jump 'begin)
;; (setq eshell-review-quick-commands nil)
;; (setq eshell-smart-space-goes-to-end t)
;; (setq eshell-scroll-to-bottom-on-input t)

(setq eshell-aliases-file "~/.emacs.d/eshell.aliases")

(defun eshell/up (n)
  (dotimes (i n) (cd "..")))

(defun eshell/~ ()
  (cd "~"))

(defun eshell/l ()
  (eshell/ls))

(defun eshell/ts-to-date (ts)
  (format-time-string "%Y-%m-%d %T UTC" (seconds-to-time ts)))

(defun eshell/ts ()
  (let ((time (date-to-time (current-time-string))))
    (float-time time)))

(defun spawn-eshell ()
  (interactive)
  (eshell t))

;; just in case
(defun spawn-shell ()
  (interactive)
  (ansi-term "/bin/bash"))

(defun my-eshell-prompt-function ()
  (concat (abbreviate-file-name (eshell/pwd)) " "
	  (if (> eshell-last-command-status 0)
	      (propertize ":(" 'face '(:foreground "red"))
	    (propertize ":)" 'face '(:foreground "light green")))
	  " $ "))

(setq eshell-prompt-function 'my-eshell-prompt-function)
;; (setq eshell-prompt-regex "^[^#$]*[#$] ")

(add-to-list 'eshell-visual-commands "ssh")

(global-set-key (kbd "C-x t") 'spawn-shell)
(global-set-key (kbd "C-x e") 'spawn-eshell)

(defun my-eshell-mode-hook ()
  (setq eshell-path-env (concat (getenv "PATH") eshell-path-env))
  (eshell-smart-initialize))

(add-hook 'eshell-mode-hook 'my-eshell-mode-hook)

(provide 'my-eshell-mode)
