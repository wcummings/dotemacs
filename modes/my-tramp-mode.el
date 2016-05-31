;; lets us sudo on the remote host
(require 'tramp)
(add-to-list 'tramp-default-proxies-alist
	     '(nil "\\`root\\'" "/ssh:%h:"))
(add-to-list 'tramp-default-proxies-alist
	     '((regexp-quote (system-name)) nil nil))
(setq tramp-default-method "ssh")

(provide 'my-tramp-mode)
