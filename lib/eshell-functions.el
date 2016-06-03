(defun eshell/up (n)
  (dotimes (i n) (cd "..")))

(defun eshell/~ ()
  (cd "~"))

(defun eshell/l ()
  (eshell/ls))

(defun eshell/ts-to-date (ts)
  (format-time-string "%Y-%m-%d %T UTC" (seconds-to-time ts)))

(defun eshell/ts ()
  (let ((time (date-to-time (current-time-string))))
    (float-time time)))

(provide 'eshell-functions)
