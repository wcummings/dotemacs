(require 'lua-mode)

(defun my-lua-mode-hook ()
  (setq indent-tabs-mode nil)
  (setq tab-always-indent nil)
  (setq lua-indent-level 4))

(add-hook 'lua-mode-hook 'my-lua-mode-hook)

(provide 'my-lua-mode)
