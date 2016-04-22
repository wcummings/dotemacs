(require 'eclim)
(global-eclim-mode)
(require 'eclimd)
(require 'ac-emacs-eclim-source)

(custom-set-variables
 '(eclim-eclipse-dirs '("~/eclipse"))
 '(eclim-executable "~/eclipse/eclim"))

(add-hook 'java-mode-hook
	  (lambda ()
	    (setq help-at-pt-display-when-idle t)
	    (setq help-at-pt-timer-delay 0.1)
	    (help-at-pt-set-timer)
	    (add-to-list 'ac-sources 'ac-source-emacs-eclim)
	    (require 'autocomplete)
	    (eclim-mode t)))

(provide 'java)
