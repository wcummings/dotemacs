(add-to-list 'load-path "~/.emacs.d/modes")

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))

(setq package-list '(magit projmake-mode erlang))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(setq scroll-step 1)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ; one line at a time
(setq mouse-wheel-progressive-speed nil) ; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't)

(setq backup-directory-alist '(("." . "~/.emacs.d/emacs_backups")))
(setq version-control t)
(setq delete-old-versions t)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(setq auto-save-list-file-prefix "~/.emacs.d/autosave/")
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/autosave/" t)))

;(setq linum-format "%4d \u2502 ")
(global-linum-mode t)

(global-set-key (kbd "C-x g") 'magit-status)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(setq custom-theme-directory "~/.emacs.d/theme")
(setq custom-safe-themes t)
(load-theme 'my-solarized)

(set-face-attribute 'default nil :height 100)

(setq inhibit-startup-screen t)

(global-set-key (kbd "C-x t") (lambda()
			    (interactive)
			    (term-line-mode)
			    (ansi-term "/bin/bash")))

(global-set-key (kbd "C-x e") 'eshell)

(setq more-paths '("/sbin" "/usr/sbin" "~/gocode/bin"))
(setq more-paths-string (concat (mapconcat 'identity more-paths ":") ":"))

(defun setup-path ()
  (setq exec-path (append exec-path more-paths))
  (setenv "PATH" (concat more-paths-string (getenv "PATH"))))

(setup-path)

(defun my-eshell-mode-hook ()
  (setq eshell-path-env (concat more-paths-string eshell-path-env))
  (setup-path))

(add-hook 'eshell-mode-hook 'my-eshell-mode-hook)

(require 'my-erlang-mode)
