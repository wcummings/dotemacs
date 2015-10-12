(require 'company)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(add-to-list 'company-backends 'company-tern)

(defun my-js2-mode-hook ()
  (local-set-key "\t" 'company-complete-common)
  (tern-mode t)
  (company-mode t))

(add-hook 'js2-mode-hook 'my-js2-mode-hook)

(provide 'javascript)
