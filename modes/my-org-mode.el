(add-hook 'org-mode-hook 'my-org-mode-hook)

(setq org-directory "~/org/")
(setq rel-org-agenda-files '("todo.org" "gcal-agenda.org" "work.org"))
(setq org-log-done 'time)
(setq org-completion-use-ido 't)
(setq org-agenda-files (mapcar (function
				(lambda (f)
				  (concat (file-name-as-directory org-directory)
					  f)))
			       rel-org-agenda-files))

(defun my-org-mode-hook ()
  (add-hook 'after-save-hook 'my-org-mode-save-hook nil 'make-it-local))

(defun my-org-mode-save-hook ()
  (org-save-all-org-buffers)
  (git-sync-org))

(defun git-sync-org ()
  (interactive)
  (cd org-directory)
  (start-process "git-sync-org" "*git-sync-org*" "~/.emacs.d/scripts/git-sync"))

(git-sync-org)

(defcustom my-org-mode-gcal-private-url nil
  "URL to fetch .ics from gmail"
  :type '(string)
  :group 'my-customizations)

(defun sync-gcal ()
  (interactive)
  (start-process "sync-gcal" "*sync-gcal*" "~/.emacs.d/scripts/sync-gcal.sh" my-org-mode-gcal-private-url))

(when my-org-mode-gcal-private-url
  (run-with-timer 0 (* 15 60) 'sync-gcal))

(global-set-key (kbd "C-c a a") 'org-agenda-list)

(setq org-src-fontify-natively t)

(provide 'my-org-mode)
