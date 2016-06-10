(require 'eshell)
(require 'em-smart)
;; (setq eshell-where-to-jump 'begin)
;; (setq eshell-review-quick-commands nil)
;; (setq eshell-smart-space-goes-to-end t)
;; (setq eshell-scroll-to-bottom-on-input t)

(setq eshell-aliases-file "~/.emacs.d/eshell.aliases")

(defun spawn-eshell ()
  (interactive)
  (eshell t))

;; just in case
(defun spawn-shell ()
  (interactive)
  (ansi-term "/bin/bash"))

(global-set-key (kbd "C-x t") 'spawn-shell)
(global-set-key (kbd "C-x e") 'spawn-eshell)

(defun my-eshell-mode-hook ()
  (require 'eshell-functions)
  (require 'eshell-env)
  (setup-path)
  (setq eshell-path-env (concat exec-path-env-var-value eshell-path-env))
  (setenv "PATH" (concat exec-path-env-var-value (getenv "PATH")))
  (eshell-smart-initialize))

(add-hook 'eshell-mode-hook 'my-eshell-mode-hook)

(provide 'my-eshell-mode)
