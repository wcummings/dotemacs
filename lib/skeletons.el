(setq skeletor-project-directory (expand-file-name "~/development"))
(setq skeletor-user-directory (expand-file-name "~/.emacs.d/lib/skeletor"))
(skeletor-define-template "nodejs"
  :title "Node.js Project"
  :after-creation
  (lambda (dir)
    (skeletor-async-shell-command "npm init"))
  :requires-executables '(("npm" . "https://www.npmjs.com/")))

(provide 'skeletons)
