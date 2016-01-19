(add-to-list 'load-path "~/.emacs.d/modes")
(add-to-list 'load-path "~/.emacs.d/lib")

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))

(setq package-list '(magit
		     erlang
		     skeletor
		     js2-mode
		     edts
		     tern
		     company
		     company-tern
		     php-mode
		     sx
		     go-mode
		     lua-mode
		     misc-cmds
		     chess
		     gist))
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

(global-set-key (kbd "C-x g") 'magit-status)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(tool-bar-mode -1)

(setq custom-theme-directory "~/.emacs.d/theme")
(setq custom-safe-themes t)
(when (display-graphic-p)
  (load-theme 'my-solarized))

;(set-face-attribute 'default nil :height 100)

(setq inhibit-startup-screen t)

(defun spawn-shell ()
  (interactive)
  (term-line-mode)
  (ansi-term "/bin/bash"))

(require 'eshell)
(setq eshell-scroll-to-bottom-on-input t)

(defun spawn-eshell ()
  (interactive)
  (eshell t))

(global-set-key (kbd "C-x t") 'spawn-shell)
(global-set-key (kbd "C-x e") 'spawn-eshell)

(setq go-path "/usr/local/opt/go/libexec/bin")
(setq more-paths `("/sbin" "/usr/sbin" "/usr/local/bin" ,go-path))
(setq more-paths-string (concat (mapconcat 'identity more-paths ":") ":"))

(defun setup-path ()
  (setq exec-path (append exec-path more-paths))
  (setenv "PATH" (concat more-paths-string (getenv "PATH"))))

(setup-path)

(defun my-eshell-mode-hook ()
  (require 'eshell-functions)
  (require 'eshell-env)
  (setq eshell-path-env (concat more-paths-string eshell-path-env))
  (setup-path))

(add-hook 'eshell-mode-hook 'my-eshell-mode-hook)

(defun sx-search-stackoverflow (query)
  ;; s prefix reads a string from the minibuffer
  (interactive "sQuery: ")
  (sx-search 'stackoverflow query))

(defun sx-search-emacs (query)
  ;; s prefix reads a string from the minibuffer
  (interactive "sQuery: ")
  (sx-search 'emacs query))

(global-set-key (kbd "C-x 8") 'sx-search-emacs)
(global-set-key (kbd "C-x 9") 'sx-search-stackoverflow)

(global-set-key (kbd "C-x 5") 'kill-buffer-and-its-windows)

(require 'rotate-windows)
(global-set-key (kbd "C-x n") 'rotate-windows)

(setq chess-ics-server-list '(("freechess.org" 5000 "wcummings")))

(setq tramp-default-method "ssh")

(require 'my-erlang-mode)
(require 'skeletons)
(require 'linum-mode)
(require 'javascript)
(require 'go)
(require 'lua)

