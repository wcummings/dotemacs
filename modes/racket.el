(require 'flycheck)

(add-hook 'racket-mode-hook 'my-racket-mode-hook)

(defun my-racket-mode-hook ()
  (setq tab-always-indent 'complete)
  (add-to-list 'completion-styles 'initials t)
  (define-key racket-mode-map (kbd "C-c r") 'racket-run)
  (flycheck-mode)
  (require 'smartparens-racket))

(flycheck-define-checker racket
  "Racket syntax checker"
  :command ("raco" "expand" source-original)
  :error-patterns
  ((error line-start (file-name) ":" line ":" column ":" (message) line-end))
  :modes racket-mode)

(add-to-list 'flycheck-checkers 'racket)

(provide 'racket)
