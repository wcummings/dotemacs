;;; FIXME: find less shitty way to do this
(setq repl-buffer "*Erlang release*")

(require 'projmake-mode)
(add-to-list 'load-path (car (file-expand-wildcards "/usr/lib64/erlang/lib/tools-*/emacs")))
(setq erlang-root-dir "/usr/lib64/erlang")
(add-to-list 'exec-path "/usr/lib64/erlang/bin")
(require 'erlang-start)

(defun make-run ()
  (if (get-buffer repl-buffer)
      (kill-buffer repl-buffer)
    (message ""))
  (generate-new-buffer repl-buffer)
  (async-shell-command "make run" repl-buffer))

(defun find-makefile-and-run ()
  (interactive)
  (if (file-exists-p "Makefile")
      (make-run)
    (if (file-exists-p "../Makefile")
	(progn
	  (cd "..")
	  (make-run)))))

(defun my-erlang-mode-hook ()
  (require 'my-whitespace-mode)
  (require 'dumb-indent)
  (local-set-key (kbd "C-x C-r") 'find-makefile-and-run)
  (setq whitespace-line-column 120)
  (if (buffer-file-name)
      (progn
	(projmake-mode)
	(projmake-search-load-project))
    (message "")))

(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)

(provide 'my-erlang-mode)
