;;; File to store various lisp functions which I create

(defun anish/nice-quit ()
  "Prompt to save buffers before quitting, and don't kill server"
  (interactive)
  (save-some-buffers)
  (revert-all-buffers-no-prompt)
  ;; According to https://goo.gl/XR6r7T, save-buffers-kill-terminal
  ;; will exit without killing the server. Or maybe they're just talking
  ;; about the keystroke, who knows?
  ;; #TODO Make it so that buffers actually get killed on exit
  (save-buffers-kill-terminal)
  )

;; Based on https://gist.github.com/darrik/2969415
(defun revert-all-buffers-no-prompt ()
  (mapc
   (lambda (buffer)
     (when (with-current-buffer buffer buffer-file-name)
       (switch-to-buffer buffer)
       (revert-buffer t 'no-confirm)))
   (buffer-list)))

(provide 'misc)
