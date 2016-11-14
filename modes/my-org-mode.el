(add-hook 'org-mode-hook 'my-org-mode-hook)

(setq org-directory "~/org/")

(unless (file-exists-p org-directory)
  (make-directory org-directory))

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

;; http://orgmode.org/manual/Breaking-down-tasks.html
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)


(global-set-key (kbd "C-c a a") 'org-agenda-list)

(setq org-src-fontify-natively t)

(provide 'my-org-mode)
