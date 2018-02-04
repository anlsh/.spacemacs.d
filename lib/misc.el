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

(defun manga-merge (left-page right-page)
  "Meant to be used as keyboard macro for merging current manga page with last"
  (interactive
   (list buffer-file-name (progn (image-previous-file 1) buffer-file-name)))
  (let (left-page-file right-page-file)
    (setf left-page-file (buffer-file-name))
    (image-previous-file 1)
    (setf right-page-file (buffer-file-name))

    (shell-command
     (format "convert +append %s %s %s"
             (shell-quote-argument left-page)
             (shell-quote-argument right-page)
             (shell-quote-argument right-page)))
    (shell-command (format "rm %s" (shell-quote-argument left-page)))
    (image-next-file 1))
  (revert-buffer :ignore-auto :no-confirm))

(provide 'misc)
