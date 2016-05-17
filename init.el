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
		     tern-auto-complete
		     php-mode
		     go-mode
		     lua-mode
		     misc-cmds
		     chess
		     restclient
		     racket-mode
		     smartparens
		     flycheck
		     haskell-mode))
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

(let ((host-settings-file (format "host_settings/%s.el" (downcase system-name))))
  (when (file-exists-p host-settings-file)
    (load host-settings-file)))

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

(setq go-path (expand-file-name "~/go/"))
(setq more-paths `("/sbin" "/usr/sbin" "/usr/local/bin" "/usr/local/opt/go/libexec/bin" ,(concat go-path "bin") "/usr/texbin"))
(setq more-paths-string (concat (mapconcat 'identity more-paths ":") ":"))

(defun setup-path ()
  (setq exec-path (append exec-path more-paths))
  (setenv "GOPATH" go-path)
  (setenv "PATH" (concat more-paths-string (getenv "PATH"))))

(setup-path)

(defun my-eshell-mode-hook ()
  (require 'eshell-functions)
  (require 'eshell-env)
  (setq eshell-path-env (concat more-paths-string eshell-path-env))
  (setup-path))

(add-hook 'eshell-mode-hook 'my-eshell-mode-hook)

(global-set-key (kbd "C-x 5") 'kill-buffer-and-its-windows)

(require 'rotate-windows)
(global-set-key (kbd "C-x n") 'rotate-windows)

(global-set-key (kbd "C-x 9") 'toggle-frame-maximized)

(setq chess-ics-server-list '(("freechess.org" 5000 "wcummings")))

;; lets us sudo on the remote host
(require 'tramp)
(add-to-list 'tramp-default-proxies-alist
	     '(nil "\\`root\\'" "/ssh:%h:"))
(add-to-list 'tramp-default-proxies-alist
	     '((regexp-quote (system-name)) nil nil))
(setq tramp-default-method "ssh")

(defun indent-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always)
(ido-mode 1)

;; jdee is shitty
;;(setq max-lisp-eval-depth 3000)
;;(setq max-specpdl-size 20000)

(require 'my-erlang-mode)
(require 'skeletons)
(require 'linum-mode)
(require 'javascript)
(require 'go)
(require 'lua)
(require 'racket)
(require 'irc)
(require 'java)
(require 'my-org)

(cd "~")
