(add-hook 'racket-mode-hook 'my-racket-mode-hook)

(defun my-racket-mode-hook ()
  (define-key racket-mode-map (kbd "C-c r") 'racket-run)
  (require 'smartparens-racket))

(provide 'racket)
