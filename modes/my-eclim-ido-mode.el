;; https://raw.githubusercontent.com/jaigupta/emacs-eclim-ide/master/eclim-ido.el
(require 'eclim)
(require 'ido)

;; Use ido mode with eclim-file-locate
(defun eclim-file-locate-ido (&optional case-insensitive)
  (interactive)
  (eclim/with-results hits ("locate_file" ("-p" "^.*$") ("-s" "workspace") (if case-insensitive '("-i" "")))
    (find-file (ido-completing-read "Select file: " (mapcar (lambda (hit) (assoc-default 'path hit)) hits)))))

(provide 'my-eclim-ido-mode)
