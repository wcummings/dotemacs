(setq java-mode-hook
      (lambda()
	;; (local-set-key (kbd "C-x j") 'jump-to-intellij)
	(setq c-basic-offset 2
	      indent-tabs-mode nil)
	(local-set-key (kbd "M-.") 'eclim-java-find-declaration)
	(setq help-at-pt-display-when-idle t)
	(setq help-at-pt-timer-delay 0.1)
	(help-at-pt-set-timer)
	(require 'autocomplete)
	(require 'ac-emacs-eclim-source)
     	(ac-emacs-eclim-config)))


;; (defun jump-to-intellij ()
;;   (interactive)
;;   (shell-command "open -a 'IntelliJ IDEA CE'"))

(require 'eclim)
(require 'eclimd)
(global-eclim-mode)

(custom-set-variables
  '(eclim-eclipse-dirs '("/opt/homebrew-cask/Caskroom/eclipse-java/4.5.2/Eclipse.app/Contents/Eclipse"))
  '(eclim-executable "/opt/homebrew-cask/Caskroom/eclipse-java/4.5.2/Eclipse.app/Contents/Eclipse/eclim"))

(setq eclimd-wait-for-process nil)

(provide 'java)
