(add-hook 'org-mode-hook 'my-org-mode-hook)

(setq org-dir "~/org")

(defun my-org-mode-hook ()
  (add-hook 'after-save-hook 'org-mode-save-hook))

(defun org-mode-save-hook ()
  (org-save-all-org-buffers)
  (cd org-dir)
  (start-process "git-sync" "*git-sync*" "~/.emacs.d/scripts/git-sync"))

(provide 'my-org)
