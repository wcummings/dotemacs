(add-hook 'org-mode-hook 'my-org-mode-hook)

(setq org-directory "~/org")
(setq org-log-done 'time)
(setq org-completion-use-ido 't)

(defun my-org-mode-hook ()
  (add-hook 'after-save-hook 'org-mode-save-hook nil 'make-it-local))

(defun org-mode-save-hook ()
  (org-save-all-org-buffers)
  (git-sync-org))

(defun git-sync-org ()
  (cd org-directory)
  (start-process "git-sync-org" "*git-sync-org*" "~/.emacs.d/scripts/git-sync"))

(git-sync-org)

(provide 'my-org)
