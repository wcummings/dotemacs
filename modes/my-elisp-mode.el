(require 'rainbow-delimiters)

(add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-mode-hook)

(defun my-emacs-lisp-mode-hook ()
  (paredit-mode)
  (setq indent-tabs-mode nil)
  (rainbow-delimiters-mode))

(provide 'my-elisp-mode)
