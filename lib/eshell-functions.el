(defun eshell/up (n)
  (dotimes (i n) (cd "..")))

(defun eshell/~ ()
  (cd "~"))

(provide 'eshell-functions)
