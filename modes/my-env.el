(defun add-to-path (path)
  (add-to-list 'exec-path (expand-file-name path) t)
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
(add-to-path "~/.cargo/bin")
(add-to-path "~/.rakudobrew/bin")

(provide 'my-env)
