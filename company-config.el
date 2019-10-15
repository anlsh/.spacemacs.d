; Sourced from https://emacs.stackexchange.com/questions/13286/how-can-i-stop-the-enter-key-from-triggering-a-completion-in-company-mode

;;; Prevent suggestions from being triggered automatically. In particular,
;;; this makes it so that:
;;; - TAB will always complete the current selection.
;;; - RET will only complete the current selection if the user has explicitly
;;;   interacted with Company.
;;; - SPC will never complete the current selection.
;;;
;;; Based on:
;;; - https://github.com/company-mode/company-mode/issues/530#issuecomment-226566961
;;; - https://emacs.stackexchange.com/a/13290/12534
;;; - http://stackoverflow.com/a/22863701/3538165
;;;
;;; See also:
;;; - https://emacs.stackexchange.com/a/24800/12534
;;; - https://emacs.stackexchange.com/q/27459/12534

;; <return> is for windowed Emacs; RET is for terminal Emacs
;; (dolist (key '("<return>" "RET"))
;;   ;; Here we are using an advanced feature of define-key that lets
;;   ;; us pass an "extended menu item" instead of an interactive
;;   ;; function. Doing this allows RET to regain its usual
;;   ;; functionality when the user has not explicitly interacted with
;;   ;; Company.
;;   (define-key company-active-map (kbd key)
;;     `(menu-item nil company-complete
;;                 :filter ,(lambda (cmd)
;;                            (when (company-explicit-action-p)
;;                              cmd)))))
;; (define-key company-active-map (kbd "TAB") #'company-complete-selection)
;; (define-key company-active-map (kbd "SPC") nil)

; Pulled from some stackoverflow post, I don't think it does anything :|
;; (use-package company
;;   :custom
;;   (company-auto-complete 'company-explicit-action-p))

;; Company appears to override the above keymap based on company-auto-complete-chars.
;; Turning it off ensures we have full control.
;; (setq company-auto-complete-chars nil)

(use-package company
  :defer 0.5
  :delight
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .1)
  (company-minimum-prefix-length 3)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (company-auto-complete-chars nil)
  (global-company-mode t)

  :bind (:map company-active-map
              ("TAB" . #'company-complete-selection)
              ("<tab>" . #'company-complete-selection)
              ("SPC" . nil)
              ("RET" . nil)
              ("<return>" . nil)))
