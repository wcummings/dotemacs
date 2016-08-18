(require 'eclim)
(require 'eclimd)

(setq java-mode-hook
      (lambda()
	(setq c-basic-offset 2
	      indent-tabs-mode nil)
	(local-set-key (kbd "C-x j") 'jump-to-intellij)))

(defun jump-to-intellij ()
  (interactive)
  (shell-command "open -a 'IntelliJ IDEA CE'"))

(global-eclim-mode)

(custom-set-variables
 '(eclim-eclipse-dirs '("/Applications/Eclipse.app/Contents/Eclipse"))
 '(eclim-executable "/Applications/Eclipse.app/Contents/Eclipse/eclim"))

(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

;; add the emacs-eclim source
(require 'ac-emacs-eclim-source)
(add-to-list 'ac-modes 'eclim-mode)
(ac-emacs-eclim-config)

(define-key eclim-mode-map (kbd "C-h d") 'eclim-java-browse-documentation-at-point)
(define-key eclim-mode-map (kbd "M-.") 'eclim-java-browse-documentation-at-point)

(provide 'my-java-mode)
