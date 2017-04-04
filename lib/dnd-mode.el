(require 'button-lock)
(require 'decide)

(make-variable-buffer-local
  (defvar *dnd-mode-buttons* '()))

(defvar *dnd-mode-max-ndice* 10)
(defvar *dnd-mode-nsides* '(2 3 4 6 8 10 20))

(define-minor-mode dnd-mode
  "A minor mode for D&D"
  :lighter " D&D"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-c C-r") 'dnd-mode-roll-at-point)
            map)
  (if dnd-mode
      (progn
        (dnd-mode-highlight-dice-rolls)
        (button-lock-mode))
    (dnd-mode-unhighlight-dice-rolls)))

(defun dnd-mode-highlight-dice-rolls ()
  (dolist (ndice (number-sequence 1 *dnd-mode-max-ndice*))
    (dolist (nsides *dnd-mode-nsides*)
      (lexical-let ((spec-string (format "%dd%d" ndice nsides)))
        (add-to-list '*dnd-mode-buttons*
                     (button-lock-set-button
                      spec-string
                      (lambda ()
                        (interactive)
                        (dnd-mode-roll-dice spec-string))
                      :face 'link :face-policy 'prepend))))))

(defun dnd-mode-unhighlight-dice-rolls ()
  (dolist (button *dnd-mode-buttons*)
    (button-lock-unset-button button))
  (setq *dnd-buttons* '()))

(defun dnd-mode-roll-dice (spec-string)
  (let ((buffer-read-only t))
    (decide-roll-dice spec-string)))

(defun dnd-mode-roll-at-point ()
  (interactive)
  (dnd-mode-roll-dice (thing-at-point 'word)))

(provide 'dnd-mode)
