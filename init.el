
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/modes")
(add-to-list 'load-path "~/.emacs.d/lib")
(require 'my-env)
(require 'my-packages)
(eval-when-compile (require 'cl))

(setq backup-directory-alist '(("." . "~/.emacs.d/emacs_backups")))
(setq version-control t)
(setq delete-old-versions t)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(setq auto-save-default nil)

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
(setq scroll-step 1)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ; one line at a time
(setq mouse-wheel-progressive-speed nil) ; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't)

(setq chess-ics-server-list '(("freechess.org" 5000 "wcummings")))

;; https://github.com/dunn/company-emoji/blob/master/README.md
(defun set-emoji-font (frame)
  (if (eq system-type 'darwin)
      (set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji") frame 'prepend)
    (set-fontset-font t 'symbol (font-spec :family "Symbola") frame 'prepend)))

(set-emoji-font nil)
(add-hook 'after-make-frame-functions 'set-emoji-font)

(defun indent-buffer ()
  "Indent current buffer."
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil)))

(defgroup my-customizations nil
  "Customizations for my .emacs")

(setq browse-url-browser-function
      '(("reddit" . browse-url-firefox)
        ("." . eww-browse-url)))

(require 'my-auto-complete-mode)
(require 'my-ido-mode)
(require 'my-eshell-mode)
(require 'my-tramp-mode)
(with-eval-after-load "erlang"
  (require 'my-erlang-mode))
(require 'my-linum-mode)
(require 'my-javascript-mode)
(with-eval-after-load "lua-mode"
  (require 'my-lua-mode))
(require 'my-irc-mode)
(require 'my-java-mode)
(require 'my-org-mode)
(require 'my-elisp-mode)
(require 'restclient)
(require 'epoch-view)
(require 'rotate-windows)
(require 'multi-scratch)
(require 'my-erc-mode)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-x n") 'rotate-windows)
(global-set-key (kbd "C-x 9") 'toggle-frame-maximized)
(global-set-key (kbd "C-x 5") 'kill-buffer-and-its-windows)
(global-set-key (kbd "C-x g") 'magit-status)

(add-to-list 'auto-mode-alist '("\\.http\\'" . restclient-mode))

(global-flycheck-mode)

(require 'virtualenvwrapper)
(venv-initialize-eshell)
(setq venv-location "~/.virtualenv/")

(setq gnus-select-method '(nntp "news.gwene.org"))

(setq gnus-secondary-select-methods
      '((nnimap "imap.fastmail.com")))

(setq message-send-mail-function 'smtpmail-send-it)

(setq smtpmail-smtp-server "smtp.fastmail.com")
(setq user-mail-address "will@wpc.io")
(setq smtpmail-stream-type 'ssl)
(setq smtpmail-smtp-service 465)

(define-key lisp-interaction-mode-map (kbd "C-i") 'eval-print-last-sexp)

(require 'go-projectile)
(projectile-global-mode)

(cd "~")
(eshell) ;)
