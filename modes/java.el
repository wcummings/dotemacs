(setq java-mode-hook
      (lambda()
	(local-set-key (kbd "C-x j") 'jump-to-intellij)))

(defun jump-to-intellij ()
  (interactive)
  (shell-command "open -a 'IntelliJ IDEA CE'"))
