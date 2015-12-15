(defun eshell/up (n)
  (dotimes (i n) (cd "..")))

(provide 'eshell-functions)
