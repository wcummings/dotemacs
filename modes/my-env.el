(defun add-to-path (path)
  (nconc (list (expand-file-name path)) exec-path)
  (add-to-env-var "PATH" path))

(defun add-to-env-var (varname value)
  (let ((existing (getenv varname)))
    (setenv varname (concat (expand-file-name value) ":" existing))))

(setenv "NODE_NO_READLINE" "1")

(add-to-path "/usr/texbin")
(add-to-path "/usr/local/opt/go/libexec/bin")
(add-to-path "/usr/local/bin")
(add-to-path "/usr/sbin")
(add-to-path "/sbin")
(add-to-path "/usr/local/opt/coreutils/libexec/gnubin")
(add-to-path "~/.emacs.d/scripts")

(provide 'my-env)
