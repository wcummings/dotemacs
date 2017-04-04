;;; edice.el --- Really, why would you want to roll dice in Emacs?

;; Copyright (C) 2012  João Távora

;; Author: João Távora <joaotavora@gmail.com>
;; Keywords: games

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; To start just use M-x roll-dice. Numbers in `edice-mode' roll that
;; number of dice

;;; Code:
(eval-when-compile
  (setq lexical-binding t))

(defun edice-dot-fn (&rest numbers)
  "Return a function of one arg for displaying a dot.

Function will return non-nil when that arg is in NUMBERS"
  (lambda (num)
    (memq num numbers)))

(defvar edice-array `((,(edice-dot-fn 4 5 6)   ,(edice-dot-fn 2)     ,(edice-dot-fn 3 4 5 6))
                      (,(edice-dot-fn 6)       ,(edice-dot-fn 1 5 3) ,(edice-dot-fn 6))
                      (,(edice-dot-fn 3 4 5 6) ,(edice-dot-fn 2)     ,(edice-dot-fn 4 5 6))))

(defgroup edice nil
  "Customization group for edice."
  :group 'games)

(defface edice-rolling-face '((default :inherit font-lock-warning-face)
                              (((class color)) :inverse-video t :weight normal ))
  "Edice face for  when the dice are rolling"
  :group 'edice)

(defface edice-stopped-face '((default :inherit font-lock-warning-face)
                              (((class color)) :inverse-video t :weight bold))
  "Edice face for when the dice have stopped rolling"
  :group 'edice)

(defface edice-history-face '((default :inherit default)
                              (((class color)) :inverse-video t))
  "Edice face for roll history"
  :group 'edice)

(defvar edice-stopped-face-name 'edice-stopped-face)

(defun edice-roll-dice-string-1 (number)
  (mapcar #'(lambda (line)
              (message "using %s" edice-stopped-face-name)
              (propertize (concat "|"
                                  (mapconcat #'(lambda (dot-fn)
                                                 (if (funcall dot-fn (abs number)) "x" " "))
                                             line
                                             " ")
                                  "|")
                          'face (if (plusp number) 'edice-rolling-face edice-stopped-face-name)))
          edice-array))

(defun edice-roll-dice-string (roll)
  (let ((dice (mapcar #'edice-roll-dice-string-1
                      roll)))
    (mapconcat #'(lambda (line)
                   (mapconcat #'identity
                              line
                              "   "))
               (apply #'maplist #'(lambda (&rest partial-dice)
                                    (mapcar #'car partial-dice))
                      dice)
               "\n")))

(define-derived-mode edice-mode text-mode "edice"
  "A major mode for rolling dice"
  (setq buffer-read-only t)
  (set (make-local-variable 'global-hl-line-mode) nil))

(defvar edice-mode-map (let ((map (make-sparse-keymap)))
                         (loop for i from 1 to 9
                               do (define-key map (format "%d" i)
                                    `(lambda () (interactive) (edice-roll ,i))))
                         map))

(defun edice-random (ndice nrolls)
  (let (collected
        stopped)
    (while (plusp nrolls)
      (let ((roll (loop for j from 0 below ndice
                        collect (if (memq j stopped)
                                    (- (abs (nth j (car collected))))
                                    (1+ (random 6))))))
        (if (every #'minusp roll)
            (setq nrolls 0)
          (when (eq nrolls 1)
            (setq roll (mapcar #'(lambda (n) (- (abs n))) roll)))
          (when (plusp (random ndice))
            (pushnew (random ndice) stopped))
          (decf nrolls))
        (push roll collected)))
    (reverse collected)))

(defvar edice-last-roll-point nil)
(defvar edice-last-roll nil)
(defun edice-roll (&optional howmany)
  "Roll some dice!"
  (interactive "nHow many dice? ")
  (with-current-buffer (pop-to-buffer (get-buffer-create "*edice!*"))
    (unless (eq major-mode 'edice-mode)
      (edice-mode))
    (recenter)
    (let ((buffer-read-only nil)
          (rolls (edice-random howmany 15))
          (delay 0.05))
      (cond (edice-last-roll
             (goto-char edice-last-roll-point)
             (delete-region (point) (point-max))
             (let ((edice-stopped-face-name 'edice-history-face))
               (insert (edice-roll-dice-string edice-last-roll))))
            (t
             (goto-char (point-max))))
      (insert (format "\n\n%s: rolling %s dice...\n\n" (current-time-string) howmany))

      (while rolls
        (delete-region (point) (point-max))
        (save-excursion
          (setq edice-last-roll-point (point))
          (insert (edice-roll-dice-string (setq edice-last-roll (pop rolls)))))
        (sit-for (setq delay (* 1.1 delay)))))))

(provide 'edice)

;; Local Variables:
;; lexical-binding: t
;; End:
;;; edice.el ends here
