(require 'eshell)
(require 'em-smart)
(require 'em-tramp)
;; (setq eshell-where-to-jump 'begin)
;; (setq eshell-review-quick-commands nil)
;; (setq eshell-smart-space-goes-to-end t)
;; (setq eshell-scroll-to-bottom-on-input t)

(setq eshell-aliases-file "~/.emacs.d/eshell.aliases")

(defun eshell/up (&optional n)
  (dotimes (i (or n 1)) (cd "..")))

(defun eshell/~ ()
  (cd "~"))

(defun eshell/l ()
  (eshell/ls))

(defun eshell/ts-to-date (ts)
  (format-time-string "%Y-%m-%d %T UTC" (seconds-to-time ts)))

(defun eshell/ts ()
  (let ((time (date-to-time (current-time-string))))
    (float-time time)))

(defun eshell/clear ()
  "Clear the eshell buffer"
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))

(defun eshell/grt ()
  (interactive)
  (let ((root (locate-dominating-file default-directory ".git")))
    (eshell/cd root)))

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
	    (propertize ":)" 'face '(:foreground "light blue")))
	  " $ "))

(setq eshell-prompt-function 'my-eshell-prompt-function)
(setq eshell-prompt-regex "^[^#$]*[#$] ")

(defun my-eshell-rename-buffer-after-command ()
  (let ((last-path-segment
         (last (remove "" (split-string default-directory "/")))))
    (rename-buffer (format "*eshell[%s]*" last-path-segment) t)))

(add-hook 'eshell-post-command-hook 'my-eshell-rename-buffer-after-command)

(global-set-key (kbd "C-x t") 'spawn-shell)
(global-set-key (kbd "C-x e") 'spawn-eshell)

(defun my-eshell-mode-hook ()
  (setq eshell-path-env (concat (getenv "PATH") eshell-path-env))
  (local-set-key (kbd "C-c e") 'end-of-buffer)
  (local-set-key (kbd "C-l") 'eshell/clear)
  (eshell-smart-initialize))

(add-hook 'eshell-mode-hook 'my-eshell-mode-hook)

;; remember sudo pw for an hour
(setq password-cache t)
(setq password-cache-expiry 3600)

(provide 'my-eshell-mode)
