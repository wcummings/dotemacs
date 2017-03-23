(require 'ox-rss)
(require 'magit)

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

(defcustom my-org-mode-blog-url nil
  "TRAMP URL for blog webroot"
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

(setq blog-base-directory (concat (file-name-as-directory org-directory) "blog"))

(setq blog-home-link "https://wpc.io/blog/")

(defun my-sitemap-publish (project &optional sitemap-filename)
  (let* ((project-plist (cdr project))
         (sitemap-title (plist-get project-plist :sitemap-title))
         (dir (file-name-as-directory
               (plist-get project-plist :base-directory)))
         (localdir (file-name-directory dir))
         (exclude-regexp (plist-get project-plist :exclude))
         (files (nreverse
                 (org-publish-get-base-files project exclude-regexp)))
         (sitemap-filename (concat dir (or sitemap-filename "sitemap.org")))
         (sitemap-sans-extension
          (plist-get project-plist :sitemap-sans-extension))
         (visiting (find-buffer-visiting sitemap-filename))
         file sitemap-buffer)
    (let ((sitemap-entries (get-sitemap-entries files dir)))
      (with-current-buffer
          (let ((org-inhibit-startup t))
            (setq sitemap-buffer
                  (or visiting (find-file sitemap-filename))))
        (erase-buffer)
        (insert (format "#+TITLE: %s\n\n" sitemap-title))
        (insert-sitemap-entries sitemap-entries)
        (save-buffer)))
    (or visiting (kill-buffer sitemap-buffer))))

;; adapted from https://raw.githubusercontent.com/steckerhalter/org-mode-blog/master/elisp/index.el
(defun get-sitemap-entries (files dir)
  (let (entries)
    (dolist (file files)
      (catch 'stop
        (let* (
               (env (org-combine-plists
                     (org-babel-with-temp-filebuffer file (org-export-get-environment))))
               (date (or (apply 'encode-time (org-parse-time-string
                                              (or (car (plist-get env :date)) (throw 'stop nil))))))
               (git-date (date-to-time (magit-git-string "log" "-1" "--format=%ci" file)))
               (path (file-relative-name file dir)))
          (plist-put env :path path)
          (plist-put env :parsed-date date)
          (plist-put env :git-date git-date)
          (push env entries))))
    (sort entries (lambda (a b) (time-less-p (plist-get b :parsed-date) (plist-get a :parsed-date))))))

(defun insert-sitemap-entries (entries)
  (dolist (entry entries)
    (insert
     (format "* [[file:%s][%s]]
:PROPERTIES:
:PUBDATE: %s
:RSS_PERMALINK: %s
:END:
%s
Last update: %s
Published: %s
"
             (plist-get entry :path)
             (car (plist-get entry :title))
             (format-time-string (cdr org-time-stamp-formats) (plist-get entry :parsed-date))
             (concat (file-name-sans-extension (plist-get entry :path)) ".html")
             (plist-get entry :description)
             (format-time-string "%Y-%m-%d %H:%M" (plist-get entry :git-date))
             (format-time-string "%Y-%m-%d" (plist-get entry :parsed-date))))))

(defun org-mode-blog-prepare (project-plist)
  "`index.org' should always be exported so touch the file before publishing."
  (let* ((base-directory (plist-get project-plist :base-directory))
         (buffer (find-file-noselect (expand-file-name "index.org" base-directory) t)))
    (with-current-buffer buffer
      (set-buffer-modified-p t)
      (save-buffer 0))
    (kill-buffer buffer)))

(setq org-publish-project-alist
      `(("blog-pages"
         :base-directory ,blog-base-directory
         :base-extension "org"
         :section-numbers nil
         :publishing-directory ,my-org-mode-blog-url
         :publishing-function org-html-publish-to-html
         :auto-sitemap t
         :sitemap-title "Blog"
         ;; :sitemap-sort-files anti-chronologically
         ;; :sitemap-file-entry-format "%d %t"
         :sitemap-filename "index.org"
         :sitemap-function my-sitemap-publish
         :with-toc nil
         :html-link-home "/"
         :html-link-up "/"
         :recursive t
         :preparation-function org-mode-blog-prepare)
        ("blog-images"
         :base-directory ,blog-base-directory
         :base-extension "jpg\\|gif\\|png"
         :publishing-directory ,my-org-mode-blog-url
         :publishing-function org-publish-attachment)
        ("blog-rss"
         :base-directory ,blog-base-directory
         :base-extension "org"
         :publishing-directory ,my-org-mode-blog-url
         :publishing-function org-rss-publish-to-rss
         :html-link-home ,blog-home-link
         :html-link-use-abs-url t
         :include ("index.org")
         :exclude ".*")
        ("blog" :components ("blog-pages" "blog-images" "blog-rss"))))

(setq org-src-fontify-natively t)

(provide 'my-org-mode)

