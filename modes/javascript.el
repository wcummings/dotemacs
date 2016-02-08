(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(setq js2-basic-offset 2)

(defun my-js2-mode-hook ()
  (setq indent-tabs-mode nil)
  (setq tab-always-indent 'complete)
  ;;(add-to-list 'completion-styles 'initials t)
  (setq tern-ac-on-dot t)
  (tern-mode t)
  (require 'autocomplete))

(add-hook 'js2-mode-hook 'my-js2-mode-hook)
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))

(provide 'javascript)
