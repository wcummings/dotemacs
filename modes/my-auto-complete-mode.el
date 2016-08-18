;; regular auto-complete initialization
(require 'auto-complete-config)
(ac-config-default)

;; (auto-complete-mode)
(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

;; (setq ac-delay 0.0)
;; (setq ac-quick-help-delay 0.0)
;; (setq tab-always-indent 'complete)
;; (add-to-list 'completion-styles 'initials t)

(provide 'my-auto-complete-mode)
