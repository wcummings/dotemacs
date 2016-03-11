(require 'flycheck)

(add-hook 'racket-mode-hook 'my-racket-mode-hook)

(defun my-racket-mode-hook ()
  (setq tab-always-indent 'complete)
  (add-to-list 'completion-styles 'initials t)
  (define-key racket-mode-map (kbd "C-c r") 'racket-run)
  (flycheck-mode)
  (require 'smartparens-racket))

(provide 'racket)
