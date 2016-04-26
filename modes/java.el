(setq java-mode-hook
      (lambda()
	(local-set-key (kbd "C-x j") 'open-intellij)))

(defun open-intellij ()
  (interactive)
  (shell-command "open -a 'IntelliJ IDEA CE'"))
