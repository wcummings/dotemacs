(require 'flymake)

(add-hook 'racket-mode-hook 'my-racket-mode-hook)

(defun my-racket-mode-hook ()
  (setq tab-always-indent 'complete)
  (add-to-list 'completion-styles 'initials t)
  (define-key racket-mode-map (kbd "C-c r") 'racket-run)
  (flymake-mode)
  (require 'smartparens-racket))

(defun flymake-racket-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
	 (local-file (file-relative-name
		      temp-file
		      (file-name-directory buffer-file-name))))
    (list "raco" (list "expand" local-file))))

(push '("\\.rkt\\'" flymake-racket-init)
      flymake-allowed-file-name-masks)

(provide 'racket)
