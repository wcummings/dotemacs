(defun add-to-path (path)
  (nconc (list path) exec-path)
  (add-to-env-var "PATH" path))

(defun add-to-env-var (varname value)
  (let ((existing (getenv varname)))
    (setenv varname (concat value ":" existing))))

(setenv "NODE_NO_READLINE" "1")

(add-to-path "/usr/texbin")
(add-to-path "/usr/local/opt/go/libexec/bin")
(add-to-path "/usr/local/bin")
(add-to-path "/usr/sbin")
(add-to-path "/sbin")
(add-to-path "~/ajoke/bin")

(add-to-env-var "PERL5LIB" (expand-file-name "~/ajoke/etc/perl"))

(provide 'my-env)
