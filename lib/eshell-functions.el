(defun eshell/up (n)
  (dotimes (i n) (cd "..")))

(defun eshell/h ()
  (cd "~"))

(provide 'eshell-functions)
