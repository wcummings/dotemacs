(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))

(setq package-list '(magit
		     erlang
		     js2-mode
		     edts
		     tern
		     tern-auto-complete
		     php-mode
		     go-mode
		     lua-mode
		     ;; misc-cmds
		     chess
		     rainbow-delimiters
                     ;; flycheck
                     restclient
                     paredit
                     virtualenvwrapper
                     projectile
                     org-ehtml
                     znc
                     go-projectile
                     ace-window
                     sx
                     pyenv-mode))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(provide 'my-packages)
