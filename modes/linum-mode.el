(when (not (display-graphic-p))
  (setq linum-format "%4d | "))
(global-linum-mode t)

(defcustom linum-disabled-modes-list '(eshell-mode wl-summary-mode compilation-mode org-mode text-mode dired-mode doc-view-mode image-mode rcirc-mode)
  "* List of modes disabled when global linum mode is on"
  :type '(repeat (sexp :tag "Major mode"))
  :tag " Major modes where linum is disabled: "
  :group 'linum)

;; override linum-on because there is no good way to disable global-linum-mode
;; on a per-mode basis
(defun linum-on ()
  (unless (or (minibufferp)
              (member major-mode linum-disabled-modes-list)
              (string-match "*" (buffer-name))
              (> (buffer-size) 3000000))
    (linum-mode 1)))

(provide 'linum-mode)
