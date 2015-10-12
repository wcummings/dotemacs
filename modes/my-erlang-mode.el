(add-to-list 'load-path (car (file-expand-wildcards "/usr/lib/erlang/lib/tools-*/emacs")))
(setq erlang-root-dir "/usr/lib/erlang")
(add-to-list 'exec-path "/usr/lib/erlang/bin")
(require 'erlang-start)
(require 'edts-start)

(defun my-erlang-mode-hook ()
  (require 'my-whitespace-mode)
  (require 'dumb-indent)
  (local-set-key (kbd "C-x C-r") 'find-makefile-and-run)
  (setq whitespace-line-column 120))

(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)

(provide 'my-erlang-mode)
