(add-to-list 'load-path "~/.emacs.d/modes")
(add-to-list 'load-path "~/.emacs.d/lib")

(require 'my-packages)

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

;;; appearance
(tool-bar-mode -1)

(setq custom-theme-directory "~/.emacs.d/theme")
(setq custom-safe-themes t)
(when (display-graphic-p)
  (load-theme 'my-solarized))

(setq inhibit-startup-screen t)

(defun setup-path ()
  (setq exec-path (append exec-path '("/sbin" "/usr/sbin" "/usr/local/bin" "/usr/local/opt/go/libexec/bin" "/usr/texbin")))
  (setq exec-path-env-var-value (concat (mapconcat 'identity exec-path ":") ":"))
  (setenv "PATH" (concat exec-path-env-var-value (getenv "PATH"))))

(setup-path)

(setq scroll-step 1)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ; one line at a time
(setq mouse-wheel-progressive-speed nil) ; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't)

(setq chess-ics-server-list '(("freechess.org" 5000 "wcummings")))

(defun indent-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))

(defgroup my-customizations nil
  "Customizations for my .emacs")

(require 'my-ido-mode)
(require 'my-eshell-mode)
(require 'my-tramp-mode)
(require 'my-erlang-mode)
(require 'my-linum-mode)
(require 'my-javascript-mode)
(require 'my-lua-mode)
(require 'my-irc-mode)
(require 'my-java-mode)
(require 'my-org-mode)
(require 'skeletons)

(require 'rotate-windows)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x n") 'rotate-windows)
(global-set-key (kbd "C-x 9") 'toggle-frame-maximized)
(global-set-key (kbd "C-x 5") 'kill-buffer-and-its-windows)
(global-set-key (kbd "C-x g") 'magit-status)

(setq default-directory "~")
