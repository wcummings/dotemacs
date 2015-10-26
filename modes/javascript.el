(require 'company)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(add-to-list 'company-backends 'company-tern)

(setq js2-basic-offset 2)

(defun my-js2-mode-hook ()
  (tern-mode t)
  (company-mode t))

(add-hook 'js2-mode-hook 'my-js2-mode-hook)

(provide 'javascript)
