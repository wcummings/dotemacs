(defun my-env-tuple (export_string)
  (apply #'setenv 
	 (split-string
	  (replace-regexp-in-string "\"" ""
				    (replace-regexp-in-string "export " "" export_string)) "=" t)))

(defun my-cmd-setenv (shell_command)
  (mapcar 'my-env-tuple
	  (split-string (shell-command-to-string shell_command) "\n" t)))

(defun docker-env ()
  (my-cmd-setenv "docker-machine env default"))

(provide 'docker)
