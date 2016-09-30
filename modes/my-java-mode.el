(setq java-mode-hook
      (lambda()
	(setq c-basic-offset 2
	      indent-tabs-mode nil)
	(local-set-key (kbd "C-x j") 'jump-to-intellij)))

(defun jump-to-intellij ()
  (interactive)
  (shell-command "open -a 'IntelliJ IDEA CE'"))

(provide 'my-java-mode)

