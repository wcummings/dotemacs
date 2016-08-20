(require 'eclim)
(require 'eclimd)
(require 'my-eclim-ido-mode)

(setq java-mode-hook
      (lambda()
	(setq c-basic-offset 2
	      indent-tabs-mode nil)
        (add-hook 'after-save-hook 'eclim-java-import-organize nil 'make-it-local)
	(local-set-key (kbd "C-x j") 'jump-to-intellij)))

(defun jump-to-intellij ()
  (interactive)
  (shell-command "open -a 'IntelliJ IDEA CE'"))

(global-eclim-mode)

(custom-set-variables
 '(eclim-eclipse-dirs '("/Applications/Eclipse.app/Contents/Eclipse"))
 '(eclim-executable "/Applications/Eclipse.app/Contents/Eclipse/eclim"))

(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

;; add the emacs-eclim source
(require 'ac-emacs-eclim-source)
(add-to-list 'ac-modes 'eclim-mode)
(ac-emacs-eclim-config)

(define-key eclim-mode-map (kbd "C-h d") 'eclim-java-browse-documentation-at-point)
(define-key eclim-mode-map (kbd "M-.") 'eclim-java-find-declaration)
;; (define-key eclim-mode-map (kbd "C-c i") 'eclim-java-import-organize)
;; (define-key eclim-mode-map (kbd "C-c s") 'eclim-java-find-type)
;; (define-key eclim-mode-map (kbd "C-c p") 'eclim-problems) 
(define-key eclim-mode-map (kbd "C-e C-e f l") 'eclim-file-locate-ido)

(provide 'my-java-mode)
