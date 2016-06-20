(require 'rainbow-delimiters)

(add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-mode-hook)

(defun my-emacs-lisp-mode-hook ()
  (setq indent-tabs-mode nil)
  (rainbow-delimiter-mode))

(provide 'my-elisp-mode)
