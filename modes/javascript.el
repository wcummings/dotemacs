(require 'company)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(add-to-list 'company-backends 'company-tern)

(setq js2-basic-offset 2)

(defun my-js2-mode-hook ()
  (setq indent-tabs-mode nil)
  (setq tab-always-indent nil)
  (tern-mode t)
  (set-local-key (kbd "M-\t") 'company-complete)
  (company-mode t))

(add-hook 'js2-mode-hook 'my-js2-mode-hook)

(provide 'javascript)
