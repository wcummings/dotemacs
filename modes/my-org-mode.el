(add-hook 'org-mode-hook 'my-org-mode-hook)

(setq org-directory "~/org")
(setq org-agenda-files '("todo.org" "gcal_agenda.org"))
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

(defcustom my-org-mode-gcal-private-url nil
  "URL to fetch .ics from gmail"
  :type '(string)
  :group 'my-customizations)

(defun sync-gcal ()
  (start-process "sync-gcal" "*sync-gcal*" "~/.emacs.d/scripts/syncgcal.sh" my-org-mode-gcal-private-url))

(when my-org-mode-gcal-private-url
  (run-with-timer 0 (* 15 60) 'sync-gcal))

(global-set-key (kbd "C-c a a") 'org-agenda-list)

(provide 'my-org-mode)
