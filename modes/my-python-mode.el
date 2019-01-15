(setenv "PYTHONPATH" (expand-file-name "~/development/app/src/learning"))
(setenv "MYPYPATH" (expand-file-name "~/development/app/src/learning"))

(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"
        python-shell-interpreter-args "--simple-prompt -i"))

(provide 'my-python-mode)
